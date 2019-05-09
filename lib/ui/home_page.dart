import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _bodyBack = Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Colors.blue, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
    );

    return Stack(
      children: <Widget>[
        _bodyBack,
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades"),
                centerTitle: true,
              ),
            ),
            StreamBuilder(
              stream: Firestore.instance
                  .collection('loja_virtual_app_images')
                  .orderBy('pos').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                  else {
                    var docs = snapshot.data.documents;
                    return SliverStaggeredGrid.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1.0,
                      mainAxisSpacing: 1.0,
                      staggeredTiles: docs.map<StaggeredTile>((doc) {
                        return StaggeredTile.count(
                            doc.data['x'], doc.data['y']);
                      }).toList(),
                      children: docs.map<FadeInImage>((doc) {
                        print(doc);
                        return FadeInImage.memoryNetwork(
                          fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                            image: doc.data['url']);
                      }).toList(),
                    );
                  }
                })
          ],
        )
      ],
    );
  }

  @override
  StatelessElement createElement() {
    print('Inicio');
    FirebaseAuth.instance.signInAnonymously();
    return super.createElement();
  }
}
