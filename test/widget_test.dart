import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage()));

class Data {
  static List<String> allLevels = ["PP1","PP2","Grade 1","Grade 2","Grade 3","Grade 4","Grade 5","Grade 6","Grade 7","Grade 8","Grade 9","Form 1","Form 2","Form 3","Form 4"];
  static List<String> cbcSub = ["Mathematics","English","Kiswahili","Science","Social Studies","CRE"];
  static List<String> secSub = ["Mathematics","English","Kiswahili","Biology","Chemistry","Physics","History","Geography"];
  static List<String> papers = ["Paper 1","Paper 2","Paper 3"];
  static List<String> getSub(String l) => l.contains("Form") ? secSub : cbcSub;
}

class LoginPage extends StatelessWidget {
  final c = TextEditingController(text: "VKL Academy Isiolo");
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(padding: EdgeInsets.all(20), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.school, size: 70, color: Colors.purple),
      Text("VKL EXAM SETTER PRO", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      SizedBox(height: 20),
      TextField(controller: c, decoration: InputDecoration(labelText: "School Name", border: OutlineInputBorder())),
      SizedBox(height: 20),
      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, minimumSize: Size(double.infinity, 50)), onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> Home(school: c.text))), child: Text("LOGIN", style: TextStyle(color: Colors.white))),
      Text("Till: 9213362", style: TextStyle(color: Colors.red)),
    ])));
  }
}

class Home extends StatefulWidget {
  final String school; Home({required this.school});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String level="Grade 7", subject="Mathematics", paper="Paper 1";
  List<String> qs=[]; 
  final manual = TextEditingController();
  final topic = TextEditingController();

  void addM(){ if(manual.text.isNotEmpty){ setState(()=> qs.add(manual.text)); manual.clear(); } }
  void auto(){ if(topic.text.isEmpty) return; setState(()=> qs=["Define ${topic.text} (2m)","Types of ${topic.text} (3m)","Importance of ${topic.text} in $subject (5m)","Process of ${topic.text} (4m)"]); }

  Future<void> printPdf() async {
    final p = await SharedPreferences.getInstance();
    bool paid = p.getBool('paid')??false; int cnt = p.getInt('cnt')??0;
    if(cnt>=2 && !paid){ showDialog(context: context, builder: (_)=> AlertDialog(title: Text("Lipa Till 9213362"), content: Text("2 FREE done. Pay 100 to Till 9213362"), actions: [ElevatedButton(onPressed: () async { await p.setBool('paid', true); Navigator.pop(context); }, child: Text("I PAID"))])); return; }
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(build: (c)=> [pw.Text(widget.school, style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)), pw.Text("$level $subject $paper"), pw.Divider(), if(!paid) pw.Text("PREVIEW - PAY TILL 9213362", style: pw.TextStyle(color: PdfColors.red)), ...qs.map((e)=> pw.Text(e))]));
    await Printing.layoutPdf(onLayout: (_)=> pdf.save());
    await p.setInt('cnt', cnt+1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.school), backgroundColor: Colors.purple, foregroundColor: Colors.white, actions: [IconButton(onPressed: printPdf, icon: Icon(Icons.print))]), body: ListView(padding: EdgeInsets.all(12), children: [
      Row(children: [Expanded(child: DropdownButtonFormField(value: level, items: Data.allLevels.map((e)=> DropdownMenuItem(value:e, child: Text(e, style: TextStyle(fontSize:10)))).toList(), onChanged: (v)=> setState((){ level=v!; subject=Data.getSub(level).first; }), decoration: InputDecoration(labelText: "Level"))), SizedBox(width:5), Expanded(child: DropdownButtonFormField(value: paper, items: Data.papers.map((e)=> DropdownMenuItem(value:e, child: Text(e))).toList(), onChanged: (v)=> setState(()=> paper=v!), decoration: InputDecoration(labelText: "Paper")))]),
      DropdownButtonFormField(value: subject, items: Data.getSub(level).map((e)=> DropdownMenuItem(value:e, child: Text(e))).toList(), onChanged: (v)=> setState(()=> subject=v!), decoration: InputDecoration(labelText: "Subject")),
      Divider(), Text("✅ Manual one by one", style: TextStyle(fontWeight: FontWeight.bold)), Row(children: [Expanded(child: TextField(controller: manual, decoration: InputDecoration(hintText: "Type question"))), IconButton(onPressed: addM, icon: Icon(Icons.add_circle, color: Colors.purple, size:35))]),
      Divider(), Text("✅ Auto from topics", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)), Row(children: [Expanded(child: TextField(controller: topic, decoration: InputDecoration(hintText: "e.g. Photosynthesis", border: OutlineInputBorder()))), SizedBox(width:5), ElevatedButton(onPressed: auto, child: Text("AUTO"))]),
      Divider(), Text("✅ Scan to Marking Scheme", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)), ElevatedButton.icon(onPressed: (){ showDialog(context: context, builder: (_)=> AlertDialog(title: Text("Scan"), content: TextField(onSubmitted: (v){ setState(()=> qs.add(v)); Navigator.pop(context); }, decoration: InputDecoration(hintText: "Paste scanned")))); }, icon: Icon(Icons.camera), label: Text("SCAN"), style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white)),
      Divider(), Text("Questions: ${qs.length} - $paper"), ...qs.map((e)=> Card(child: ListTile(title: Text(e)))),
      SizedBox(height:20), ElevatedButton.icon(onPressed: printPdf, icon: Icon(Icons.picture_as_pdf), label: Text("PDF PRINT - Till 9213362"), style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, foregroundColor: Colors.white, minimumSize: Size(double.infinity, 50))),
    ]));
  }
}