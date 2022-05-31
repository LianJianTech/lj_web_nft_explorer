import 'dart:js' as js;
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lj_web_nft_explorer/web3_js_page.dart';

class MetaMaskPage extends StatefulWidget {
  const MetaMaskPage({Key? key}) : super(key: key);

  @override
  State<MetaMaskPage> createState() => _MetaMaskPageState();
}

class _MetaMaskPageState extends State<MetaMaskPage> {
  bool ethFlag = false;
  bool isMetaMask = false;
  String network = '';
  String account = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          _ethereumWidget(),
          const SizedBox(height: 16),
          _isMetaMaskWidget(),
          const SizedBox(height: 16),
          _networkWidget(),
          const SizedBox(height: 16),
          _accountWidget(),
        ],
      ),
    );
  }

  Widget _ethereumWidget() {
    return InkWell(
      onTap: () {
        setState(() {
          ethFlag = js.context.hasProperty('ethereum');
        });
        js.context.callMethod('alert', [ethFlag]);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'has ethereum: ',
            style: GoogleFonts.lato(
              fontSize: 30,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            ethFlag ? 'yes' : 'no',
            style: GoogleFonts.lato(
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _isMetaMaskWidget() {
    return InkWell(
      onTap: () {
        var result = js.context['ethereum']['isMetaMask'];
        js.context.callMethod("alert", ['isMetaMask:' + result.toString()]);
        setState(() {
          isMetaMask = result;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'isMetaMask: ',
            style: GoogleFonts.lato(
              fontSize: 30,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            isMetaMask ? 'yes' : 'no',
            style: GoogleFonts.lato(
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _networkWidget() {
    return InkWell(
      onTap: () {
        js.context['abc'];
        var result = js.context['ethereum']['networkVersion'];
        js.context.callMethod("alert", ['network:' + result.toString()]);
        setState(() {
          network = getNetwork(result.toString());
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'network: ',
            style: GoogleFonts.lato(
              fontSize: 30,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            network,
            style: GoogleFonts.lato(
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _accountWidget() {
    return InkWell(
      onTap: () async {
        try {
          var accounts = await promiseToFuture(
              ethereum.request(RequestParams(method: 'eth_requestAccounts')));
          js.context.callMethod("alert", ['accounts:' + accounts.toString()]);
          setState(() {
            account = accounts[0];
          });
        } catch (e) {
          js.context.callMethod("alert", ['error:' + e.toString()]);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'account:',
            style: GoogleFonts.lato(
              fontSize: 30,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            account,
            style: GoogleFonts.lato(
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }

  String getNetwork(String id) {
    switch (id.trim()) {
      case '1':
        return 'Mainnet';
      case "2":
        return 'Morden';
      case "3":
        return 'Ropsten';
      case "4":
        return 'Rinkeby';
      case "42":
        return 'Kovan';
      default:
        return 'unknown network';
    }
  }
}
