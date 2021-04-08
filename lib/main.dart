import 'dart:math';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

void main() {
  runApp(MyApp());
}

/// The application that contains datagrid on it.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion DataGrid Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

/// The home page of the application which hosts the datagrid.
class MyHomePage extends StatefulWidget {
  /// Creates the home page.

  @override
  _PagingDataGridState createState() => _PagingDataGridState();
}

class _PagingDataGridState extends State<MyHomePage> {
  static const double dataPagerHeight = 60;

  final int rowsPerPage = 15;

  List<OrderInfo> dataSource = [];
  List<OrderInfo> paginatedDataSource = [];

  late _OrderInfoDataSource orderInfoDataSource;

  final List<DateTime> shippedDate = [];
  final Random random = Random();
  final Map<String, List<String>> shipCity = {
    'Argentina': ['Rosario'],
    'Austria': ['Graz', 'Salzburg'],
    'Belgium': ['Bruxelles', 'Charleroi'],
    'Brazil': ['Campinas', 'Resende', 'Recife', 'Manaus'],
    'Canada': ['Montréal', 'Tsawassen', 'Vancouver'],
    'Denmark': ['Århus', 'København'],
    'Finland': ['Helsinki', 'Oulu'],
    'France': [
      'Lille',
      'Lyon',
      'Marseille',
      'Nantes',
      'Paris',
      'Reims',
      'Strasbourg',
      'Toulouse',
      'Versailles'
    ],
    'Germany': [
      'Aachen',
      'Berlin',
      'Brandenburg',
      'Cunewalde',
      'Frankfurt',
      'Köln',
      'Leipzig',
      'Mannheim',
      'München',
      'Münster',
      'Stuttgart'
    ],
    'Ireland': ['Cork'],
    'Italy': ['Bergamo', 'Reggio', 'Torino'],
    'Mexico': ['México D.F.'],
    'Norway': ['Stavern'],
    'Poland': ['Warszawa'],
    'Portugal': ['Lisboa'],
    'Spain': ['Barcelona', 'Madrid', 'Sevilla'],
    'Sweden': ['Bräcke', 'Luleå'],
    'Switzerland': ['Bern', 'Genève'],
    'UK': ['Colchester', 'Hedge End', 'London'],
    'USA': [
      'Albuquerque',
      'Anchorage',
      'Boise',
      'Butte',
      'Elgin',
      'Eugene',
      'Kirkland',
      'Lander',
      'Portland',
      'San Francisco',
      'Seattle',
    ],
    'Venezuela': ['Barquisimeto', 'Caracas', 'I. de Margarita', 'San Cristóbal']
  };

  List<String> genders = [
    'Male',
    'Female',
    'Female',
    'Female',
    'Male',
    'Male',
    'Male',
    'Male',
    'Male',
    'Male',
    'Male',
    'Male',
    'Female',
    'Female',
    'Female',
    'Male',
    'Male',
    'Male',
    'Female',
    'Female',
    'Female',
    'Male',
    'Male',
    'Male',
    'Male'
  ];

  List<String> firstNames = [
    'Kyle',
    'Gina',
    'Irene',
    'Katie',
    'Michael',
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
    'Zeke',
    'Oscar',
    'Ralph',
  ];

  List<String> lastNames = [
    'Adams',
    'Crowley',
    'Ellis',
    'Gable',
    'Irvine',
    'Keefe',
    'Mendoza',
    'Owens',
    'Rooney',
    'Waddell',
    'Thomas',
    'Betts',
    'Doran',
    'Holmes',
    'Jefferson',
    'Landry',
    'Newberry',
    'Perez',
    'Spencer',
    'Vargas',
    'Grimes',
    'Edwards',
    'Stark',
    'Cruise',
    'Fitz',
    'Chief',
    'Blanc',
    'Perry',
    'Stone',
    'Williams',
    'Lane',
    'Jobs'
  ];

  List<String> customerID = [
    'Alfki',
    'Frans',
    'Merep',
    'Folko',
    'Simob',
    'Warth',
    'Vaffe',
    'Furib',
    'Seves',
    'Linod',
    'Riscu',
    'Picco',
    'Blonp',
    'Welli',
    'Folig'
  ];

  List<String> shipCountry = [
    'Argentina',
    'Austria',
    'Belgium',
    'Brazil',
    'Canada',
    'Denmark',
    'Finland',
    'France',
    'Germany',
    'Ireland',
    'Italy',
    'Mexico',
    'Norway',
    'Poland',
    'Portugal',
    'Spain',
    'Sweden',
    'UK',
    'USA',
  ];

  List<OrderInfo> getOrderDetails(int count) {
    shippedDate
      ..clear()
      ..addAll(_getDateBetween(2000, 2014, count));
    List<OrderInfo> orderDetails = [];

    for (int i = 10001; i <= count + 10000; i++) {
      final String _shipCountry =
          shipCountry[random.nextInt(shipCountry.length)];
      final List<String>? _shipCityColl = shipCity[_shipCountry];
      final DateTime shippedData = shippedDate[i - 10001];
      final DateTime orderedData =
          DateTime(shippedData.year, shippedData.month, shippedData.day - 2);
      orderDetails.add(OrderInfo(
        i.toString(),
        customerID[random.nextInt(15)],
        next(1700, 1800).toString(),
        firstNames[random.nextInt(15)],
        lastNames[random.nextInt(15)],
        genders[random.nextInt(5)],
        _shipCityColl![random.nextInt(_shipCityColl.length)],
        _shipCountry,
        (random.nextInt(1000) + random.nextDouble()),
        shippedData,
        orderedData,
        (i + (random.nextInt(10)) > 2) ? true : false,
      ));
    }
    return orderDetails;
  }

