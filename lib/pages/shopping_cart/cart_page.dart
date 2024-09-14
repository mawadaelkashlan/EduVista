import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paymob_payment/paymob_payment.dart';

class ShoppingCart extends StatelessWidget {
  static const String id = 'cart';
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorUtility.gbScaffold,
        title: const Text('Cart'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('carts')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('cartItems')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var cartItems = snapshot.data!.docs;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    var item = cartItems[index];
                    String courseId = item.id;
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          SizedBox(
                              height: 150,
                              width: 150,
                              child: Image.network(item['courseImage'])),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['courseName'],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Text('${item['coursePrice']} USD',
                                  style: const TextStyle(
                                    color: ColorUtility.main,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  CustomElevatedButton(
                                    height: 30,
                                    onPressed: () {
                                      removeFromCart(courseId);
                                    },
                                    text: 'Remove',
                                    backgroundColor: Colors.red,
                                  ),
                                  const SizedBox(width: 15),
                                  CustomElevatedButton(
                                    height: 30,
                                    onPressed: () async {
                                      PaymobPayment.instance.initialize(
                                        apiKey: dotenv.env['apiKey']!,
                                        integrationID: int.parse(
                                            dotenv.env['integrationID']!),
                                        iFrameID:
                                            int.parse(dotenv.env['iFrameID']!),
                                      );

                                      final PaymobResponse? response =
                                          await PaymobPayment.instance.pay(
                                        context: context,
                                        currency: "EGP",
                                        amountInCents: "20000",
                                      );

                                      if (response != null) {
                                        print(
                                            'Response: ${response.transactionID}');
                                        print('Response: ${response.success}');
                                      }
                                    },
                                    text: 'Pay',
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              FutureBuilder<double>(
                future: calculateTotal(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Text('Error calculating total');
                  }

                  double totalPrice = snapshot.data ?? 0.0;
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Price:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '$totalPrice USD',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ColorUtility.main,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomElevatedButton(
                          width: double.infinity,
                          height: 50,
                          onPressed: () async {
                            PaymobPayment.instance.initialize(
                              apiKey: dotenv.env['apiKey']!,
                              integrationID:
                                  int.parse(dotenv.env['integrationID']!),
                              iFrameID: int.parse(dotenv.env['iFrameID']!),
                            );

                            final PaymobResponse? response =
                                await PaymobPayment.instance.pay(
                              context: context,
                              currency: "EGP",
                              amountInCents: "20000",
                            );

                            if (response != null) {
                              print('Response: ${response.transactionID}');
                              print('Response: ${response.success}');
                            }
                          },
                          text: 'Checkout',
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> removeFromCart(String courseId) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('carts')
          .doc(user.uid)
          .collection('cartItems')
          .doc(courseId)
          .delete();
    }
  }

  Future<double> calculateTotal() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('carts')
          .doc(user.uid)
          .collection('cartItems')
          .get();
      double total = 0.0;
      for (var item in cartSnapshot.docs) {
        total += item['coursePrice'];
      }

      return total;
    }
    return 0.0;
  }
}
