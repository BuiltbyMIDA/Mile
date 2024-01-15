import 'package:driver/themes/app_colors.dart';
import 'package:driver/themes/responsive.dart';
import 'package:driver/utils/DarkThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LocationView extends StatelessWidget {
  final String? sourceLocation;
  final String? destinationLocation;

  const LocationView({Key? key, this.sourceLocation, this.destinationLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SvgPicture.asset( 'assets/icons/ic_source.svg', width: 18),
            Dash(direction: Axis.vertical, length: Responsive.height(6, context), dashLength: 12, dashColor: AppColors.dottedDivider),
            SvgPicture.asset( 'assets/icons/ic_destination.svg', width: 20),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(sourceLocation.toString(), maxLines: 2, style: GoogleFonts.poppins()),
              SizedBox(height: Responsive.height(2, context)),
              Text(
                destinationLocation.toString(),
                maxLines: 2,
                style: GoogleFonts.poppins(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
