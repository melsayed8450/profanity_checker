import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:profanity_filter_app/core/pretty_printer.dart';
import 'package:http/http.dart' as http;
import '../profanity/data/routes/remote_routes.dart';
import 'custom_exception.dart';

class ApiProvider {
 
  Future<dynamic> post(XFile? imageFile,) async{

    try {
      var url = Uri.parse(AppRemoteRoutes.baseUrl);
      var request = http.MultipartRequest('POST', url);

      request.fields['models'] = 'nudity-2.0';
      request.fields['api_user'] = '1109846077';
      request.fields['api_secret'] = '4ExKYMNC5RL569Hs2JSk';

      var stream = http.ByteStream(imageFile!.openRead());
      var length = await imageFile.length();
      var multipartFile =
          http.MultipartFile('media', stream, length, filename: 'image.jpg');
      request.files.add(multipartFile);

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      var output = json.decode(responseBody);
     
      return output['nudity']['none'];
    } catch (err) {
      prettyPrint(err.toString());
      throw FetchDataException("internetError");
    }
  }

}
