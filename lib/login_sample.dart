import 'package:flutter/material.dart' hide ProgressIndicator;

class MultiSelect extends StatefulWidget {
  final List<String> genres;
  const MultiSelect({Key? key, required this.genres}) : super(key: key);

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> _selectedGenres = [];
  void _genreChange(String genreValue, bool isSelected){
    setState(() {
      if (isSelected){
        _selectedGenres.add(genreValue);
      }else{
        _selectedGenres.remove(genreValue);
      }
    });
  }

  void _cancel(){
    Navigator.pop(context);
  }

  void _submit(){
    Navigator.pop(context, _selectedGenres);
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Genres'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.genres
              .map((item) =>  CheckboxListTile(
              value: _selectedGenres.contains(item),
              title: Text(item),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (isChecked) => _genreChange(item, isChecked!)
          )
          )
              .toList()
        ),
      ),
      actions: [
        TextButton(
            onPressed: _cancel, child: const Text('Cancel')
        ),
        ElevatedButton(
            onPressed: _submit, child: const Text('OK')
        ),
      ],
    );
  }
}

class LoginSample extends StatefulWidget {
  const LoginSample({Key? key}) : super(key: key);

  @override
  State<LoginSample> createState() => _LoginSampleState();
}

class _LoginSampleState extends State<LoginSample> {

  late String firstName;
  late String lastName;
  late String email;
  late String number;
  late bool inPerson;
  late bool virtual;
  List<String> _selectedGenres = [];
  void _showMultiSelect() async {
    final List<String> genres = [
      'Jazz',
      'Pop',
      'Metal',
      'Classical',
      'Hip Hop',
      'Hindi',
      'Indie Pop'
    ];
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(genres: genres);
      },
    );
    if (results != null) {
      setState(() {
        _selectedGenres = results;
      });
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text('Sign Up'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close, color: Colors.white,
            ),
            onPressed: () {
            },
          ),
        ],
      ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
    SizedBox(height: 50.0,
    child: Container(
    child: Text("Let's create your Account",style: TextStyle(fontSize: 30.0, color: Colors.white),),),),
               TextFormField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white54,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.white),
                  ),
                ),
                maxLength: 10,
                validator: (value) {
                  if (value == null) {
                    return 'Name is Required';
                  }
                  return null;
                },
                onSaved: (value) {
                },
              ),

              TextFormField(
    style: TextStyle(color: Colors.white),
    cursorColor: Colors.white54,
    decoration: InputDecoration(labelText: 'Last Name',
      labelStyle: TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.white54
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            width: 1, color: Colors.white),
      ),),
                maxLength: 10,
                validator: (value) {
                  if (value == null) {
                    return 'Name is Required';
                  }
                  return null;
                },
                onSaved: (value) {
                  lastName = value!;
                },
              ),

    TextFormField(
    style: TextStyle(color: Colors.white),
    cursorColor: Colors.white54,
    decoration: InputDecoration(labelText: 'Email',
      labelStyle: TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            width: 1.0, color: Colors.white),
      ),),
      maxLength: 30,
      validator: (value) {
        if (value == null) {
          return 'Email is Required';
        }
        if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }
        return null;
      },
      onSaved: (value) {
        email = value!;
      },
    ),

    TextFormField(
    style: TextStyle(color: Colors.white),
    cursorColor: Colors.white54,
    decoration: InputDecoration(labelText: 'Mobile Number',
      labelStyle: TextStyle(color: Colors.white),
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
    color: Colors.white54
    ),
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
    width: 1, color: Colors.white),
    ),),
    maxLength: 10,
    validator: (value) {
    if (value == null) {
    return 'Number is Required';
    }
    return null;
    },
    onSaved: (value) {
    number = value!;
    },
    ),
    SizedBox(
      height: 60.0,
      width: 400.0,
    child :ElevatedButton(
        onPressed: _showMultiSelect,
        child: const Text('Select Genres', style: TextStyle(color: Colors.white),)
    ),),
              const Divider(
              height: 38,
              ),
              Wrap(
    children: _selectedGenres
    .map((e) => Chip(
                  label: Text(e),
              ),)
              .toList(),
    ),
              SizedBox(height: 16.0,),
              CheckboxListTile(
                  checkColor: Colors.white,
                title: Text('In Person', style: TextStyle(color: Colors.white),),
                  value: true, onChanged: newValue()

              ),
              SizedBox(height: 16.0,),
              CheckboxListTile(
                checkColor: Colors.white,
                  title: Text('Virtual',style: TextStyle(color: Colors.white),),
                  value: true, onChanged: newValue()

              ),
             
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                },
                child: const Text('Sumbit'),
              ),
            ],
          )
    ),);

  }

  newValue() {
    value: true;
  }
}