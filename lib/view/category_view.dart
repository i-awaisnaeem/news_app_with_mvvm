import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app_flutter/data/response/status.dart'; // Import the Status enum
import 'package:provider/provider.dart'; // Import Provider package
import 'package:news_app_flutter/view_view_model/category_view_view_model.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  late CategoryViewViewModel categoryViewViewModel;

  final format = DateFormat('MMMM dd, yyyy');
  String categoryName = 'General';

  List<String> categoryList = [
    'General', 'Entertainment', 'Health', 'Sports', 'Business', 'Technology'
  ];

  @override
  void initState() {
    super.initState();
    categoryViewViewModel = Provider.of<CategoryViewViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoryViewViewModel.fetchCategoryNewsApi(categoryName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        categoryName = categoryList[index];
                      });
                      categoryViewViewModel.fetchCategoryNewsApi(categoryName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: categoryName == categoryList[index]
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Center(
                            child: Text(
                              categoryList[index].toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
                child: Consumer<CategoryViewViewModel>(
                  builder: (context, value, child) {
                    if (value.newsList == null) {
                      return const Center(child: Text("No data available"));
                    }
                    switch (value.newsList.status) {
                      case Status.LOADING:
                        return const SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        );
                      case Status.ERROR:
                        return Center(
                          child: Text(value.newsList.message.toString()),
                        );
                      case Status.COMPLETED:
                        return ListView.builder(
                          itemCount: value.newsList.data!.articles!.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(
                              value.newsList.data!.articles![index].publishedAt
                                  .toString(),
                            );

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      value.newsList.data!
                                          .articles![index].urlToImage.toString() ?? '',
                                      errorWidget: (context, error, stack) {
                                        return const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        );
                                      },
                                      fit: BoxFit.cover,
                                      height: height * .18,
                                      width: width * .3,
                                      placeholder: (context, url) =>
                                          Container(child: spinKit2),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: height * .18,
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        children: [
                                          Text(
                                            value.newsList.data!.articles![index]
                                                .title
                                                .toString(),
                                            maxLines: 3,
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            height: 34,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    value.newsList.data!
                                                        .articles![index].source!.name
                                                        .toString(),
                                                    maxLines: 3,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 11,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  maxLines: 3,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      default:
                        return Container(
                          child: const Text('error'),
                        );
                    }
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
