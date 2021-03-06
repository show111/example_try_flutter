import 'package:flutter/material.dart';
import 'package:flutter_app/kml/kml_polygon_page.dart';
import 'package:flutter_app/kml/kml_placemarks_page.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'animation/animation_part.dart';
import 'kml/kml_overlayers_page.dart';
import 'util/slide_left_route.dart';

class DetailTwoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Page Two"),
        ),
        body: Column(
          children: <Widget>[
            _imageLayer(),
            _titleSection(context),
            _toggleButton(context),
            _buttonSection(context),
          ],
        ));
  }
}

Widget _imageLayer() {
  var markers = _getMarkerList(null, null);

  var overlayImages = <OverlayImage>[
    OverlayImage(
        bounds: LatLngBounds(LatLng(51.5, -0.09), LatLng(48.8566, 2.3522)),
        opacity: 0.8,
        imageProvider: NetworkImage(
            'https://images.pexels.com/photos/231009/pexels-photo-231009.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=300&w=600')),
  ];

  return Container(
    child: Column(
      children: <Widget>[
        Flexible(
            child: FlutterMap(
          options: MapOptions(
            center: LatLng(51.5, -0.09),
            zoom: 5.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate:
                  'http://www.google.com/maps/vt?lyrs=m@189&gl=en&x={x}&y={y}&z={z}',
              subdomains: [],
            ),
            OverlayImageLayerOptions(overlayImages: overlayImages),
            MarkerLayerOptions(markers: markers)
          ],
        ))
      ],
    ),
    height: 200,
    color: Colors.grey[300],
  );
}

Widget _titleSection(BuildContext context) {
  return Container(
    alignment: Alignment.topLeft,
    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Text('AOI Name',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15.0, height: 1.5)),
          onTap: () {
            Navigator.push(context, SlideRightRoute(page: KmlPlacemarksPage()));
          },
        ),
        Text(
          'Exact Location, Location ',
          style:
              TextStyle(color: Colors.grey[500], fontSize: 10.0, height: 1.5),
        ),
        Text(
          'Minimum Depth       Maximum Depth',
          style:
              TextStyle(color: Colors.grey[500], fontSize: 10.0, height: 1.5),
        ),
        GestureDetector(
            child: Text(
          'Method of Event Detection: ',
          style: TextStyle(color: Colors.grey[500], fontSize: 12.0, height: 2),
        ), onTap: (){
          Navigator.push(context, SlideRightRoute(page: KmlPolygonPage()));
        },),
        Text(
          'Method of Event Detection: Auto, Real ',
          style: TextStyle(color: Colors.grey[500], fontSize: 12.0, height: 2),
        ),
        GestureDetector(
          child: Text(
            'Analysis Type: AI Analysis',
            style: TextStyle(color: Colors.grey[500], fontSize: 12.0, height: 2),
          ),
          onTap: (){
            Navigator.push(context, SlideRightRoute(page: KmlGroundOverlayerPage()));
          },
        ),
      ],
    ),
  );
}

Widget _buttonSection(BuildContext context) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildListColumn(Colors.orange),
        _buildListColumn(Colors.blueGrey),
        new Divider(),
      ],
    ),
  );
}

Widget _toggleButton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: new ListTile(
            title: new Text(
              'Notification Trigger',
              style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 13.0),
            ),
            subtitle: new Text(
              'Turning off notification trigger will remove event from main page',
              style: new TextStyle(fontWeight: FontWeight.w300, fontSize: 10.0),
            ),
            isThreeLine: true,
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          ),
          flex: 3,
        ),
        Expanded(
          child: GestureDetector(
            child: Icon(Icons.account_circle, color: Colors.blue),
            onTap: () {
              Navigator.push(context, SlideRightRoute(page: AnimationPart()));
            },
          ),
          flex: 1,
        )
      ],
    ),
  );
}

Column _buildListColumn(Color colors) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
        alignment: Alignment.topLeft,
        child: Text('Rel. to Historical Seismicity',
            style: TextStyle(color: Colors.grey[500], fontSize: 14.0)),
      ),
      Container(
        color: Colors.grey[350],
        height: 40.0,
        width: 420.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      ),
      Container(
        color: Colors.grey[350],
        height: 40.0,
        width: 420.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
      )
    ],
  );
}

List<Marker> _getMarkerList(LatLng point1, LatLng point2) {
  if (point1 == null) {
    point1 = LatLng(51.5, -0.09);
  }
  if (point2 == null) {
    point2 = LatLng(48.8566, 2.3522);
  }

  var markers = <Marker>[
    Marker(
        width: 80.0,
        height: 80.0,
        point: point1,
        builder: (context) => Container(child: Icon(Icons.add_location))),
    Marker(
        width: 80.0,
        height: 80.0,
        point: point2,
        builder: (context) => Container(child: Icon(Icons.add_location)))
  ];
  return markers;
}
