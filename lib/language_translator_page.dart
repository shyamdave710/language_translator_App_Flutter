import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({super.key});

  @override
  State<LanguageTranslationPage> createState() =>
      _LanguageTranslationPageState();
}

class _LanguageTranslationPageState extends State<LanguageTranslationPage> {
  var language = ['Hindi', 'Gujarati', 'English'];
  var originLanguage = "From";
  var destinationLanguage = "To";
  var output = "";
  TextEditingController message = TextEditingController();

  void translate(String src, String dest,String input) async{
    GoogleTranslator translator=new GoogleTranslator();
    var translation = await translator.translate(input,from: src,to: dest);
    setState(() {
      output = translation.text.toString();
    });
    if(src=="--" || dest=="--")
      {
          setState(() {
            output = "Failed to translate";
          });
      }
  }

  String getLanguageCode(String language){
    if(language=="English")
      {
        return "en";
      }
    else if(language=="Hindi")
      {
        return "hi";
      }
    else if(language=="Gujarati")
      {
        return "guj";
      }
    return "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(15, 45, 73, 1.0),
      appBar: AppBar(
        title: Text(
          "Language Translator",
          style: TextStyle(
              color: Color.fromRGBO(201, 188, 141, 1.0),
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(15, 45, 73, 1.0),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    items: language.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLanguage = value!;
                      });
                    },
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      originLanguage,
                      style:
                          TextStyle(color: Color.fromRGBO(201, 188, 141, 1.0)),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Color.fromRGBO(201, 188, 141, 1.0),
                    size: 40,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  DropdownButton(
                    items: language.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    },
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguage,
                      style:
                          TextStyle(color: Color.fromRGBO(201, 188, 141, 1.0)),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  cursorColor: Color.fromRGBO(201, 188, 141, 1.0),
                  autofocus: false,
                  style: TextStyle(
                    color: Color.fromRGBO(201, 188, 141, 1.0),
                  ),
                  decoration: InputDecoration(
                    // Styles for the text field decoration
                    labelText: 'Please Enter Text',
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(201, 188, 141, 1.0),
                    ),
                    border: OutlineInputBorder(
                      // Style for the unfocused border
                      borderSide: BorderSide(
                        color: Color.fromRGBO(
                            201, 188, 141, 1.0), // Color of the border
                        width: 2, // Width of the border line
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      // Style for the focused border
                      borderSide: BorderSide(
                          color: Color.fromRGBO(201, 188, 141, 1.0), width: 1),
                    ),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  controller: message,
                  validator: (value)  {
                    if(value==null || value.isEmpty)
                      {
                        return 'Please Enter Some Text To Translate';
                      }
                    return null;
                  },
                ),
              ),
              Padding(padding: EdgeInsets.all(8),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color.fromRGBO(15, 45, 73, 1.0)),
                  onPressed: (){
                    translate(originLanguage, getLanguageCode(destinationLanguage), message.text.toString());
                  }, child: Text("Translate")),),
              SizedBox(height: 40,),
              Text("\n$output",style: TextStyle(color:Color.fromRGBO(201, 188, 141, 1.0),),),
            ],
          ),
        ),
      ),
    );
  }
}
