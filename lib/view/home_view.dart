import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app_flutter/data/response/status.dart';
import 'package:news_app_flutter/utils/routes/routes_name.dart';
import 'package:news_app_flutter/utils/utils.dart';
import 'package:news_app_flutter/view_view_model/news_view_view_model.dart';
import 'package:provider/provider.dart';
import '../view_view_model/auth_view_view_model.dart';
import '../view_view_model/category_view_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

enum FilterList { bbcNews, aryNews, reuters, cnn, alJazeera }

class _HomeViewState extends State<HomeView> {
  late NewsViewViewModel newsViewViewModel;
  late CategoryViewViewModel categoryViewViewModel;

  final format = DateFormat('MMMM dd, yyyy');

  FilterList? selectedMenu;
  String name = 'bbc-news';

  @override
  void initState() {
    super.initState();
    // Initialize the view models once when the state is created.
    newsViewViewModel = Provider.of<NewsViewViewModel>(context, listen: false);
    categoryViewViewModel = Provider.of<CategoryViewViewModel>(context, listen: false);

    // Use WidgetsBinding to perform actions after the widget build phase.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch news data and category data after the build phase
      newsViewViewModel.fetchNewsChannelHeadlinesApi(name);
      categoryViewViewModel.fetchCategoryNewsApi('General');
    });
  }



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    final authViewViewModel = Provider.of<AuthViewViewModel>(context);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteName.CategoryView);
            },
            icon: Image.asset(
              'images/category_icon.png',
              height: 30,
              width: 30,
            ),
          ),
          title: Text(
            'News',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(onPressed: (){
              authViewViewModel.logout(context);
            }, icon: const Icon(Icons.logout),),
            PopupMenuButton<FilterList>(
              initialValue: selectedMenu,
              onSelected: (FilterList item) {
                setState(() {
                  selectedMenu = item;
                  name = _getChannelName(item);
                });
                newsViewViewModel.fetchNewsChannelHeadlinesApi(name);
                categoryViewViewModel.fetchCategoryNewsApi('General');
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                const PopupMenuItem(
                  value: FilterList.bbcNews,
                  child: Text('BBC News'),
                ),
                const PopupMenuItem(
                  value: FilterList.aryNews,
                  child: Text('Ary News'),
                ),
                const PopupMenuItem(
                  value: FilterList.reuters,
                  child: Text('Reuters'),
                ),
                const PopupMenuItem(
                  value: FilterList.cnn,
                  child: Text('CNN News'),
                ),
                const PopupMenuItem(
                  value: FilterList.alJazeera,
                  child: Text('Al Jazeera'),
                ),
              ],
            ),

          ],
        ),
        body: ListView(children: [
          SizedBox(
            height: height * .55,
            width: width,
              child: Consumer<NewsViewViewModel>(
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
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(
                            value.newsList.data!.articles![index].publishedAt
                                .toString(),
                          );

                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteName.NewsDetailsView,
                                arguments: {
                                  'newsImage': value.newsList.data!
                                      .articles![index].urlToImage
                                      .toString(),
                                  'newsTitle': value
                                      .newsList.data!.articles![index].title
                                      .toString(),
                                  'description': value.newsList.data!
                                      .articles![index].description
                                      .toString(),
                                  'source': value.newsList.data!
                                      .articles![index].source!.name
                                      .toString(),
                                  'author': value
                                      .newsList.data!.articles![index].author
                                      .toString(),
                                  'content': value
                                      .newsList.data!.articles![index].content
                                      .toString(),
                                  'newsDate': value.newsList.data!
                                      .articles![index].publishedAt
                                      .toString(),
                                },
                              );
                            },
                            child: SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: height * .6,
                                    width: width * .9,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: height * .02,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: value.newsList.data!
                                                .articles![index].urlToImage!
                                                .toString() ??
                                            '',
                                        errorWidget: (context, error, stack) {
                                          return const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          );
                                        },
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(child: spinKit2),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        alignment: Alignment.bottomCenter,
                                        height: height * .22,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: width * 0.7,
                                              child: Text(
                                                value.newsList.data!
                                                    .articles![index].title
                                                    .toString(),
                                                maxLines: 4,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            Container(
                                              width: width * 0.7,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    value
                                                        .newsList
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    format.format(dateTime),
                                                    maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
          Padding(
            padding: const EdgeInsets.all(20),
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
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
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
                                    imageUrl: value.newsList.data!
                                            .articles![index].urlToImage
                                            .toString() ??
                                        '',
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
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                value
                                                    .newsList
                                                    .data!
                                                    .articles![index]
                                                    .source!
                                                    .name
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
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    default:
                      return const Text('error');
                  }
                },
              ),
          ),
        ]));
  }

  final spinKit2 = const SpinKitFadingCircle(
    color: Colors.amber,
    size: 50,
  );

  // Helper method to get channel name from FilterList
  String _getChannelName(FilterList item) {
    switch (item) {
      case FilterList.bbcNews:
        return 'bbc-news';
      case FilterList.aryNews:
        return 'ary-news';
      case FilterList.reuters:
        return 'reuters';
      case FilterList.cnn:
        return 'cnn';
      case FilterList.alJazeera:
        return 'al-jazeera-english';
      default:
        return 'bbc-news';
    }
  }
}
