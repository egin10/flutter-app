import 'package:bloc/bloc.dart';
import 'package:infinite_listview/model/post.dart';

class PostEvent {}

abstract class PostState {}

class PostUninitialized extends PostState {}

class PostLoaded extends PostState {
  late List<Post>? posts;
  late bool? hasReachMax;

  PostLoaded({this.posts, this.hasReachMax});

  PostLoaded copyWith({List<Post>? posts, bool? hasReachMax}) {
    return PostLoaded(
        posts: posts ?? this.posts,
        hasReachMax: hasReachMax ?? this.hasReachMax);
  }
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(PostState initialState) : super(initialState);

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    List<Post> posts;

    if (state is PostUninitialized) {
      posts = await Post.connectToAPI(0, 10);
      yield PostLoaded(posts: posts, hasReachMax: false);
    } else {
      PostLoaded postLoaded = state as PostLoaded;
      posts = await Post.connectToAPI(postLoaded.posts!.length, 10);

      yield (posts.isEmpty)
          ? postLoaded.copyWith(hasReachMax: true)
          : PostLoaded(posts: postLoaded.posts! + posts, hasReachMax: false);
    }
  }
}
