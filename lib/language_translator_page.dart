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
  TextEditingController messageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });
    if (src == "--" || dest == "--") {
      setState(() {
        output = "Failed to translate";
      });
    }
  }

  String getLanguageCode(String language) {
    if (language == "English") {
      return "en";
    } else if (language == "Hindi") {
      return "hi";
    } else if (language == "Gujarati") {
      return "gu";
    }
    else{
      return "--";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(15, 45, 73, 1.0),
      appBar: AppBar(
        title: const Text(
          "Language Translator",
          style: TextStyle(
              color: Color.fromRGBO(201, 188, 141, 1.0),
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(15, 45, 73, 1.0),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    items: language.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLanguage = value!;
                      });
                    },
                    hint: Text(
                      originLanguage,
                      style:
                          const TextStyle(color: Color.fromRGBO(201, 188, 141, 1.0)),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Color.fromRGBO(201, 188, 141, 1.0),
                    size: 40,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  DropdownButton(
                    items: language.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    },
                    hint: Text(
                      destinationLanguage,
                      style:
                          const TextStyle(color: Color.fromRGBO(201, 188, 141, 1.0)),
                    ),
                    dropdownColor: Colors.white,
                    icon:  const Icon(Icons.keyboard_arrow_down,color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  cursorColor: const Color.fromRGBO(201, 188, 141, 1.0),
                  autofocus: false,
                  style: const TextStyle(
                    color: Color.fromRGBO(201, 188, 141, 1.0),
                  ),
                  decoration: const InputDecoration(
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
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(
                        color:Color.fromRGBO(201, 188, 141, 1.0),
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      // Style for the focused border
                      borderSide: BorderSide(
                          color: Color.fromRGBO(201, 188, 141, 1.0), width: 1),
                    ),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  controller: messageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        output = "Please Enter Some Text To Translate";
                      });

                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(201, 188, 141, 1.0)),
                    onPressed: () {
                      setState(() {
                        translate(
                            getLanguageCode(originLanguage),
                            getLanguageCode(destinationLanguage),
                            messageController.text.toString());
                      });
                    },
                    child: const Text("Translate")),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "\n$output",
                style: const TextStyle(
                  color: Color.fromRGBO(201, 188, 141, 1.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
