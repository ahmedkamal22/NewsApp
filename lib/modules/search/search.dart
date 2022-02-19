import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class Search extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsAppCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  keyboard_type: TextInputType.text,
                  controller_type: searchController,
                  label_text: "Search",
                  Validate: (String? value) {
                    if (value!.isEmpty) {
                      return "Search mustn't be empty";
                    }
                    return null;
                  },
                  onChange: (value) {
                    NewsAppCubit.get(context).getSearch(value);
                  },
                  prefix_icon: Icons.search_rounded,
                  style: TextStyle(
                    color: NewsAppCubit.get(context).isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              Expanded(child: articleBuilder(list, context, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
