
import 'package:book_nest/features/home_screen/presentation/views/widgets/book_list_item.dart';
import 'package:book_nest/utils/colors.dart';
import 'package:book_nest/utils/styles.dart';
import 'package:flutter/material.dart';

class BookData extends StatefulWidget {
   BookData({
    super.key,
    required this.widget,
    required this.width,
    required this.height,
  });

  final BookListItem widget;
  final double width;
  final double height;

  @override
  State<BookData> createState() => _BookDataState();
}

class _BookDataState extends State<BookData> {
bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.widget.book.title!,
                          style: Styles.titleStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.favorite_border,
                        color: AppColors.accent,
                      )
                    ],
                  ),
                  Text(
                    
  widget.widget.book.authors!.map((author) => author.name).join(', '),
                    style: Styles.subTitleStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
widget.widget.book.summaries!.join(','),                            maxLines: isExpanded ? null : 3,
                            overflow: isExpanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            style: Styles.bodyStyle
                                .copyWith(fontSize: widget.height * 0.015),
                          ),
                        ),
                widget.widget.book.summaries!.isEmpty ? const SizedBox.shrink() :        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Text(
                           isExpanded ? "See Less" : "See More",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: widget.height * 0.015,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );}
}