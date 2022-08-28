import 'package:flutter/material.dart';
import 'package:singer_app/config/color_config.dart';
import 'package:singer_app/config/size_config.dart';
import 'package:singer_app/models/file_data_model.dart';
import 'package:singer_app/ui/widgets/custom_button.dart';
import 'package:singer_app/ui/widgets/drop_zone_widget.dart';
import 'package:singer_app/utils/enums/file_upload_status_enum.dart';
import 'package:stacked/stacked.dart';

import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: ColorConfig.backgroundColor,
      //   centerTitle: false,
      //   elevation: 0,
      //   title: const Text(
      //     "Add song",
      //     style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      //   ),
      // ),
      body: ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (HomeViewModel viewModel) {},
        builder: (BuildContext context, HomeViewModel model, Widget? child) {
          String titleText = "Upload an .xlsx file";
          String dropZoneText = "Drag and Drop or";
          IconData dropZoneIcon = Icons.upload_rounded;
          bool isUploadBtnEnable = false;
          Color dropZoneTextColor = Colors.black87;
          Color titleTextColor = Colors.black87;

          if (model.fileUploadStatus == FileUploadStatusEnum.selecting) {
            titleText = "Please wait.";
            dropZoneText = "Processing....";
            dropZoneIcon = Icons.hourglass_empty_outlined;
            isUploadBtnEnable = false;
            dropZoneTextColor = Colors.orange;
          } else if (model.fileUploadStatus == FileUploadStatusEnum.selected) {
            titleText = "File attached";
            dropZoneText = model.fileDataModel == null ? "" : model.fileDataModel!.name;
            dropZoneIcon = Icons.task_outlined;
            isUploadBtnEnable = true;
          } else if (model.fileUploadStatus == FileUploadStatusEnum.uploading) {
            titleText = "Please wait...";
            dropZoneText = "Uploading...";
            dropZoneIcon = Icons.publish_outlined;
            isUploadBtnEnable = false;
            dropZoneTextColor = Colors.orange;
          } else if (model.fileUploadStatus == FileUploadStatusEnum.uploaded) {
            titleText = "File uploaded";
            dropZoneText = "Upload another file";
            dropZoneIcon = Icons.task_outlined;
            isUploadBtnEnable = false;
            dropZoneTextColor = Colors.red;
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.horizontal()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
            padding: EdgeInsets.only(top: 34,bottom: 14),
                  child: Text(
                    "Add Songs",
                    style: TextStyle(
                        fontSize: 24,
                        color: titleTextColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4),
                  ),
                ),
                Container(
                  height: 1,
                  color: ColorConfig.greyColor6,
                ),
                const SizedBox(
                  height: 24,
                ),
                // Text(
                //   titleText,
                //   style: TextStyle(
                //       fontSize: 24,
                //       color: titleTextColor,
                //       fontWeight: FontWeight.w600,
                //       letterSpacing: 0.6),
                // ),
                //
                ConstrainedBox(
                  constraints:  const BoxConstraints(
                      minHeight: 5.0,
                      minWidth: 5.0,
                      maxWidth: double.maxFinite,
                      maxHeight: 200),
                  // height: 60,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(),
                    child: DropZoneWidget(
                      titleColor: dropZoneTextColor,
                      onDroppedFile: (FileDataModel value) {
                        if (value.url != "") {
                          model.fileSelected(value);
                        }
                      },
                      iconData: dropZoneIcon,
                      title: dropZoneText,
                      fileUploadStatus: model.fileUploadStatus,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text("Accepted File Type .xlsx",style: TextStyle(
                  letterSpacing: 0.4,
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                  fontSize: 12
                ),),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  "Add to Database",
                  isDisabled: !isUploadBtnEnable,
                  height: 44,
                  fontSize: 15,
                  backgroundColor: ColorConfig.accentColor,
                  buttonPressed: () {
                    model.uploadFile();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
