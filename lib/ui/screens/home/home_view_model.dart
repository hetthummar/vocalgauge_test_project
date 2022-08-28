import 'dart:async';
import 'dart:core';

import 'package:excel/excel.dart';
import 'package:singer_app/app/locator.dart';
import 'package:singer_app/base/custom_base_view_model.dart';
import 'package:singer_app/models/file_data_model.dart';
import 'package:singer_app/models/song_model_test.dart';
import 'package:singer_app/service/api_service.dart';
import 'package:singer_app/utils/api_result/api_result.dart';
import 'package:singer_app/utils/enums/file_upload_status_enum.dart';

class HomeViewModel extends CustomBaseViewModel {
  FileUploadStatusEnum fileUploadStatus = FileUploadStatusEnum.notSelected;
  FileDataModel? fileDataModel;
  final ApiService _apiService = locator<ApiService>();

  changeFileUploadStatus(FileUploadStatusEnum _uploadStatus) {
    fileUploadStatus = _uploadStatus;
    notifyListeners();
  }

  fileSelected(FileDataModel _inputDataModel) {
    fileDataModel = _inputDataModel;
    changeFileUploadStatus(FileUploadStatusEnum.selected);
  }

  uploadFile() async {
    changeFileUploadStatus(FileUploadStatusEnum.uploading);

    Future.delayed(const Duration(seconds: 1), () async {
      var bytes = fileDataModel!.fileData;
      var excel = Excel.decodeBytes(bytes);

      int j = 1;
      bool firstRow = true;

      Map<String, Object> jsonDataOfExcel = {};
      Map<String, dynamic> mp = {};
      List<SongTestmodel> _songModelList = [];

      for (var table in excel.tables.keys) {
        for (List<Data?> row in excel.tables[table]!.rows) {
          if (firstRow == false) {
            List<String> titleList = mp[(++j).toString()] = row.map((e) {
              if (e != null) {
                return e.value.toString();
              } else {
                return "";
              }
            }).toList();

            HighOrLow _highOrLowChLow = HighOrLow(
                type: titleList[13],
                time: titleList[14],
                syllable: titleList[15],
                word: titleList[16],
                phrase: titleList[17]);

            HighOrLow _highOrLowChHigh = HighOrLow(
                type: titleList[18],
                time: titleList[19],
                syllable: titleList[20],
                word: titleList[21],
                phrase: titleList[22]);

            HighOrLow _highOrLowHdLow = HighOrLow(
                type: titleList[23],
                time: titleList[24],
                syllable: titleList[25],
                word: titleList[26],
                phrase: titleList[27]);

            HighOrLow _highOrLowHdHigh = HighOrLow(
                type: titleList[28],
                time: titleList[29],
                syllable: titleList[30],
                word: titleList[31],
                phrase: titleList[32]);

            HighOrLow _highOrLowBellLow = HighOrLow(
                type: titleList[33],
                time: titleList[34],
                syllable: titleList[35],
                word: titleList[36],
                phrase: titleList[37]);

            HighOrLow _highOrLowBellHigh = HighOrLow(
                type: titleList[38],
                time: titleList[39],
                syllable: titleList[40],
                word: titleList[41],
                phrase: titleList[42]);

            SongTestmodel _songTestModel = SongTestmodel(
              title: titleList[0].toString(),
              author: titleList[1].toString(),
              collection: titleList[2].toString(),
              year: int.parse(titleList[3] == '' ? "0" : titleList[3]),
              mood: titleList[4].toString(),
              pages: int.parse(titleList[5] == '' ? "0" : titleList[5]),
              rate: titleList[6].toString(),
              stOrSw: titleList[7].toString(),
              teCh: titleList[8].toLowerCase() == 'true',
              sets: int.parse(titleList[9] == '' ? "0" : titleList[9]),
              keCh: titleList[10].toLowerCase() == 'true',
              themes: titleList[11].split(","),
              morF: titleList[12].toString(),
              thingstonote: titleList[43].toString(),
              analysis: titleList[44].toString(),
              youtubelink: titleList[45].toString(),
              chLow: _highOrLowChLow,
              chHigh: _highOrLowChHigh,
              hdLow: _highOrLowHdLow,
              hdHigh: _highOrLowHdHigh,
              bellLow: _highOrLowBellLow,
              bellHigh: _highOrLowBellHigh,
            );
            _songModelList.add(_songTestModel);
          }
          firstRow = false;
        }
      }

      int successCount = 0;
      for (int i = 0; i < _songModelList.length; i++) {
        ApiResult _apiResult =
            await _apiService.addMusicList(_songModelList[i].toJson());
        await _apiResult.when<FutureOr>(
            success: (model) {
              successCount++;
            },
            failure: (String error) {});

        if (_songModelList.length == successCount) {
          changeFileUploadStatus(FileUploadStatusEnum.uploaded);
        }
      }
    });

    // if (mp.isNotEmpty) {
    //   ApiResult _apiResult = await _apiService.addMusicList(mp);
    //   _apiResult.when(success: (model) {
    //     changeFileUploadStatus(FileUploadStatusEnum.uploaded);
    //   }, failure: (String error) {
    //   });
    // }
  }
}
