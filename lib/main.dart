import 'package:bilgiyarismasi/test_verileri.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

void main() => runApp(BilgiTesti());

class BilgiTesti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.indigo[800],
            body: SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SoruSayfasi(),
            ))));
  }
}

class SoruSayfasi extends StatefulWidget {
  @override
  _SoruSayfasiState createState() => _SoruSayfasiState();
}

class _SoruSayfasiState extends State<SoruSayfasi> {
  List<Widget> secimler = [];
  TestVerileri test_1 = TestVerileri();
  double puan=0;

  void butonFonk(bool secilenButon) {
    if (test_1.testBittiMi()) {
      setState(() {
        if(test_1.getSoruYaniti() == secilenButon){
          secimler.add(kDogruIconu);
          puan=(100*(puan+1))/7;
          puan = num.parse(puan.toStringAsFixed(2));
        }else{
          secimler.add(kYanlisIconu);
          puan = (100*puan)/7;
          puan = num.parse(puan.toStringAsFixed(2));
        }
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("BRAVO! Testi Bitirdiniz"),
            content: new Text("Başarı Yüzdeniz: %$puan"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Başa Dön"),
                onPressed: () {
                  Navigator.of(context).pop();

                  setState(() {
                    test_1.testiSifirla();
                    secimler = [];
                    puan=0;
                  });
                },
              ),
            ],
          );
        },
      );

    } else {
      setState(() {
        if(test_1.getSoruYaniti() == secilenButon){
          secimler.add(kDogruIconu);
          puan++;
        }else{
          secimler.add(kYanlisIconu);
        }

        test_1.testBittiMi();
        test_1.sonrakiSoru();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String pictureNo=test_1.getPicture();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(15.0),
          child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
              child: Image.asset('assets/$pictureNo.jpg')
          ),
        ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                test_1.getSoruMetni(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Wrap(
          children: secimler,
          spacing: 3,
        ),
        Expanded(
          flex: 1,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Row(children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: RaisedButton(
                          padding: EdgeInsets.all(12),
                          textColor: Colors.white,
                          color: Colors.red[400],
                          child: Icon(
                            Icons.thumb_down,
                            size: 30.0,
                          ),
                          onPressed: () {
                            butonFonk(false);
                          },
                        ))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: RaisedButton(
                          padding: EdgeInsets.all(12),
                          textColor: Colors.white,
                          color: Colors.green[400],
                          child: Icon(Icons.thumb_up, size: 30.0),
                          onPressed: () {
                            butonFonk(true);
                          },
                        ))),
              ])),
        )
      ],
    );
  }
}
