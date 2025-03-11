import 'dart:typed_data';

import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

/// A utility class for interacting with the Sunmi printer.
///
/// Provides methods to print text, QR codes, barcodes, images, and more.
class SunmiPrinter {
  // Private constructor to prevent instantiation.
  SunmiPrinter._();

  /// Checks if the printer is initialized and ready for printing
  ///
  /// Returns true if printer is initialized, false otherwise
  static Future<bool> isPrinterInitialized() async {
    return await SunmiPrinterPlusPlatform.instance.isPrinterInitialized();
  }

  /// Attempts to reinitialize the printer if it's not ready
  ///
  /// Returns true if reinitialization was successful, false otherwise
  static Future<bool> reinitializePrinter() async {
    return await SunmiPrinterPlusPlatform.instance.reinitializePrinter();
  }

  /// Checks printer initialization status and resets if needed
  ///
  /// [autoReinitialize]: If true, attempts to reinitialize printer when not ready
  /// Returns true if printer is ready or successfully reinitialized, false otherwise
  static Future<bool> ensurePrinterReady({bool autoReinitialize = true}) async {
    final initialized = await isPrinterInitialized();
    if (initialized) {
      return true;
    }
    
    if (autoReinitialize) {
      return await reinitializePrinter();
    }
    
    return false;
  }

  /// Executes a printer function with initialization check
  ///
  /// [operation]: The printer operation to execute
  /// [defaultValue]: Value to return if initialization fails
  /// [autoReinitialize]: Whether to attempt reinitialization if needed
  /// Returns the result of [operation] if printer is ready, or [defaultValue] if not
  static Future<T> withPrinterCheck<T>({
    required Future<T> Function() operation,
    required T defaultValue,
    bool autoReinitialize = true
  }) async {
    final isReady = await ensurePrinterReady(autoReinitialize: autoReinitialize);
    if (isReady) {
      return await operation();
    }
    return defaultValue;
  }

  /// Prints plain text with an optional [SunmiTextStyle].
  ///
  /// [text]: The text to print.
  /// [style]: The optional style for the text.
  ///
  /// Returns a [String] indicating the result of the print operation, or `null`.
  static Future<String?> printText(String text, {SunmiTextStyle? style}) async {
    return await withPrinterCheck(
      operation: () async {
        final printData = {
          "text": text,
          if (style != null) ...style.toMap(),
        };
        return await SunmiPrinterPlusPlatform.instance.printText(printData);
      },
      defaultValue: "PRINTER_NOT_READY"
    );
  }

  /// Initializes the printer.
  ///
  /// **Deprecated**: This method will be removed in a future version.
  ///
  /// Returns `null`.
  @Deprecated('This method will be removed in a future version. ')
  static Future<String?> initPrinter() async {
    return null;
  }

  /// Set bold
  ///
  /// **Deprecated**: This method will be removed in a future version.
  ///
  /// Returns `null`.
  @Deprecated('This method will be removed in a future version. ')
  static Future<String?> bold() async {
    return null;
  }

  /// Reset bold
  ///
  /// **Deprecated**: This method will be removed in a future version.
  ///
  /// Returns `null`.
  @Deprecated('This method will be removed in a future version. ')
  static Future<String?> resetBold() async {
    return null;
  }

  /// Print escpos data.
  ///
  /// **Deprecated**: This method will be removed in a future version.
  ///
  /// Use [printEscPos] instead.
  ///
  /// Returns `null`.
  @Deprecated('This method will be removed in a future version. Use printEscPos instead.')
  static Future<String?> printRawData(Uint8List data) async {
    return null;
  }

  /// Set custom font size.
  ///
  /// **Deprecated**: This method will be removed in a future version.
  ///
  /// Returns `null`.
  @Deprecated('This method will be removed in a future version. ')
  static Future<String?> setCustomFontSize(int size) async {
    return null;
  }

  /// Set alignment.
  ///
  /// **Deprecated**: This method will be removed in a future version.
  ///
  /// Returns `null`.
  @Deprecated('This method will be removed in a future version. ')
  static Future<String?> setAlignment(dynamic align) async {
    return null;
  }

  /// Reset font size
  ///
  /// **Deprecated**: This method will be removed in a future version.
  ///
  /// Returns `null`.
  @Deprecated('This method will be removed in a future version. ')
  static Future<String?> resetFontSize() async {
    return null;
  }

  /// Set font size
  ///
  /// **Deprecated**: This method will be removed in a future version.
  ///
  /// Returns `null`.
  @Deprecated('This method will be removed in a future version. ')
  static Future<String?> setFontSize(dynamic size) async {
    return null;
  }

  /// startTransaction the printer.
  ///
  /// **Deprecated**: This method will be removed in a future version.
  ///
  /// Returns `null`.
  @Deprecated('This method will be removed in a future version. ')
  static Future<String?> startTransactionPrint(bool trans) async {
    return null;
  }

  /// exitTransactionPrint the printer.
  ///
  /// **Deprecated**: This method will be removed in a future version.
  ///
  /// Returns `null`.
  @Deprecated('This method will be removed in a future version. ')
  static Future<String?> exitTransactionPrint(bool trans) async {
    return null;
  }

  /// bindingPrinter the printer.
  ///
  /// **Deprecated**: This method will be removed in a future version.
  ///
  /// Returns `null`.
  @Deprecated('This method will be removed in a future version. ')
  static Future<bool?> bindingPrinter() async {
    return null;
  }

