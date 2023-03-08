
import 'dart:io';

//Converting the json data to string to use it in the test cases.
String fixture(String fileName) => File('test/fixtures/$fileName').readAsStringSync();