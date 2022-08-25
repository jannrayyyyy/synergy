import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:synergy/presentation/cubits/posts/posts_cubit.dart';
import 'package:synergy/presentation/cubits/users/users_cubit.dart';
import 'package:synergy/presentation/widgets/searchloaded_container.dart';

import '../../widgets/search_image_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  @override
  void initState() {
    context.read<PostsCubit>().fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomTextField(
              'Search',
              controller: controller,
              prefix: const Icon(
                Icons.search,
              ),
              onChanged: (value) {
                context.read<UsersCubit>().searchUsers(value);
              },
            ),
          ),
          const SizedBox(height: 32),
          BlocBuilder<UsersCubit, UsersState>(
            builder: (context, state) {
              if (state is SearchLoaded) {
                return SearchLoadedContainer(users: state.users);
              } else if (state is UsersLoading) {
                return const Center(
                  child: CustomText('Loading...'),
                );
              } else if (state is UsersEmpty) {
                return const Center(
                  child: CustomText('No content.'),
                );
              } else if (state is UsersInitial) {
                return const SearchImageContainer();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
