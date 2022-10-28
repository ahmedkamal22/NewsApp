import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Science extends StatelessWidget {
  const Science({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsAppCubit.get(context).science;
          return ScreenTypeLayout(
            mobile: Builder(builder: (context) {
              NewsAppCubit.get(context).setDesktop(false);
              return articleBuilder(list, context);
            }),
            desktop: Builder(builder: (context) {
              NewsAppCubit.get(context).setDesktop(true);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: articleBuilder(list, context)),
                  if (list.isNotEmpty)
                    ConditionalBuilder(
                      condition: list[NewsAppCubit.get(context).selectedTitle]
                              ['urlToImage'] !=
                          null,
                      builder: (context) => Expanded(
                        child: Container(
                          height: double.infinity,
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Text(
                              "${list[NewsAppCubit.get(context).selectedTitle]['description']}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(height: 1.5, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      fallback: (context) => Expanded(
                        child: Container(
                          height: double.infinity,
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Text(
                              "${list[NewsAppCubit.get(context).selectedTitle]["title"]}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(height: 1.5, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
            breakpoints: const ScreenBreakpoints(
              desktop: 600,
              tablet: 600,
              watch: 100,
            ),
          );
        });
  }
}
