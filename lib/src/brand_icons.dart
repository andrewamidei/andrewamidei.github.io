library;


/// Flutter icons BrandIcons
///
/// To use this font, place it in your fonts/ directory and include the
/// following in your pubspec.yaml
///
/// flutter:
///   fonts:
///    - family:  BrandIcons
///      fonts:
///       - asset: fonts/BrandIcons.ttf
///
/// 
/// * MFG Labs, Copyright (C) 2012 by Daniel Bruce
///         Author:    MFG Labs
///         License:   SIL (http://scripts.sil.org/OFL)
///         Homepage:  http://www.mfglabs.com/
/// * Octicons, Copyright (C) 2020 by GitHub Inc.
///         Author:    GitHub
///         License:   MIT (http://opensource.org/licenses/mit-license.php)
///         Homepage:  https://primer.style/octicons/
///
import 'package:flutter/widgets.dart';

class BrandIcons {
  BrandIcons._();

  static const _kFontFam = 'BrandIcons';
  static const String? _kFontPkg = null;

  static const IconData linkedin = IconData(0xf05c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData github = IconData(0xf308, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
