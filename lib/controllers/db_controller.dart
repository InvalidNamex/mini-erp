import 'dart:io';

import 'package:get/get.dart';
import 'package:mini_erp/models/item_models/item_taxes_model.dart';
import 'package:mini_erp/models/item_models/price_list_model.dart';
import 'package:mini_erp/models/item_models/taxes_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../models/item_models/category_model.dart';
import '../models/item_models/item_model.dart';

class DatabaseController extends GetxController {
  static DatabaseController instance = Get.find();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    // Directory dbDirectory = await getApplicationDocumentsDirectory();
    List<Directory>? dbDirectory = await getExternalStorageDirectories();
    String dbString = dbDirectory![0].path;
    // String dbString = dbDirectory.path;

    final path = join(dbString, filePath);
    final options = OpenDatabaseOptions(version: 1, onCreate: _createDB);
    return await databaseFactoryFfi.openDatabase(path, options: options);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';
    const intType = 'INTEGER';
    const realType = 'REAL';
    await db.execute('''
    PRAGMA foreign_keys = ON;
    ''');
    // Create the ItemTable table
    await db.execute('''
    CREATE TABLE ItemTable (
      item_id $idType,
      item_name $textType,
      item_desc $textType,
      item_min_quantity $realType,
      item_stock $realType,
      item_category $intType,
      FOREIGN KEY (item_category) REFERENCES CategoryTable(category_id) ON DELETE CASCADE
    )
  ''');

    // Create the UnitTable table
    await db.execute('''
    CREATE TABLE UnitTable (
      unit_id $idType,
      unit_name $textType
    )
  ''');

    // Create the ItemUnitTable table
    await db.execute('''
    CREATE TABLE ItemUnitTable (
      item_id $intType,
      unit_id $intType,
      conversion_factor $intType,
      FOREIGN KEY (item_id) REFERENCES ItemTable(item_id) ON DELETE CASCADE,
      FOREIGN KEY (unit_id) REFERENCES UnitTable(unit_id) ON DELETE CASCADE
    )
  ''');

    // Create the TaxesTable table (from the previous example)
    await db.execute('''
    CREATE TABLE TaxesTable (
      tax_id $idType,
      tax_name $textType
    )
  ''');

    // Create the ItemTaxesTable table (from the previous example)
    await db.execute('''
    CREATE TABLE ItemTaxesTable (
      item_id $intType,
      tax_id $intType,
      tax_percentage $intType,
      FOREIGN KEY (item_id) REFERENCES ItemTable(item_id) ON DELETE CASCADE,
      FOREIGN KEY (tax_id) REFERENCES TaxesTable(tax_id) ON DELETE CASCADE
    )
  ''');

    // Create the CategoryTable table (from the previous example)
    await db.execute('''
    CREATE TABLE CategoryTable (
      category_id $idType,
      category_name $textType
    )
  ''');

    // Create the PriceListTable table (from the previous example)
    await db.execute('''
    CREATE TABLE PriceListTable (
      price_list_id $idType,
      price_list_name $textType
    )
  ''');

    // Create the ItemPriceListTable linking table (from the previous example)
    await db.execute('''
    CREATE TABLE ItemPriceListTable (
      item_id $intType,
      price_list_id $intType,
      price $realType,
      FOREIGN KEY (item_id) REFERENCES ItemTable(item_id) ON DELETE CASCADE,
      FOREIGN KEY (price_list_id) REFERENCES PriceListTable(price_list_id) ON DELETE CASCADE
    )
  ''');

    // Create the VendorTable table
    await db.execute('''
    CREATE TABLE VendorTable (
      vendor_id $idType,
      vendor_name $textType,
      vendor_address $textType,
      vendor_phone $textType,
      vendor_notes $textType,
      vendor_tax_code $textType,
      vendor_reg_no $textType
    )
  ''');

