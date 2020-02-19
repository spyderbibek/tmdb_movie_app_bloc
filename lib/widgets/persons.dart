import 'package:flutter/cupertino.dart';

/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/bloc/get_persons_bloc.dart';
import 'package:movie_app/model/person.dart';
import 'package:movie_app/model/personal_response.dart';
import 'package:movie_app/style/theme.dart' as Style;

import 'loader.dart';

class PersonsList extends StatefulWidget {
  @override
  _PersonsListState createState() => _PersonsListState();
}

class _PersonsListState extends State<PersonsList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    personsBloc..getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "TRENDING PERSONS ON THIS WEEK",
            style: TextStyle(
                color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.0),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<PersonResponse>(
          stream: personsBloc.subject.stream,
          builder:
              (BuildContext context, AsyncSnapshot<PersonResponse> snapshot) {
            if (snapshot.hasData) {
              return _buildPersonWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        )
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Loader(),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("Error occured: $error")],
      ),
    );
  }

  Widget _buildPersonWidget(PersonResponse data) {
    List<Person> persons = data.persons;
    return Container(
      height: 116.0,
      padding: EdgeInsets.only(left: 10.0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: persons.length,
          itemBuilder: (context, index) {
            return Container(
              width: 100.0,
              padding: EdgeInsets.only(top: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  persons[index].profileImg == null
                      ? Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Style.Colors.secondColor,
                          ),
                          child: Icon(
                            FontAwesomeIcons.userAlt,
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w200/" +
                                          persons[index].profileImg),
                                  fit: BoxFit.cover)),
                        ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    persons[index].name,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                        color: Colors.white,
                        fontSize: 9.0),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    "Trending for ${persons[index].known}",
                    style: TextStyle(
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 7.0,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
