import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double pctSpend;

  ChartBar(this.label, this.spendingAmount, this.pctSpend);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints){
      return Column(
      children: <Widget>[
        Container(
          height: constraints.maxHeight*.15,
          child: FittedBox(child: Text('\$${spendingAmount.toString()}')),
        ),
        SizedBox(
          height: constraints.maxHeight*.05,
        ),
        Container(
          height: constraints.maxHeight*0.6,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(220, 220, 220, 1),
                ),
              ),
              FractionallySizedBox(
                heightFactor: pctSpend,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight*0.05,
        ),
        Container(height:constraints.maxHeight*.15,child: Text(label)),
      ],
    );
    });
  }
}
