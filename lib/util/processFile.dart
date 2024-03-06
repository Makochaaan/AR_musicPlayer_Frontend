import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:charset_converter/charset_converter.dart';

class ProcessFile {
  Future<File> GetFile() async {
    FilePickerResult? result;
    result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Please Play Music File', type: FileType.audio
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      return File('');
    }
  }

  Future<List<String>> GetTag(File file) async {
    Uint8List tags = await file.readAsBytes();
    tags = tags.sublist(tags.length - 128, tags.length);
    String title = await CharsetConverter.decode("Shift_JIS", tags.sublist(3,33));
    String artist =  await CharsetConverter.decode("Shift_JIS", tags.sublist(33,63));
    String album =  await CharsetConverter.decode("Shift_JIS", tags.sublist(63,93));
    print('Title: $title');
    print('Artist: $artist');
    print('Album: $album');
    return [title, artist, album];
  }

}