  /// Prints custom text using a [SunmiText] object.
  ///
  /// [sunmiText]: The text and style to print.
  ///
  /// Returns a [String] indicating the result of the print operation, or `null`.
  static Future<String?> printCustomText({required SunmiText sunmiText}) async {
    final printData = {
      "text": sunmiText.text,
      if (sunmiText.style != null) ...sunmiText.style!.toMap(),
    };
    return await SunmiPrinterPlusPlatform.instance.printText(printData);
  }

  /// Prints a QR code with optional [SunmiQrcodeStyle].
  ///
  /// [text]: The text for the QR code.
  /// [style]: The optional style for the QR code.
  ///
  /// Returns a [String] indicating the result of the print operation, or `null`.
  static Future<String?> printQRCode(String text, {SunmiQrcodeStyle? style}) async {
    return await withPrinterCheck(
      operation: () async {
        final printData = {
          "text": text,
          if (style != null) ...style.toMap(),
        };
        return await SunmiPrinterPlusPlatform.instance.printQrcode(printData);
      },
      defaultValue: "PRINTER_NOT_READY"
    );
  }

  /// Prints a barcode with optional [SunmiBarcodeStyle].
  ///
  /// [text]: The text for the barcode.
  /// [style]: The optional style for the barcode.
  ///
  /// Returns a [String] indicating the result of the print operation, or `null`.
  static Future<String?> printBarCode(String text, {SunmiBarcodeStyle? style}) async {
    return await withPrinterCheck(
      operation: () async {
        final printData = {
          "text": text,
          if (style != null) ...style.toMap(),
        };
        return await SunmiPrinterPlusPlatform.instance.printBarcode(printData);
      },
      defaultValue: "PRINTER_NOT_READY"
    );
  }

  /// Prints a line using an optional line [type].
  ///
  /// [type]: The type of line to print (e.g., solid or dashed).
  ///
  /// Returns a [String] indicating the result of the print operation, or `null`.
  static Future<String?> line({String? type}) async {
    return await SunmiPrinterPlusPlatform.instance.line(type);
  }

  /// Adds a specified number of blank lines to the print output.
  ///
  /// [times]: The number of blank lines to add.
  ///
  /// Returns a [String] indicating the result of the operation, or `null`.
  static Future<String?> lineWrap(int times) async {
    return await SunmiPrinterPlusPlatform.instance.lineWrap(times);
  }

  /// Cuts the paper.
  ///
  /// Returns a [String] indicating the result of the operation, or `null`.
  static Future<String?> cutPaper() async {
    return await SunmiPrinterPlusPlatform.instance.cutPaper();
  }

  /// Print escpos data.
  ///
  /// **Deprecated**: This method will be removed in a future version.
  ///
  /// Use [cutPaper] instead.
  ///
  /// Returns `null`.
  @Deprecated('This method will be removed in a future version. Use cutPaper instead.')
  static Future<String?> cut() async {
    return null;
  }

  /// Prints an image with a specified alignment.
  ///
  /// [image]: The image data as [Uint8List].
  /// [align]: The alignment for the image (e.g., left, center, right).
  ///
  /// Returns a [String] indicating the result of the print operation, or `null`.
  static Future<String?> printImage(Uint8List image, {SunmiPrintAlign align = SunmiPrintAlign.LEFT}) async {
    return await SunmiPrinterPlusPlatform.instance.printImage(image, align);
  }

  /// Adds text to the print buffer with an optional [SunmiTextStyle].
  ///
  /// [text]: The text to add.
  /// [style]: The optional style for the text.
  ///
  /// Returns a [String] indicating the result of the operation, or `null`.
  static Future<String?> addText({required String text, SunmiTextStyle? style}) async {
    final printData = {
      "text": text,
      if (style != null) ...style.toMap(),
    };

    return await SunmiPrinterPlusPlatform.instance.addText(printData);
  }

  /// Sends raw ESC/POS commands to the printer.
  ///
  /// [data]: The raw ESC/POS command data as a list of integers.
  ///
  /// Returns a [String] indicating the result of the operation, or `null`.
  static Future<String?> printEscPos(List<int> data) async {
    return await SunmiPrinterPlusPlatform.instance.printEscPos(data);
  }

  /// Sends raw TSPL commands to the printer.
  ///
  /// [data]: The raw TSPL command data as a string.
  ///
  /// Returns a [String] indicating the result of the operation, or `null`.
  static Future<String?> printTSPL({required String data}) async {
    return await SunmiPrinterPlusPlatform.instance.printTSPL(data);
  }

  /// Prints a row of columns with specified text, width, and styles.
  ///
  /// [cols]: A list of [SunmiColumn] objects representing the row content.
  ///
  /// Returns a [String] indicating the result of the operation, or `null`.
  static Future<String?> printRow({required List<SunmiColumn> cols}) async {
    List<List<dynamic>> separateProperties(List<SunmiColumn> columns) {
      List<String> textList = [];
      List<int> widthList = [];
      List<Map?> styleList = [];

      for (var column in columns) {
        textList.add(column.text);
        widthList.add(column.width);
        styleList.add(column.style?.toMap());
      }

      return [textList, widthList, styleList];
    }

    List<List<dynamic>> separatedProperties = separateProperties(cols);
    return await SunmiPrinterPlusPlatform.instance
        .printRow(text: separatedProperties[0], width: separatedProperties[1], style: separatedProperties[2]);
  }
}
