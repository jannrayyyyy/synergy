import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';

import '../cubits/posts/posts_cubit.dart';

class SearchImageContainer extends StatelessWidget {
  const SearchImageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is Loaded) {
          return Wrap(
            children: state.posts
                .map(
                  (e) => ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      e.postUrl,
                      height: 220,
                      width: MediaQuery.of(context).size.width * 0.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                .toList(),
          );
        } else if (state is Empty) {
          return const Center(
            child: CustomText('No content.'),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
