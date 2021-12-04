import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noter/blocs/bloc_provider.dart';
import 'package:noter/models/note.model.dart';

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}

abstract class ListItem {
  Widget buildTitle(BuildContext context);
  Widget buildSubtitle(BuildContext context);
}

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = NotesProvider.of(context);
    if (bloc != null) {
      return Container(
        margin: const EdgeInsets.all(20.0),
        child: StreamBuilder<List<Note>>(
            stream: bloc.notes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            bloc.inRemoveNote.add(snapshot.data![index].id);
                          },
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                              child: (Text(
                                            snapshot.data![index].text,
                                            overflow: TextOverflow.ellipsis,
                                            style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15.0,
                                            ),
                                          ))),
                                          Text(
                                            DateFormat.yMMMd().format(
                                                DateTime.parse(snapshot
                                                    .data![index].createdAt)),
                                            overflow: TextOverflow.fade,
                                            style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10.0,
                                            ),
                                          ),
                                        ])),
                                const Divider()
                              ]));
                    });
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }
              return new Container(
                alignment: AlignmentDirectional.center,
                child: new CircularProgressIndicator(),
              );
            }),
      );
    } else {
      return new Container(
        alignment: AlignmentDirectional.center,
        child: new CircularProgressIndicator(),
      );
    }
  }
}
