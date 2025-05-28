import 'package:flutter/material.dart';
import 'package:shop_now_backend/constant/my_theme.dart';

class CommonTable extends StatelessWidget {
  final List<String> headers;
  final List<List<Widget>> data;
  final double cellWidth;
  final double cellHeight;
  final TextStyle? headerTextStyle;
  final TextStyle? cellTextStyle;

  const CommonTable({
    super.key,
    required this.headers,
    required this.data,
    this.cellWidth = 120,
    this.cellHeight = 50,
    this.headerTextStyle,
    this.cellTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        const firstColumnWidth = 50.0;

        final remainingColumns = headers.length - 1;
        final remainingWidth = screenWidth - firstColumnWidth;
        final computedCellWidth = remainingWidth / remainingColumns;

        return Column(
          children: [
            // Header
            Row(
              children: List.generate(headers.length, (index) {
                final header = headers[index];
                final width = index == 0 ? firstColumnWidth : computedCellWidth;
                return Container(
                  width: width,
                  height: cellHeight,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: MyTheme.purpleShade1,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          index == 0 ? const Radius.circular(12) : Radius.zero,
                      topRight:
                          index == headers.length - 1
                              ? const Radius.circular(12)
                              : Radius.zero,
                    ),
                  ),
                  child: Text(
                    header,
                    style:
                        headerTextStyle ??
                        const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                );
              }),
            ),
            const Divider(height: 1),
            // Body
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, rowIndex) {
                  final row = data[rowIndex];
                  return Row(
                    children: List.generate(row.length, (index) {
                      final cell = row[index];
                      final width =
                          index == 0 ? firstColumnWidth : computedCellWidth;
                      return Container(
                        width: width,
                        height: cellHeight,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: cell,
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
