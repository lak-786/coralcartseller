String? validateMail(String value){

  if(value.isNotEmpty){
    final bool emailValid = 
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
      if(emailValid){
        return null;
      }else{
        return "check your mail";
      }
  }else{

    return "fill the value";
  }
}
String? validatePassword(String value){
  if(value.isEmpty){
    return "fill the value";
  }else{
    if(value.length<8){
      return "minimum 8 characters";
    }else{
      return null;
    }
  }
}

