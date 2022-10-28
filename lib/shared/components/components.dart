import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/webview/webview.dart';
import 'package:news_app/shared/cubit/app_cubit.dart';
import 'package:news_app/shared/cubit/cubit.dart';

Widget buildArticleItem(article, context, index) => Container(
      color: NewsAppCubit.get(context).selectedTitle == index &&
              NewsAppCubit.get(context).isDesktop
          ? Colors.grey[200]
          : null,
      child: InkWell(
        onTap: () {
          NewsAppCubit.get(context).selectedItem(index);
          // navigateTo(context, WebViewScreen(article["url"]));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              ConditionalBuilder(
                condition: article["urlToImage"] != null,
                builder: (context) => Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage("${article["urlToImage"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                fallback: (context) => Container(
                    width: 120,
                    height: 120,
                    child: Center(child: CircularProgressIndicator())),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 120.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "${article["title"]}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color:
                                      NewsAppCubit.get(context).selectedTitle ==
                                              index
                                          ? Colors.black
                                          : AppCubit.get(context).isDark
                                              ? Colors.white
                                              : Colors.black),
                        ),
                      ),
                      Text(
                        "${article["publishedAt"]}",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context, index),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey,
                ),
              ),
          itemCount: list.length),
      fallback: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Widget defaultFormField({
  @required TextInputType? keyboard_type,
  @required TextEditingController? controller_type,
  @required String? label_text,
  IconData? prefix_icon,
  IconData? suffix_icon,
  Function(String)? onChange,
  TextStyle? style,
  Function(String)? onSubmit,
  VoidCallback? onTap,
  @required String? Function(String?)? Validate,
  VoidCallback? isPasswordVisible,
  bool isVisible = false,
}) =>
    TextFormField(
      style: style,
      keyboardType: keyboard_type,
      controller: controller_type,
      obscureText: isVisible,
      onChanged: onChange,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      validator: Validate,
      decoration: InputDecoration(
        labelText: label_text,
        prefixIcon: Icon(prefix_icon),
        suffixIcon: suffix_icon != null
            ? IconButton(onPressed: isPasswordVisible, icon: Icon(suffix_icon))
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
