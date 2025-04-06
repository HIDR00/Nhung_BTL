import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/model/chart_model.dart';

class ChartHistory extends StatefulWidget {
  const ChartHistory({super.key});

  @override
  State<ChartHistory> createState() => _ChartHistoryState();
}

class _ChartHistoryState extends State<ChartHistory> {
  late DatabaseReference Chart;
  List<ChartModel> lCharts = [];

  @override
  void initState() {
    super.initState();
    Chart = FirebaseDatabase.instance.ref('Chart');
    Chart.onValue.listen((DatabaseEvent event) {
      final reponse = event.snapshot.value as Map;
      List<ChartModel> tmp = [];

      reponse.forEach((key, value) {
        Map<String, dynamic> chartMap = Map<String, dynamic>.from(value as Map);
        tmp.add(ChartModel.fromMap(chartMap));
      });
      setState(() {
        lCharts = tmp;
      });
      print(lCharts[0].hum);
    });
  }

  Widget leftTitlesWidget(double value, TitleMeta meta) {
    const style = TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey);
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 10:
        text = '10';
        break;
      case 20:
        text = '20';
        break;
      case 30:
        text = '30';
        break;
      case 40:
        text = '40';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.center);
  }

  Widget rightTitlesWidget(double value, TitleMeta meta) {
    const style = TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey);
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 10:
        text = '25';
        break;
      case 20:
        text = '50';
        break;
      case 30:
        text = '75';
        break;
      case 40:
        text = '100';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.center);
  }

  Widget bottomTitlesWidget(double value, TitleMeta meta) {
    const style = TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text(
          '0',
          style: style,
        );
        break;
      case 3:
        text = const Text(
          '3',
          style: style,
        );
        break;
      case 6:
        text = const Text(
          '6',
          style: style,
        );
        break;
      case 9:
        text = const Text(
          '9',
          style: style,
        );
        break;
      case 12:
        text = const Text(
          '12',
          style: style,
        );
        break;
      case 15:
        text = const Text(
          '15',
          style: style,
        );
        break;
      case 18:
        text = const Text(
          '18',
          style: style,
        );
        break;
      case 21:
        text = const Text(
          '21',
          style: style,
        );
        break;
      case 24:
        text = const Text(
          '24',
          style: style,
        );
        break;
      default:
        text = const Text('');
        break;
    }
    return SideTitleWidget(axisSide: meta.axisSide, space: 10, child: text);
  }

  @override
  Widget build(BuildContext context) {
    return
      Expanded(
        child: Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, bottom: 10),
      child: (lCharts.isEmpty) ? 
      const Center(child: CircularProgressIndicator()) :
       LineChart(
        swapAnimationDuration: const Duration(milliseconds: 150),
        swapAnimationCurve: Curves.linear,
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  interval: 1,
                  getTitlesWidget: bottomTitlesWidget),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  interval: 1,
                  getTitlesWidget: rightTitlesWidget),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  interval: 1,
                  getTitlesWidget: leftTitlesWidget),
            ),
          ),
          borderData: FlBorderData(
              show: true,
              border: const Border(
                bottom: BorderSide(color: Colors.grey, width: 2),
                left: BorderSide(color: Colors.transparent),
                right: BorderSide(color: Colors.transparent),
                top: BorderSide(color: Colors.transparent),
              )),
          lineBarsData: [
            LineChartBarData(
                isCurved: true,
                color: Colors.purple,
                barWidth: 4,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
                spots: [
                  FlSpot(0, lCharts[0].hum / 100 * 40),
                  FlSpot(3, lCharts[1].hum / 100 * 40),
                  FlSpot(6, lCharts[2].hum / 100 * 40),
                  FlSpot(9, lCharts[3].hum / 100 * 40),
                  FlSpot(12, lCharts[4].hum / 100 * 40),
                  // FlSpot(15, lCharts[5].hum / 100 * 40),
                  // FlSpot(18, lCharts[6].hum / 100 * 40),
                  // FlSpot(21, lCharts[7].hum / 100 * 40),
                ]),
            LineChartBarData(
                isCurved: true,
                color: Colors.amber,
                barWidth: 4,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
                spots: [
                  FlSpot(0, lCharts[0].temp.toDouble()),
                  FlSpot(3, lCharts[1].temp.toDouble()),
                  FlSpot(6, lCharts[2].temp.toDouble()),
                  FlSpot(9, lCharts[3].temp.toDouble()),
                  FlSpot(12, lCharts[4].temp.toDouble()),
                  // FlSpot(15, lCharts[5].temp.toDouble()),
                  // FlSpot(18, lCharts[6].temp.toDouble()),
                  // FlSpot(21, lCharts[7].temp.toDouble()),
                ]),
          ],
          minX: 0,
          maxX: 24,
          minY: 0,
          maxY: 40,
        ),
      ),
    ));
  }
}