    // Create the ClientTable table
    await db.execute('''
    CREATE TABLE ClientTable (
      client_id $idType,
      client_price_list $intType,
      client_max_limit $realType,
      client_name $textType,
      client_address $textType,
      client_phone $textType,
      client_notes $textType,
      client_tax_code $textType,
      client_reg_no $textType,
      FOREIGN KEY (client_price_list) REFERENCES PriceListTable(price_list_id) ON DELETE CASCADE
    )
  ''');
    // Create the CartItemTable table
    await db.execute('''
  CREATE TABLE CartItemTable (
    cart_item_id $idType,
    cart_item_name $textType,
    cart_item_price $realType,
    cart_item_quantity $realType,
    cart_item_total $realType
  )
''');

// Create the CartTable table
    await db.execute('''
  CREATE TABLE CartTable (
    cart_id INTEGER PRIMARY KEY AUTOINCREMENT,
    date_timestamp TEXT
  )
''');
// Create the CartMasterTable table
    await db.execute('''
  CREATE TABLE CartMasterTable (
    cart_master_id INTEGER PRIMARY KEY AUTOINCREMENT,
    cart_id INTEGER,
    cart_item_id INTEGER,
    `total` REAL,
    `discount` REAL,
    `paid` REAL,
    `remaining` REAL,
    `client_name` TEXT,
    `note` TEXT,
    `pay_type` INTEGER,
    FOREIGN KEY (cart_id) REFERENCES CartTable(cart_id) ON DELETE CASCADE,
    FOREIGN KEY (cart_item_id) REFERENCES CartItemTable(cart_item_id) ON DELETE CASCADE
  )
''');
  }

  // create/insert into tables
  Future<ItemModel> addItem(ItemModel itemModel) async {
    final db = await instance.database;
    final id = await db.insert('ItemTable', itemModel.toJson());
    return itemModel.copy(itemID: id);
  }

  Future<CategoryModel> addCategory(CategoryModel categoryModel) async {
    final db = await instance.database;
    final id = await db.insert('CategoryTable', categoryModel.toJson());
    return categoryModel.copy(categoryID: id);
  }

  Future<PriceListModel> addPriceList(PriceListModel priceListModel) async {
    final db = await instance.database;
    final id = await db.insert('PriceListTable', priceListModel.toJson());
    return priceListModel.copy(priceListID: id);
  }

  Future<TaxesModel> addTax(TaxesModel taxesModel) async {
    final db = await instance.database;
    final id = await db.insert('TaxesTable', taxesModel.toJson());
    return taxesModel.copy(taxID: id);
  }

  // read single record from table
  Future<ItemModel> readItem(int id) async {
    final db = await instance.database;
    final maps = await db.query('ItemTable',
        columns: ['item_name', 'item_desc'],
        where: 'item_id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return ItemModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  // read all records from table
  Future<List<CategoryModel>> readCategories() async {
    final db = await instance.database;
    // example of available options final result = await db.query(areasTable, where: );
    final result = await db.query('CategoryTable');
    // final result = await db.rawQuery() <----- for sql queries
    return result.map((json) => CategoryModel.fromJson(json)).toList();
  }

  Future<List<PriceListModel>> readPriceLists() async {
    final db = await instance.database;
    // example of available options final result = await db.query(areasTable, where: );
    final result = await db.query('PriceListTable');
    // final result = await db.rawQuery() <----- for sql queries
    return result.map((json) => PriceListModel.fromJson(json)).toList();
  }

  Future<List<TaxesModel>> readTaxesNames() async {
    final db = await instance.database;
    // example of available options final result = await db.query(areasTable, where: );
    final result = await db.query('TaxesTable');
    // final result = await db.rawQuery() <----- for sql queries
    return result.map((json) => TaxesModel.fromJson(json)).toList();
  }

  Future<List<PriceListModel>> readPriceListNames() async {
    final db = await instance.database;
    // example of available options final result = await db.query(areasTable, where: );
    final result = await db.query('PriceListTable');
    // final result = await db.rawQuery() <----- for sql queries
    return result.map((json) => PriceListModel.fromJson(json)).toList();
  }

  Future<List<ItemTaxesModel>> readTaxes() async {
    final db = await instance.database;
    // example of available options final result = await db.query(areasTable, where: );
    final result = await db.query('ItemTaxesTable');
    // final result = await db.rawQuery() <----- for sql queries
    return result.map((json) => ItemTaxesModel.fromJson(json)).toList();
  }

  // update record
  // Future updateAreaName(String newName, int id) async {
  //   final db = await instance.database;
  //   return db.rawUpdate(
  //       'UPDATE $areasTable SET ${AreaModelFields.name} = ? WHERE ${AreaModelFields.id} = ?',
  //       [newName, id]);
  // }

  Future updateCategory(int id, String categoryName) async {
    final db = await instance.database;
    return db.update('CategoryTable',
        CategoryModel(categoryID: id, categoryName: categoryName).toJson(),
        where: 'category_id = ?', whereArgs: [id]);
  }

  Future updatePriceList(int id, String priceListName) async {
    final db = await instance.database;
    return db.update('PriceListTable',
        PriceListModel(priceListID: id, priceListName: priceListName).toJson(),
        where: 'price_list_id = ?', whereArgs: [id]);
  }

  Future updateTax(int id, String priceListName) async {
    final db = await instance.database;
    return db.update(
        'TaxesTable', TaxesModel(taxID: id, taxName: priceListName).toJson(),
        where: 'tax_id = ?', whereArgs: [id]);
  }

  // Future updateTaxPercentage({required int taxID, required percentage}) async {
  //   final db = await instance.database;
  //   await db.rawUpdate(
  //       'UPDATE TaxesTable SET tax_percentage = ? WHERE tax_id = ?',
  //       [percentage, taxID]);
  // }

  // delete record
  Future deleteCategory(int id) async {
    final db = await instance.database;
    await db.delete('CategoryTable', where: 'category_id = ?', whereArgs: [id]);
  }

  Future deletePriceList(int id) async {
    final db = await instance.database;
    await db
        .delete('PriceListTable', where: 'price_list_id = ?', whereArgs: [id]);
  }

  Future deleteTax(int id) async {
    final db = await instance.database;
    await db.delete('TaxesTable', where: 'tax_id = ?', whereArgs: [id]);
  }
  // REPORTS
  // Future<List<ClientModel>> getBrokenCounters() async {
  //   final db = await instance.database;
  //   final result = await db.query(clientsTable,
  //       where: '${ClientModelFields.elhasr1} = ?', whereArgs: ['معطل']);
  //   return result.map((json) => ClientModel.fromJson(json)).toList();
  // }

  // close connection to database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
