package br.com.brasizza.sunmi_printer_plus

import android.content.Context
import android.util.Log
import com.sunmi.printerx.PrinterSdk
import com.sunmi.printerx.PrinterSdk.PrinterListen
import com.sunmi.printerx.SdkException

class SunmiInitClass(private val context: Context) {
    var selectPrinter: PrinterSdk.Printer? = null
    private val TAG = "sunmi_printer_plus"

    fun initPrinter(callback: (PrinterSdk.Printer?) -> Unit) {
        Log.d(TAG, "Starting printer initialization...")
        try {
            PrinterSdk.getInstance().getPrinter(context, object : PrinterListen {
                override fun onDefPrinter(printer: PrinterSdk.Printer) {
                    selectPrinter = printer
                    Log.d(TAG, "Printer successfully initialized: ${printer.toString()}")
                    callback(printer) // Return the printer via the callback
                }

                override fun onPrinters(printers: List<PrinterSdk.Printer>) {
                    // You can also handle multiple printers if needed
                    Log.d(TAG, "Multiple printers found: ${printers.size}")
                }
            })
        } catch (e: SdkException) {
            Log.e(TAG, "Printer initialization error: ${e.message}", e)
            e.printStackTrace()
            callback(null) // Return null in case of an error
        } catch (e: Exception) {
            // Catch any other unexpected exceptions
            Log.e(TAG, "Unexpected error during printer initialization: ${e.message}", e)
            e.printStackTrace()
            callback(null)
        }
    }
    
    // Method to reinitialize the printer if needed
    fun reinitPrinter(callback: (PrinterSdk.Printer?) -> Unit) {
        Log.d(TAG, "Attempting to reinitialize printer...")
        selectPrinter = null
        initPrinter(callback)
    }
}
