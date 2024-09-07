import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDatailsView extends StatefulWidget {

  final String newsImage, newsTitle, newsDate, author, description, content, source;

  const NewsDatailsView({super.key,
      required this.newsImage,
      required this.newsTitle,
      required this.description,
      required this.source,
      required this.author,
      required this.content,
      required this.newsDate});

  @override
  State<NewsDatailsView> createState() => _NewsDatailsViewState();
}

class _NewsDatailsViewState extends State<NewsDatailsView> {

  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery
        .sizeOf(context)
        .width * 1;
    final height = MediaQuery
        .sizeOf(context)
        .height * 1;

    DateTime dateTime = DateTime.parse(widget.newsDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: height * .45,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(40)
              ),
              child: CachedNetworkImage(
                  imageUrl: widget.newsImage,
                  errorWidget: (context, error, stack) {
                    return const Icon(
                      Icons.error,
                      color: Colors.red,
                    );
                  },
                  fit: BoxFit.cover,
                  placeholder: (context,ulr) => const Center(
                    child: CircularProgressIndicator(),
                  ),),
            ) ,
          ),
          Container(
            height: height* .6,
            margin: EdgeInsets.only(top: height *.4),
            padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(40)
                ),
              color: Colors.white
            ),
            child: ListView(
              children: [
                Text(widget.newsTitle ,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black87
                ),),
                SizedBox( height: height *.02,),
                Row(
                  children: [
                    Expanded(
                      child: Text(widget.source,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: Colors.black87)),
                    ),
                    Text( format.format(dateTime),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.black87)),
                  ],
                ),
                SizedBox(height: height *.03,),
                Text( widget.description,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.black87)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
