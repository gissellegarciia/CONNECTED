import 'package:flutter/material.dart';

void main() {
  runApp(ConnectedApp());
}

class ConnectedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConnectedApp',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 11, 11, 11),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Color.fromARGB(255, 18, 15, 17)),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ConnecteApp'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '·C O N       E C T      ED ·',
              style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 80),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeaturesPage()),
                );
              },
              child: Text('H e r r a m i e n t as'),
            ),
            SizedBox(height: 70),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventListPage()),
                );
              },
              child: Text('O r g a n i z a r     q u e d a d a'),
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Características'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Eventos Personalizados'),
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text('Invitaciones y Confirmaciones'),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Recordatorios y actualizaciones en Tiempo Real'),
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Planificación colaborativa y votación'),
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Comparte recuerdos '),
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Presupuesto'),
          ),
        ],
      ),
    );
  }
}

class EventListPage extends StatefulWidget {
  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  List<Event> events = [];

  void _addEvent(Event event) {
    setState(() {
      events.add(event);
    });
  }

  void _editEvent(int index, Event event) {
    setState(() {
      events[index] = event;
    });
  }

  void _deleteEvent(int index) {
    setState(() {
      events.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organizar quedada'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return ListTile(
            title: Text(event.title),
            subtitle: Text('${event.date} - ${event.time}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventFormPage(
                          event: event,
                          onSubmit: (updatedEvent) =>
                              _editEvent(index, updatedEvent),
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteEvent(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.account_circle),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventFormPage(
                onSubmit: _addEvent,
              ),
            ),
          );
        },
      ),
    );
  }
}

class EventFormPage extends StatefulWidget {
  final Event? event;
  final Function(Event) onSubmit;

  EventFormPage({this.event, required this.onSubmit});

  @override
  _EventFormPageState createState() => _EventFormPageState();
}

class _EventFormPageState extends State<EventFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _date;
  late String _time;
  late String _location;
  late double _budget;

  @override
  void initState() {
    super.initState();
    _title = widget.event?.title ?? '';
    _date = widget.event?.date ?? '';
    _time = widget.event?.time ?? '';
    _location = widget.event?.location ?? '';
    _budget = widget.event?.budget ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event == null ? 'Crear Quedada' : 'Editar Quedada'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              initialValue: _title,
              decoration: InputDecoration(labelText: 'Título'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pon un título';
                }
                return null;
              },
              onSaved: (value) => _title = value!,
            ),
            TextFormField(
              initialValue: _date,
              decoration: InputDecoration(labelText: 'Fecha'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pon una fecha';
                }
                return null;
              },
              onSaved: (value) => _date = value!,
            ),
            TextFormField(
              initialValue: _time,
              decoration: InputDecoration(labelText: 'Hora'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pon una hora';
                }
                return null;
              },
              onSaved: (value) => _time = value!,
            ),
            TextFormField(
              initialValue: _location,
              decoration: InputDecoration(labelText: 'Lugar'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pon un lugar';
                }
                return null;
              },
              onSaved: (value) => _location = value!,
            ),
            TextFormField(
              initialValue: _budget.toString(),
              decoration: InputDecoration(labelText: 'Presupuesto'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pon un presupuesto';
                }
                return null;
              },
              onSaved: (value) => _budget = double.parse(value!),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onSubmit(Event(
                    title: _title,
                    date: _date,
                    time: _time,
                    location: _location,
                    budget: _budget,
                  ));
                  Navigator.pop(context);
                }
              },
              child: Text('Guardar :)'),
            ),
          ],
        ),
      ),
    );
  }
}

class Event {
  final String title;
  final String date;
  final String time;
  final String location;
  final double budget;

  Event({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.budget,
  });
}
