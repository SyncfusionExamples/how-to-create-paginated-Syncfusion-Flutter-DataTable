/// Dart import
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DataGridDemo(),
    );
  }
}

/// Renders datagrid with selection option(single/multiple and select/unselect)
class DataGridDemo extends StatefulWidget {
  /// Creates datagrid with selection option(single/multiple and select/unselect)
  const DataGridDemo({Key key}) : super(key: key);

  @override
  _DataGridDemoState createState() => _DataGridDemoState();
}

List<Product> _productData;
final math.Random _random = math.Random();

class _DataGridDemoState extends State<DataGridDemo> {
  _DataGridDemoState();

  final _PagingDataGridSource _pagingDataGridSource = _PagingDataGridSource();

  List<GridColumn> _columns;

  @override
  void initState() {
    super.initState();
    _productData = generateList(60);
    _columns = getColumns();
  }

  List<GridColumn> getColumns() {
    List<GridColumn> columns;
    columns = <GridColumn>[
      GridNumericColumn(mappingName: 'id', headerText: 'ID'),
      GridNumericColumn(mappingName: 'productId', headerText: 'Product ID'),
      GridTextColumn(mappingName: 'name', headerText: 'Customer Name'),
      GridTextColumn(mappingName: 'product', headerText: 'Product'),
      GridDateTimeColumn(
          mappingName: 'orderDate',
          headerText: 'Order Date',
          dateFormat: DateFormat.yMd()),
    ];
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DataGrid Demo'),
        ),
        body: LayoutBuilder(
          builder: (context, constrains) {
            return Column(
              children: [
                Container(
                    height: constrains.maxHeight - 70,
                    width: constrains.maxWidth,
                    child: SfDataGrid(
                        source: _pagingDataGridSource, columns: _columns)),
                Expanded(
                    child: SfDataPager(
                  delegate: _pagingDataGridSource,
                  rowsPerPage: 10,
                ))
              ],
            );
          },
        ));
  }
}

// ignore: public_member_api_docs
class Product {
  Product(this.id, this.productId, this.product, this.quantity, this.unitPrice,
      this.city, this.orderDate, this.name);
  final int id;
  final int productId;
  final String product;
  final int quantity;
  final double unitPrice;
  final String city;
  final DateTime orderDate;
  final String name;
}

class _PagingDataGridSource extends DataGridSource<Product> {
  _PagingDataGridSource();

  List<Product> _pageList = [];

  @override
  List<Product> get dataSource => _pageList;
  @override
  Object getValue(Product _product, String columnName) {
    switch (columnName) {
      case 'id':
        return _product.id;
        break;
      case 'product':
        return _product.product;
        break;
      case 'productId':
        return _product.productId;
        break;
      case 'unitPrice':
        return _product.unitPrice;
        break;
      case 'quantity':
        return _product.quantity;
        break;
      case 'city':
        return _product.city;
        break;
      case 'orderDate':
        return _product.orderDate;
        break;
      case 'name':
        return _product.name;
        break;
      default:
        return 'empty';
        break;
    }
  }

  @override
  int get rowCount => _productData.length;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex,
      int startRowIndex, int rowsPerPage) async {
    _pageList = _productData
        .getRange(startRowIndex, startRowIndex + rowsPerPage)
        .toList(growable: false);
    notifyDataSourceListeners();
    return true;
  }
}

final List<String> _product = <String>[
  'Lax',
  'Chocolate',
  'Syrup',
  'Chai',
  'Bags',
  'Meat',
  'Filo',
  'Cashew',
  'Walnuts',
  'Geitost',
  'Cote de',
  'Crab',
  'Chang',
  'Cajun',
  'Gum',
  'Filo',
  'Cashew',
  'Walnuts',
  'Geitost',
  'Bag',
  'Meat',
  'Filo',
  'Cashew',
  'Geitost',
  'Cote de',
  'Crab',
  'Chang',
  'Cajun',
  'Gum',
];

final List<String> _cities = <String>[
  'Bruxelles',
  'Rosario',
  'Recife',
  'Graz',
  'Montreal',
  'Tsawassen',
  'Campinas',
  'Resende',
];

final List<int> _productId = <int>[
  3524,
  2523,
  1345,
  5243,
  1803,
  4932,
  6532,
  9475,
  2435,
  2123,
  3652,
  4523,
  4263,
  3527,
  3634,
  4932,
  6532,
  9475,
  2435,
  2123,
  6532,
  9475,
  2435,
  2123,
  4523,
  4263,
  3527,
  3634,
  4932,
];

final List<DateTime> _orderDate = <DateTime>[
  DateTime.now(),
  DateTime(2002, 8, 27),
  DateTime(2015, 7, 4),
  DateTime(2007, 4, 15),
  DateTime(2010, 12, 23),
  DateTime(2010, 4, 20),
  DateTime(2004, 6, 13),
  DateTime(2008, 11, 11),
  DateTime(2005, 7, 29),
  DateTime(2009, 4, 5),
  DateTime(2003, 3, 20),
  DateTime(2011, 3, 8),
  DateTime(2013, 10, 22),
];

List<String> _names = [
  'Kyle',
  'Gina',
  'Irene',
  'Katie',
  'Michael',
  'Oscar',
  'Ralph',
  'Torrey',
  'William',
  'Bill',
  'Daniel',
  'Frank',
  'Brenda',
  'Danielle',
  'Fiona',
  'Howard',
  'Jack',
  'Larry',
  'Holly',
  'Jennifer',
  'Liz',
  'Pete',
  'Steve',
  'Vince',
  'Zeke'
];

// ignore: public_member_api_docs
List<Product> generateList(int count) {
  final List<Product> productData = <Product>[];
  for (int i = 0; i < count; i++) {
    productData.add(
      Product(
          i + 1000,
          _productId[_random.nextInt(10)],
          _product[_random.nextInt(10)],
          _random.nextInt(10),
          70.0 + _random.nextInt(10),
          _cities[i < _cities.length ? i : _random.nextInt(_cities.length - 1)],
          _orderDate[_random.nextInt(_orderDate.length - 1)],
          _names[_random.nextInt(10)]),
    );
  }

  return productData;
}
