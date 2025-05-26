import 'package:flutter/material.dart';
import 'package:uzpay/enums.dart';
import 'package:uzpay/objects.dart';
import 'package:uzpay/uzpay.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

// Agar kerak bo'lsa url_launcher ham ishlatishingiz mumkin:
// import 'package:url_launcher/url_launcher.dart';

class UzPayScreen extends StatefulWidget {
  const UzPayScreen({super.key});

  @override
  State<UzPayScreen> createState() => _UzPayScreenState();
}

class _UzPayScreenState extends State<UzPayScreen> {
  TextEditingController _controler = TextEditingController();

  String CLICK_SERVICE_ID = '38944';
  String CLICK_MERCHANT_ID = '31069';
  String CLICK_MERCHANT_USER_ID = '48614';

  String PAYME_MERCHANT_ID = 'REPLACE_WITH_YOURS';
  String TRANS_ID = 'REPLACE_WITH_YOURS';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To\'lov tizimlari  💳',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
           
            const SizedBox(height: 25),
            Text("To'lov tizimlari",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 20)),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
               _buildPaymentItem(
  name: 'Click',
  assetPath: 'assets/images/click.png',
  onTap: () => _handleSelectedSystem(PaymentSystem.Click),
),
_buildPaymentItem(
  name: 'Payme',
  assetPath: 'assets/images/payme.png',
  onTap: () => _handleSelectedSystem(PaymentSystem.Payme),
),
_buildPaymentItem(
  name: 'Apelsin',
  assetPath: 'assets/images/apelsin.png',
  onTap: () {},
),
_buildPaymentItem(
  name: 'Paynet',
  assetPath: 'assets/images/paynet.png',
  onTap: () {},
),
_buildPaymentItem(
  name: 'Upay',
  assetPath: 'assets/images/upay.jfif',
  onTap: () {},
),
_buildPaymentItem(
  name: 'Anorbank',
  assetPath: 'assets/images/anorbank.png',
  onTap: () {},
),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentItem({
  required String name,
  required String assetPath,
  required VoidCallback onTap,
}) {
  return ZoomTapAnimation(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              assetPath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
}


  void _handleSelectedSystem(PaymentSystem paymentSystem) {
    double? amount = double.tryParse(_controler.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Iltimos, to'g'ri summa kiriting.")),
      );
      return;
    }



    

  }

  doPayment({
    required double amount,
    required PaymentSystem paymentSystem,
    required Params paymentParams,
  }) async {
    if (amount > 500) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Brauzer tanlang'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.open_in_browser),
                title: const Text('Tashqi brauzer'),
                onTap: () async {
                  Navigator.pop(context);
                  await _processPayment(
                    amount: amount,
                    paymentSystem: paymentSystem,
                    paymentParams: paymentParams,
                    browserType: BrowserType.External,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.web),
                title: const Text('Ichki brauzer'),
                onTap: () {
                  Navigator.pop(context);
                  UzPay.doPayment(
                    context,
                    amount: amount,
                    paymentSystem: paymentSystem,
                    paymentParams: paymentParams,
                    browserType: BrowserType.Internal,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.apps),
                title: const Text("Ilovadan (Agar o'rnatilgan bo'lsa)"),
                onTap: () async {
                  Navigator.pop(context);
                  await _processPayment(
                    amount: amount,
                    paymentSystem: paymentSystem,
                    paymentParams: paymentParams,
                    browserType: BrowserType.ExternalOrDeepLink,
                  );
                },
              ),
            ],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("To'lov imkonsiz, minimal summa 500 so'mdan yuqori!"),
        ),
      );
    }
  }

  Future<void> _processPayment({
    required double amount,
    required PaymentSystem paymentSystem,
    required Params paymentParams,
    required BrowserType browserType,
  }) async {
    try {
      await UzPay.doPayment(
        context,
        amount: amount,
        paymentSystem: paymentSystem,
        paymentParams: paymentParams,
        browserType: browserType,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Xatolik yuz berdi: $e'),
        ),
      );
    }
  }
}