  int next(int min, int max) => min + random.nextInt(max - min);

  List<DateTime> _getDateBetween(int startYear, int endYear, int count) {
    List<DateTime> date = [];

    for (int i = 0; i < count; i++) {
      int year = next(startYear, endYear);
      int month = random.nextInt(13);
      int day = random.nextInt(31);

      date.add(DateTime(year, month, day));
    }

    return date;
  }

  @override
  void initState() {
    super.initState();
    dataSource = getOrderDetails(300);
    paginatedDataSource = dataSource.getRange(0, 19).toList(growable: false);
    orderInfoDataSource = _OrderInfoDataSource(
        dataSource: dataSource,
        paginatedDataSource: paginatedDataSource,
        rowsPerPage: rowsPerPage);
  }

  Widget _buildDataGrid(BoxConstraints constraint) {
    return SfDataGrid(source: orderInfoDataSource, columns: <GridColumn>[
      GridTextColumn(
        columnName: 'orderID',
        label: Container(
            child: Text(
              'Order ID',
              overflow: TextOverflow.ellipsis,
            ),
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.centerRight),
      ),
      GridTextColumn(
          columnName: 'customerID',
          width: 135,
          label: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Customer Name',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridTextColumn(
        columnName: 'orderDate',
        width: 109,
        label: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: Text(
            'Order Date',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridTextColumn(
        columnName: 'freight',
        label: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(
            'Freight',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridTextColumn(
        columnName: 'shippingDate',
        label: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: Text(
            'Shipped Date',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridTextColumn(
          columnName: 'shipCountry',
          label: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Ship Country',
              overflow: TextOverflow.ellipsis,
            ),
          )),
    ]);
  }

  Widget _buildDataPager() {
    return SfDataPager(
      delegate: orderInfoDataSource,
      pageCount: dataSource.length / rowsPerPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('DataPager with DataGrid Demo')),
        body: LayoutBuilder(builder: (context, constraint) {
          return Column(
            children: [
              SizedBox(
                  height: constraint.maxHeight - dataPagerHeight,
                  width: constraint.maxWidth,
                  child: _buildDataGrid(constraint)),
              Container(
                height: dataPagerHeight,
                decoration: BoxDecoration(
                    color:
                        SfTheme.of(context).dataPagerThemeData.backgroundColor,
                    border: Border(
                        top: BorderSide(
                            width: .5,
                            color: SfTheme.of(context)
                                .dataGridThemeData
                                .gridLineColor),
                        bottom: BorderSide.none,
                        left: BorderSide.none,
                        right: BorderSide.none)),
                child: Align(
                    alignment: Alignment.center, child: _buildDataPager()),
              )
            ],
          );
        }));
  }
}

class _OrderInfoDataSource extends DataGridSource {
  _OrderInfoDataSource(
      {required List<OrderInfo> dataSource,
      required List<OrderInfo> paginatedDataSource,
      required int rowsPerPage}) {
    _dataSource = dataSource;
    _paginatedDataSource = paginatedDataSource;
    _rowsPerPage = rowsPerPage;
  }

  late List<OrderInfo> _dataSource;
  late List<OrderInfo> _paginatedDataSource;
  late int _rowsPerPage;

  @override
  List<DataGridRow> get rows => _paginatedDataSource.map<DataGridRow>((e) {
        return DataGridRow(cells: [
          DataGridCell(columnName: 'orderID', value: e.orderID),
          DataGridCell(columnName: 'customerID', value: e.customerID),
          DataGridCell(columnName: 'orderDate', value: e.orderData),
          DataGridCell(columnName: 'freight', value: e.freight),
          DataGridCell(columnName: 'shippingDate', value: e.shippingDate),
          DataGridCell(columnName: 'shipCountry', value: e.shipCountry),
        ]);
      }).toList(growable: false);

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        padding: EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            row.getCells()[1].value.toString(),
            overflow: TextOverflow.ellipsis,
          )),
      Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: Text(
            DateFormat.yMd().format(row.getCells()[2].value).toString(),
            overflow: TextOverflow.ellipsis,
          )),
      Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(
            NumberFormat.currency(locale: 'en_US', symbol: '\$')
                .format(row.getCells()[3].value)
                .toString(),
            overflow: TextOverflow.ellipsis,
          )),
      Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: Text(
            DateFormat.yMd().format(row.getCells()[4].value).toString(),
            overflow: TextOverflow.ellipsis,
          )),
      Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            row.getCells()[5].value.toString(),
            overflow: TextOverflow.ellipsis,
          )),
    ]);
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * _rowsPerPage;
    int endIndex = startIndex + _rowsPerPage;
    _paginatedDataSource =
        _dataSource.getRange(startIndex, endIndex).toList(growable: false);
    notifyDataSourceListeners();
    return true;
  }
}

/// Order Details
class OrderInfo {
  OrderInfo(
      this.orderID,
      this.employeeID,
      this.customerID,
      this.firstName,
      this.lastName,
      this.gender,
      this.shipCity,
      this.shipCountry,
      this.freight,
      this.shippingDate,
      this.orderData,
      this.isClosed);

  final String orderID;
  final String employeeID;
  final String customerID;
  final String firstName;
  final String lastName;
  final String gender;
  final String shipCity;
  final String shipCountry;
  final double freight;
  final DateTime shippingDate;
  final DateTime orderData;
  final bool isClosed;
}
