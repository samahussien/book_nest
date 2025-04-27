import 'package:book_nest/features/home_screen/data/cache_helper.dart';
import 'package:book_nest/features/home_screen/data/models/book/book.dart';
import 'package:book_nest/features/home_screen/presentation/manager/books_cubit.dart';
import 'package:book_nest/utils/colors.dart';
import 'package:book_nest/utils/styles.dart';
import 'package:flutter/material.dart';

class BookData extends StatefulWidget {
 const BookData({
    super.key,
    required this.book,
    required this.width,
    required this.height,
  });

  final Book book;
  final double width;
  final double height;

  @override
  State<BookData> createState() => _BookDataState();
}

class _BookDataState extends State<BookData> {
  late bool isfavorite = false;

  bool isExpanded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsFavorite();
  }

  void checkIsFavorite() async {
    bool isFav = await CacheHelper.isBookFavorite(widget.book);
    setState(() {
      isfavorite = isFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    BooksCubit cubit = BooksCubit.get(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.book.title!,
                style: Styles.titleStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              onPressed: () {
                isfavorite
                    ? {
                     cubit
                            .removeBookFromFavorites(book: widget.book),
                      }
                    : cubit
                        .addBookToFavorites(book: widget.book);
                checkIsFavorite();
              },
              icon: Icon(isfavorite ? Icons.favorite : Icons.favorite_border),
              color: AppColors.accent,
            )
          ],
        ),
        Text(
          widget.book.authors!.map((author) => author.name).join(', '),
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
                  widget.book.summaries!.join(','),
                  maxLines: isExpanded ? null : 3,
                  overflow:
                      isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  style: Styles.bodyStyle
                      .copyWith(fontSize: widget.height * 0.015),
                ),
              ),
              widget.book.summaries!.isEmpty
                  ? const SizedBox.shrink()
                  : GestureDetector(
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
    );
  }
}
