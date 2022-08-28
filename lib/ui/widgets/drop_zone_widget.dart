import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:singer_app/config/color_config.dart';
import 'package:singer_app/models/file_data_model.dart';
import 'package:singer_app/utils/enums/file_upload_status_enum.dart';

class DropZoneWidget extends StatefulWidget {
  final ValueChanged<FileDataModel> onDroppedFile;
  String title;
  IconData iconData;
  Color titleColor;
  FileUploadStatusEnum fileUploadStatus;

  DropZoneWidget(
      {Key? key,
      required this.onDroppedFile,
      required this.title,
      required this.iconData,
      this.titleColor = Colors.black87,
      required this.fileUploadStatus})
      : super(key: key);

  @override
  _DropZoneWidgetState createState() => _DropZoneWidgetState();
}

class _DropZoneWidgetState extends State<DropZoneWidget> {
  late DropzoneViewController controller;
  bool highlight = false;

  @override
  Widget build(BuildContext context) {
    print("highlight :- " + highlight.toString());

    return buildDecoration(
        child: Stack(
      fit: StackFit.loose,
      children: [
        widget.title == "Uploading..."
            ? Container()
            : DropzoneView(
                onCreated: (controller) => this.controller = controller,
                onDrop: UploadedFile,
                onHover: () => setState(() => highlight = true),
                onLeave: () => setState(() => highlight = false),
              ),
        highlight
            ? Container(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Center(
                  child: Text(
                    'Drop here',
                    style: TextStyle(
                        color: ColorConfig.accentColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8),
                  ),
                ),
              )
            : widget.fileUploadStatus == FileUploadStatusEnum.uploading
                ? Container(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Icon(
                          Icons.upload_outlined,
                          size: 32,
                          color: ColorConfig.accentColor.withOpacity(0.50),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Text(
                          "Please wait..",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5
                          ),
                        ),
                      ],
                    ),
                  )
                : widget.fileUploadStatus == FileUploadStatusEnum.uploaded
                    ? Container(
                        width: double.maxFinite,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.task_outlined,
                              size: 32,
                              color: ColorConfig.greyColor2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                UploadedFile((await controller.pickFiles())[0]);
                              },
                              child: Text(
                                "Upload another file",
                                style: TextStyle(
                                  color:
                                      ColorConfig.accentColor.withOpacity(0.8),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 24),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                widget.iconData,
                                size: 42,
                                color: Colors.black54,
                              ),
                              const SizedBox(
                                width: 22,
                              ),
                              Text(
                                widget.title,
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 200,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  UploadedFile((await controller.pickFiles())[0]);
                                },
                                child: Text(
                                  ' Select File',
                                  style: TextStyle(
                                      color: ColorConfig.accentColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
      ],
    ));
  }

  Future UploadedFile(dynamic event) async {
    final name = event.name;

    final mime = await controller.getFileMIME(event);
    final byte = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);
    final fileData = await controller.getFileData(event);

    final droppedFile = FileDataModel(
        name: name, mime: mime, bytes: byte, url: url, fileData: fileData);

    widget.onDroppedFile(droppedFile);
    setState(() {
      highlight = false;
    });
  }

  Widget buildDecoration({required Widget child}) {
    final borderColor = highlight ? ColorConfig.accentColor : Colors.black54;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        // padding: EdgeInsets.all(6),
        color:
            highlight ? ColorConfig.accentColor.withOpacity(0.1) : Colors.white,
        child: DottedBorder(
            borderType: BorderType.RRect,
            color: borderColor,
            strokeWidth: 1,
            dashPattern: [4, 4],
            radius: const Radius.circular(12),
            padding: EdgeInsets.all(0),
            child: child),
      ),
    );
  }
}
