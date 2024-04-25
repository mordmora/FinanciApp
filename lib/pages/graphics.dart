import 'package:finanzas/configurations/color_palette.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Graphics extends StatefulWidget {
  const Graphics({super.key});

  @override
  State<Graphics> createState() => _GraphicsState();
}

class _GraphicsState extends State<Graphics> {
  final PageController _pController = PageController(viewportFraction: 1);
  double page = 0;
  double pageClamp = 0;
  int activeIndex = 0;

  void _pageListener() {
    setState(() {
      pageClamp = _pController.page!;
      page = pageClamp.clamp(0, 1);
    });
  }

  @override
  void dispose() {
    _pController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _pController.addListener(_pageListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> titles = ["Ingresos", "Gastos"];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 113, 105, 189),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text("Alimentación",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                      size: 35,
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                titles[activeIndex],
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                key: ValueKey(activeIndex),
              ),
            ),
          ),
          SizedBox(
            height: 600,
            width: MediaQuery.of(context).size.width,
            child: PageView(
              padEnds: true,
              onPageChanged: (value) {
                activeIndex = value;
                setState(() {});
              },
              scrollDirection: Axis.horizontal,
              controller: _pController,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      child: const LineChartWidget()),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      child: const LineChartWidget(),
                    ))
              ],
            ),
          ),
          const Spacer()
        ],
      )),
    );
  }
}

class Titles {
  static const TextStyle style = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
    fontSize: 14,
  );

  static getTitleData() => FlTitlesData(
      show: true,
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: (value, meta) {
            switch (value.toInt()) {
              case 1:
                return const Text('1', style: style);
              case 2:
                return const Text('2', style: style);
              case 3:
                return const Text('3', style: style);
              case 4:
                return const Text('4', style: style);
              default:
                return const Text('', style: style);
            }
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: (value, meta) {
            switch (value.toInt()) {
              case 5000:
                return const Text('5k', style: style);
              case 10000:
                return const Text('10k', style: style);
              case 15000:
                return const Text('15k', style: style);
              case 20000:
                return const Text('20k', style: style);
              default:
                return const Text('');
            }
          },
        ),
      ));
}

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(colors: [
      Palette.green.withOpacity(0.3),
      Palette.green.withOpacity(0.5),
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

    return LineChart(LineChartData(
      titlesData: Titles.getTitleData(),
      minX: 0,
      maxX: 4,
      minY: 0,
      maxY: 20000,
      gridData: FlGridData(
          show: true,
          getDrawingVerticalLine: (value) {
            return const FlLine(color: Colors.transparent);
          },
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Palette.green,
              strokeWidth: 0,
            );
          }),
      borderData: FlBorderData(
        show: true,
        border:
            Border.all(color: const Color.fromARGB(0, 255, 255, 255), width: 1),
      ),
      lineBarsData: [
        LineChartBarData(
          preventCurveOverShooting: true,
          show: true,
          spots: const [
            FlSpot(0, 5000),
            FlSpot(1, 10000),
            FlSpot(2, 15000),
            FlSpot(3, 20000),
            FlSpot(4, 15000),
          ],
          isCurved: true,
          color: const Color(0xFF39D2C0),
          barWidth: 10,
          dotData: FlDotData(
            getDotPainter: (p0, p1, p2, p3) {
              return FlDotCirclePainter(radius: 7, color: Palette.green);
            },
            show: true,
          ),
          belowBarData: BarAreaData(
              gradient: gradient,
              show: true,
              color: const Color(0xFF39D2C0).withOpacity(0.3)),
        )
      ],
    ));
  }
}
