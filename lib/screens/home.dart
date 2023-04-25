import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Receitas'),
        actions: [
          PopupMenuButton(
              tooltip: 'Culinária',
              onSelected: (List value) {
                Navigator.of(context).pushNamed('/cuisines', arguments: value);
              },
              itemBuilder: (BuildContext context) {
                return const [
                  PopupMenuItem(
                      value: ['american', 'Americana'],
                      child: Text('Americana')),
                  PopupMenuItem(
                      value: ['canadian', 'Canadense'],
                      child: Text('Canadense')),
                  PopupMenuItem(
                      value: ['chinese', 'Chinesa'], child: Text('Chinesa')),
                  PopupMenuItem(
                      value: ['french', 'Francesa'], child: Text('Francesa')),
                  PopupMenuItem(
                      value: ['portuguese', 'Portuguesa'],
                      child: Text('Portuguesa')),
                  PopupMenuItem(
                      value: ['indian', 'Indiana'], child: Text('Indiana')),
                  PopupMenuItem(
                      value: ['japanese', 'Japonesa'], child: Text('Japonesa')),
                ];
              })
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Seja bem-vindo!',
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
              Image.asset('images/cook.png'),
              const Text(
                'Encontre receitas de diversos países',
                style: TextStyle(fontSize: 17),
              ),
              const Text(
                'do mundo no menu!',
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
