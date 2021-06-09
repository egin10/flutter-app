import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_listview/bloc/post_bloc.dart';
import 'package:infinite_listview/ui/post_item.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScrollController scrollController = ScrollController();
  late PostBloc bloc;

  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;

    if (currentScroll == maxScroll) bloc.add(PostEvent());
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<PostBloc>(context);
    scrollController.addListener(onScroll);

    return Scaffold(
      appBar: AppBar(
        title: Text("Infinite List with BLoC"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostUninitialized)
              return Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              );
            else {
              PostLoaded postLoaded = state as PostLoaded;
              return ListView.builder(
                controller: scrollController,
                itemCount: (postLoaded.hasReachMax == true)
                    ? postLoaded.posts!.length
                    : postLoaded.posts!.length + 1,
                itemBuilder: (context, index) =>
                    (index < postLoaded.posts!.length)
                        ? PostItem(post: postLoaded.posts![index])
                        : Container(
                            child: Center(
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
              );
            }
          },
        ),
      ),
    );
  }
}
