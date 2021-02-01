import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _list;
  final Function _deleteTransaction;

  TransactionList(this._list, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _list.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No Transactions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('Rs. ${_list[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    '${_list[index].title}',
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    '${DateFormat.yMMMd().format(_list[index].date)}',
                  ),
                  trailing: MediaQuery.of(context).size.width > 500
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteTransaction(_list[index].id),
                          textColor: Theme.of(context).errorColor,
                          label: Text('Delete'),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteTransaction(_list[index].id),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
            itemCount: _list.length,
          );
  }
}
