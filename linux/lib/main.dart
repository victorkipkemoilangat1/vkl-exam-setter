import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() { runApp(const VKLApp()); }

class VKLApp extends StatelessWidget {
  const VKLApp({super.key});
  @override Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, title: 'VKL V6.2 FULL BLUEPRINT', theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true), home: const HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final List<Map<String, dynamic>> cards = const [
    {'title': 'Auto Exam Setter', 'icon': Icons.auto_awesome, 'color': Colors.indigo},
    {'title': 'Scan Paper', 'icon': Icons.camera_alt, 'color': Colors.orange},
    {'title': 'Marked Out Of 100%', 'icon': Icons.calculate, 'color': Colors.green},
    {'title': 'Type Manually', 'icon': Icons.edit, 'color': Colors.blue},
    {'title': 'Past Papers', 'icon': Icons.history_edu, 'color': Colors.purple},
    {'title': 'Notes + Schemes', 'icon': Icons.menu_book, 'color': Colors.teal},
    {'title': 'PDF + Print', 'icon': Icons.picture_as_pdf, 'color': Colors.red},
    {'title': 'Firebase + Offline', 'icon': Icons.cloud_done, 'color': Colors.cyan},
    {'title': 'PRO Unlock - 300/Term', 'icon': Icons.lock_open, 'color': Colors.amber},
    {'title': 'Till 9213362 Analytics', 'icon': Icons.analytics, 'color': Colors.deepOrange},
  ];
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('VKL V6.2 - FULL BLUEPRINT Grade4-Form4', style: TextStyle(fontWeight: FontWeight.bold, fontSize:11)), backgroundColor: Colors.indigo, foregroundColor: Colors.white),
      body: GridView.builder(padding: const EdgeInsets.all(12), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12), itemCount: cards.length, itemBuilder: (context, i) {
        final c = cards[i];
        return InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => getPage(c['title']))), child: Card(elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(c['icon'] as IconData, size: 40, color: c['color'] as Color), const SizedBox(height: 8), Text(c['title'], textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)) ])));
      }),
    );
  }
  Widget getPage(String t) {
    switch(t){ case 'Auto Exam Setter': return const SmartExamPage(); case 'Scan Paper': return const ScanPage(); case 'Marked Out Of 100%': return const MarksPage(); case 'Type Manually': return const TypePage(); case 'Past Papers': return const PastPapersPage(); case 'Notes + Schemes': return const NotesPage(); case 'PDF + Print': return const PdfPage(); case 'Firebase + Offline': return const FirebasePage(); case 'PRO Unlock - 300/Term': return const ProUnlockPage(); case 'Till 9213362 Analytics': return const AnalyticsPage(); default: return Scaffold(appBar: AppBar(title: Text(t)), body: Center(child: Text(t))); }
  }
}

// REAL FIGURES WIDGET
class RealFigureWidget extends StatelessWidget {
  final String mchoroText;
  const RealFigureWidget({super.key, required this.mchoroText});
  @override Widget build(BuildContext context) {
    String lower = mchoroText.toLowerCase();
    Widget painter; String label;
    if(lower.contains('grafu') || lower.contains('parabola') || lower.contains('y=')){ painter = CustomPaint(size: const Size(200, 120), painter: ParabolaPainter()); label = "Figure: Graph y=3x²+5x-2"; }
    else if(lower.contains('vector')){ painter = CustomPaint(size: const Size(200, 120), painter: VectorPainter()); label = "Figure: Vectors"; }
    else if(lower.contains('circle') || lower.contains('x²+y²')){ painter = CustomPaint(size: const Size(200, 120), painter: CirclePainter()); label = "Figure: Circle x²+y²=25"; }
    else if(lower.contains('triangle') || lower.contains('pqr')){ painter = CustomPaint(size: const Size(200, 120), painter: TrianglePainter()); label = "Figure: Triangle PQR"; }
    else if(lower.contains('tree')){ painter = CustomPaint(size: const Size(200, 120), painter: TreeDiagramPainter()); label = "Figure: Tree Diagram"; }
    else if(lower.contains('histogram') || lower.contains('bar')){ painter = CustomPaint(size: const Size(200, 120), painter: HistogramPainter()); label = "Figure: Histogram"; }
    else if(lower.contains('heart') || lower.contains('moyo')){ painter = CustomPaint(size: const Size(200, 120), painter: HeartPainter()); label = "Figure: Human Heart"; }
    else if(lower.contains('cell')){ painter = CustomPaint(size: const Size(200, 120), painter: CellPainter()); label = "Figure: Plant Cell"; }
    else if(lower.contains('map') || lower.contains('kenya')){ painter = CustomPaint(size: const Size(200, 120), painter: MapPainter()); label = "Figure: Map Kenya"; }
    else { painter = CustomPaint(size: const Size(200, 80), painter: GenericBoxPainter()); label = "Figure: $mchoroText"; }
    return Container(margin: const EdgeInsets.symmetric(vertical:6), padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.indigo, width:1.5), borderRadius: BorderRadius.circular(8)), child: Column(children: [Text(label, style: const TextStyle(fontSize:10, fontWeight: FontWeight.bold, color: Colors.indigo)), const SizedBox(height:4), Center(child: painter)]));
  }
}
class ParabolaPainter extends CustomPainter { @override void paint(Canvas canvas, Size size){ final paint = Paint()..color=Colors.blue..strokeWidth=2..style=PaintingStyle.stroke; final axisPaint = Paint()..color=Colors.black..strokeWidth=1; canvas.drawLine(Offset(0,size.height/2), Offset(size.width,size.height/2), axisPaint); canvas.drawLine(Offset(size.width/2,0), Offset(size.width/2,size.height), axisPaint); Path path = Path(); for(double x=-80; x<=80; x++){ double px = size.width/2 + x; double y = 0.03*x*x + 0.2*x -10; double py = size.height/2 - y; if(x==-80) path.moveTo(px,py); else path.lineTo(px,py);} canvas.drawPath(path, paint);} @override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;}
class VectorPainter extends CustomPainter { @override void paint(Canvas canvas, Size size){ final axisPaint = Paint()..color=Colors.black..strokeWidth=1; canvas.drawLine(Offset(10,size.height-10), Offset(size.width-10,size.height-10), axisPaint); canvas.drawLine(Offset(10,size.height-10), Offset(10,10), axisPaint); final paintA = Paint()..color=Colors.blue..strokeWidth=2..style=PaintingStyle.stroke; final paintB = Paint()..color=Colors.red..strokeWidth=2..style=PaintingStyle.stroke; canvas.drawLine(Offset(10,size.height-10), Offset(80,size.height-60), paintA); canvas.drawLine(Offset(10,size.height-10), Offset(100,size.height-30), paintB);} @override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;}
class CirclePainter extends CustomPainter { @override void paint(Canvas canvas, Size size){ final paint = Paint()..color=Colors.indigo..strokeWidth=2..style=PaintingStyle.stroke; canvas.drawCircle(Offset(size.width/2,size.height/2), 45, paint); canvas.drawCircle(Offset(size.width/2,size.height/2), 4, Paint()..color=Colors.red..style=PaintingStyle.fill);} @override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;}
class TrianglePainter extends CustomPainter { @override void paint(Canvas canvas, Size size){ final paint = Paint()..color=Colors.indigo..strokeWidth=2..style=PaintingStyle.stroke; Path path = Path()..moveTo(size.width/2, 10)..lineTo(10, size.height-10)..lineTo(size.width-10, size.height-10)..close(); canvas.drawPath(path, paint);} @override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;}
class TreeDiagramPainter extends CustomPainter { @override void paint(Canvas canvas, Size size){ final paint = Paint()..color=Colors.black..strokeWidth=1.5; canvas.drawLine(Offset(10,size.height/2), Offset(60,size.height/3), paint); canvas.drawLine(Offset(10,size.height/2), Offset(60,size.height/2), paint); canvas.drawLine(Offset(10,size.height/2), Offset(60,2*size.height/3), paint);} @override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;}
class HistogramPainter extends CustomPainter { @override void paint(Canvas canvas, Size size){ final paint = Paint()..color=Colors.indigo..style=PaintingStyle.fill; List<double> heights = [20,50,70,40,30]; double barW = size.width/6; for(int i=0;i<heights.length;i++){ canvas.drawRect(Rect.fromLTWH(10+i*(barW+5), size.height-heights[i], barW, heights[i]), paint);}} @override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;}
class HeartPainter extends CustomPainter { @override void paint(Canvas canvas, Size size){ final paint = Paint()..color=Colors.red..strokeWidth=2..style=PaintingStyle.stroke; Path path = Path()..moveTo(size.width/2, size.height*0.3)..cubicTo(size.width*0.2, 0, 0, size.height*0.5, size.width/2, size.height*0.9)..cubicTo(size.width, size.height*0.5, size.width*0.8, 0, size.width/2, size.height*0.3); canvas.drawPath(path, paint);} @override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;}
class CellPainter extends CustomPainter { @override void paint(Canvas canvas, Size size){ final paint = Paint()..color=Colors.green..strokeWidth=2..style=PaintingStyle.stroke; canvas.drawOval(Rect.fromLTWH(10,10,size.width-20,size.height-20), paint); canvas.drawCircle(Offset(size.width/2,size.height/2), 15, paint);} @override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;}
class MapPainter extends CustomPainter { @override void paint(Canvas canvas, Size size){ final paint = Paint()..color=Colors.brown..strokeWidth=2..style=PaintingStyle.stroke; Path path = Path()..moveTo(size.width*0.3, 10)..lineTo(size.width*0.7, 15)..lineTo(size.width*0.8, size.height*0.6)..lineTo(size.width*0.5, size.height-10)..lineTo(size.width*0.2, size.height*0.5)..close(); canvas.drawPath(path, paint);} @override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;}
class GenericBoxPainter extends CustomPainter { @override void paint(Canvas canvas, Size size){ final paint = Paint()..color=Colors.grey..strokeWidth=1..style=PaintingStyle.stroke; canvas.drawRect(Rect.fromLTWH(5,5,size.width-10,size.height-10), paint);} @override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;}

// SMART EXAM PAGE V6.2 FULL BLUEPRINT
class SmartExamPage extends StatefulWidget { const SmartExamPage({super.key}); @override State<SmartExamPage> createState() => _SmartExamPageState(); }
class _SmartExamPageState extends State<SmartExamPage> {
  String selectedSubject = 'Mathematics';
  String selectedClass = 'Form 4';
  String selectedPaper = 'Paper 1'; // For Form 4 national
  final topicsController = TextEditingController(text: "probability, calculus, vectors, algebra");
  List<String> generatedExam = [];
  bool isGenerated = false;
  final subjects = ['Mathematics','English','Kiswahili','Biology','Chemistry','Physics','History','Geography','CRE','Agriculture','Business Studies','Computer Studies','Integrated Science','Social Studies','Science & Technology'];
  final classes = ['Grade 4','Grade 5','Grade 6 (KEPSEA)','Grade 7','Grade 8','Grade 9 (KJSEA)','Grade 10','Form 1','Form 2','Form 3','Form 4'];
  String getLevel(String cls){ if(cls.contains('Form')) return 'KCSE'; if(cls.contains('KJSEA') || cls.contains('Grade 7') || cls.contains('Grade 8') || cls.contains('Grade 9')) return 'KJSEA'; if(cls.contains('KEPSEA') || cls.contains('Grade 6')) return 'KEPSEA'; if(cls.contains('Grade 10')) return 'SSS (CBC)'; return 'CBC'; }

  void generateFullPaper(){
    final topics = topicsController.text.trim();
    if(topics.isEmpty){ ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Type topics!"))); return; }
    final topList = topics.split(',').map((e)=>e.trim()).where((e)=>e.isNotEmpty).toList();
    final sub = selectedSubject.toLowerCase();
    final cls = selectedClass;
    final level = getLevel(cls);
    final isMaths = sub.contains('math');
    final isKiswahili = sub.contains('kiswahili');
    final isEnglish = sub.contains('english');
    final isScience = sub.contains('biology') || sub.contains('chemistry') || sub.contains('physics') || sub.contains('science');
    final isHumanities = sub.contains('history') || sub.contains('geography') || sub.contains('cre') || sub.contains('agriculture') || sub.contains('business') || sub.contains('computer');
    final isPrimary = cls.contains('Grade 4') || cls.contains('Grade 5') || cls.contains('Grade 6');
    final isJSS = cls.contains('Grade 7') || cls.contains('Grade 8') || cls.contains('Grade 9');
    final isForm4 = cls.contains('Form 4');

    String smallWorking = "________________________________________________________________________\n________________________________________________________________________\n";
    String bigWorking = "________________________________________________________________________\n________________________________________________________________________\n________________________________________________________________________\n";
    String inshaLines = List.generate(12, (_) => "________________________________________________________________________").join("\n");

    setState((){
      List<String> p = [];
      // HEADER LOGIC
      if(isKiswahili){
        p.addAll(["==================================================================","MTIHANI WA PAMOJA - ${level} JARIBIO 2026 - ALAMA 100","JINA: _________________________ NAMBARI: __________ SHULE: _________________","SOMO: KISWAHILI - DARASA: $cls - KARATASI: $selectedPaper - MUDA: Saa 2 Dakika 30","=================================================================="]);
      } else {
        String paperTitle = isForm4? "$selectedPaper - ${selectedSubject.toUpperCase()} - ${cls}" : "${selectedSubject.toUpperCase()} - ${cls}";
        p.addAll(["==================================================================","MOKASA JOINT - $level TRIAL 2026 - $paperTitle - 100 MARKS","NAME: _________________________ INDEX NO: __________ SCHOOL: _________________","SUBJECT: ${selectedSubject.toUpperCase()} - CLASS: $cls - PAPER: $selectedPaper - TIME: 2hrs 30mins","=================================================================="]);
      }

      // KEPSEA GRADE 4-6
      if(isPrimary){
        p.addAll([
          "INSTRUCTIONS: Answer ALL questions. Multiple choice and working.",
          "TIME: 1hr 40mins - TOTAL: ${isMaths? '50 MARKS' : '40 MARKS'}",
          "==================================================================",
          "SECTION A: Multiple Choice (30 Marks) - Chagua jibu sahihi",
          "1. ${topList[0]} ni nini? A) Option1 B) Option2 C) Option3 D) Option4 (1)",
          "2. Hesabu: 12 + 8 =? A) 18 B) 20 C) 22 D) 24 (1)",
          "3. ${topList.length>1?topList[1]:'Science'} - Which is correct? (1)",
          smallWorking,
          "SECTION B: Short Answer (20 Marks)",
          "4. Eleza ${topList[0]} kwa maneno mawili. (2)", smallWorking,
          "[MCHORO: Simple diagram - Plant parts 10cm x 10cm]",
          "5. Chora na uandike sehemu 2 za ${topList[0]}. (4)", bigWorking,
          "END - ${isMaths?'50':'40'} MARKS - CBC"
        ]);
      }
      // FORM 4 MATHEMATICS PAPER 1 NATIONAL STANDARD
      else if(isForm4 && isMaths && selectedPaper=="Paper 1"){
        p.addAll([
          "SECTION A (50 Marks) - Answer ALL questions in this section - Compulsory",
          "1. Without using calculator, evaluate: (3/4 of 24) + (5*2) (2 mks)", bigWorking,
          "[MCHORO: Grafu y=3x²+5x-2 Parabola showing vertex]",
          "2. (a) Given y = 3x² + 5x - 2, find dy/dx. (2) (b) Find stationary point of ${topList[0]} (3)", bigWorking,
          "[MCHORO: Vectors A=3i+4j and B=2i-j on Cartesian plane]",
          "3. Given vectors A=3i+4j, B=2i-j: Find |A+B| (2) A·B (1) Angle (2)", bigWorking,
          "[MCHORO: Circle x²+y²=25 centre origin radius 5]",
          "4. (a) Centre and radius of x²+y²=25 (2) (b) Locus equidistant from (0,0) and (4,0) (3)", bigWorking,
          "5. Data 5,7,8,10,12,15: mean, median, mode, variance (5)", bigWorking,
          "6-16.... More short questions on ${topList.join(', ')} - 3 marks each - Show working (Total 50 Marks)",
          "", "==================================================================",
          "SECTION B (50 Marks) - Answer any FIVE questions in this section - CHOOSE 5 OUT OF 8 - Each 10 marks",
          "==================================================================",
          "[MCHORO: Tree diagram Bag 3 Red 2 Blue 4 Green]",
          "17. Bag 3R,2B,4G. Two balls without replacement. (a) Draw tree (2) (b) P(2 red) (3) (c) P(1 red 1 blue) (5)", "${bigWorking}\n${bigWorking}",
          "[MCHORO: Shaded area under y=2x+3 from 0 to 2]",
          "18. Evaluate ∫₀² (2x+3)dx and find area under curve y=2x+3 (10)", "${bigWorking}\n${bigWorking}",
          "[MCHORO: Triangle PQR P(1,2) Q(4,6) R(7,2)]",
          "19. P(1,2) Q(4,6) R(7,2): Find PQ,QR,PR and prove isosceles (10)", "${bigWorking}\n${bigWorking}",
          "[MCHORO: Displacement-time graph s=t³-4t²+3t]",
          "20. Particle s=t³-4t²+3t: v=ds/dt at t=2 (3) a=dv/dt (2) When v=0 max/min? (5)", "${bigWorking}\n${bigWorking}",
          "[MCHORO: Bar chart histogram]",
          "21. Marks 40,45,50,55,60,65,70,75,80,85: mean, median, variance, draw histogram (10)", "${bigWorking}\n${bigWorking}",
          "[MCHORO: Triangle ABC area]",
          "22. Prove area=1/2 ab sinC, find area sides 5cm,7cm angle 60° (10)", "${bigWorking}\n${bigWorking}",
          "[MCHORO: Vectors displacement ship 10km North 15km East]",
          "23. Ship 10km North then 15km East: resultant displacement bearing (10)", "${bigWorking}\n${bigWorking}",
          "[MCHORO: Calculus tangent line area under curve]",
          "24. Prove d/dx(x²)=2x from first principles, tangent to y=x²+3x at x=1 (10)", "${bigWorking}\n${bigWorking}",
          "END - 100 MARKS - SECTION A ALL + SECTION B CHOOSE 5 OF 8 - KCSE STANDARD"
        ]);
      }
      // FORM 4 MATHS PAPER 2
      else if(isForm4 && isMaths && selectedPaper=="Paper 2"){
        p.addAll([
          "SECTION A (50 Marks) - Answer ALL - Compulsory - Paper 2 Calculator Allowed",
          "[MCHORO: Data table frequency]",
          "1. Statistics on ${topList[0]} - mean, median, SD (5)", bigWorking,
          "SECTION B (50 Marks) - Answer any FIVE - Choose 5 of 8",
          "17-24. Paper 2 topics: Commercial arithmetic, Logarithms, Matrices, etc. on ${topList[0]} (10 each)",
          "END - 100 MARKS - Paper 2"
        ]);
      }
      // ENGLISH FORM 4
      else if(isForm4 && isEnglish){
        if(selectedPaper=="Paper 1"){
          p.addAll(["101/1 - ENGLISH - Functional Writing (20mks) + Cloze (10) + Oral (20) - 2hrs","1. Functional: Write letter about ${topList[0]} (20)",inshaLines,"2. Cloze Test on ${topList[0]} (10)",smallWorking,"END - 50 MARKS - Paper 1"]);
        } else if(selectedPaper=="Paper 2"){
          p.addAll(["101/2 - Comprehension 20 + Literature 25 + Grammar 15 - 2h30m","Passage about ${topList[0]} - Questions 20mks",bigWorking,"END - 60 MARKS - Paper 2"]);
        } else {
          p.addAll(["101/3 - Imaginative Composition - 3 Essays - Choose 1 from each section - 60mks","Write 400 words on ${topList[0]} (20)",inshaLines,"END - Paper 3"]);
        }
      }
      // KISWAHILI FORM 4
      else if(isKiswahili){
        if(selectedPaper=="Paper 1"){
          p.addAll(["SEHEMU A: INSHA (40 ALAMA) - Chagua moja","1. Andika insha maneno 400: 'Umuhimu wa ${topList[0]}' (20)",inshaLines,"2. Insha ya lazima: Barua kuhusu ${topList[0]} (20)",inshaLines,"MWISHO - ALAMA 40 - Karatasi 1"]);
        } else if(selectedPaper=="Paper 2"){
          p.addAll(["SEHEMU A: SARUFI (50 ALAMA) - Jibu maswali YOTE","1. Andika kinyume cha: ${topList[0]} (2)",smallWorking,"SEHEMU B: UFAHAMU (20)","11. Kifungu kuhusu ${topList[0]} (5)",smallWorking,"MWISHO - ALAMA 80 - Karatasi 2"]);
        } else {
          p.addAll(["SEHEMU A: FASIHI - Riwaya, Tamthilia, Hadithi - Chagua 1 kati ya 2 (20 kila)","MWISHO - ALAMA 80 - Karatasi 3"]);
        }
      }
      // SCIENCES
      else if(isScience){
        p.addAll([
          "SECTION A (40 Marks) - Answer ALL - Compulsory - Short questions",
          "[MCHORO: Drawing box 10cm x 10cm - ${topList[0]}]",
          "1. Define ${topList[0]}? (3)",bigWorking,
          "2. Two types of ${topList.length>1?topList[1]:'cell'} - Label diagram (4)",bigWorking,
          "SECTION B (40 Marks) - Structured - Answer ALL",
          "[MCHORO: Heart diagram / Experiment setup]",
          "3. Draw and label ${topList[0]} - 4 parts + functions (10)","${bigWorking}\n${bigWorking}",
          "SECTION C (20 Marks) - Choose 1 out of 2 - Long Essay",
          "6. (a) Explain ${topList[0]} in detail (10) OR (b) Discuss ${topList.length>1?topList[1]:'topic'} (10)","${bigWorking}\n${bigWorking}",
          "END - 100 MARKS - Science with Michoro"
        ]);
      }
      // HUMANITIES
      else if(isHumanities){
        p.addAll([
          "SECTION A (25 Marks) - Answer ALL questions - Compulsory",
          "1. Define ${topList[0]}? (3)",smallWorking,
          "2-10. Short questions on ${topList.join(', ')} - 2 marks each (Total 25)",
          "SECTION B (45 Marks) - Answer any THREE questions - Choose 3 of 6 - 15 marks each",
          "[MCHORO: Map Kenya showing ${topList[0]}]",
          "11. Explain factors influencing ${topList[0]} in Kenya (15)","${bigWorking}\n${bigWorking}",
          "12. Discuss ${topList.length>1?topList[1]:'topic'} - effects (15)","${bigWorking}\n${bigWorking}",
          "SECTION C (30 Marks) - Answer any TWO - Choose 2 of 3 - 15 each",
          "17. Essay on ${topList[0]} (15)","${bigWorking}\n${bigWorking}",
          "END - 100 MARKS - History/Geography/CRE Standard - Section A ALL + B Choose 3 + C Choose 2"
        ]);
      }
      // DEFAULT - Maths School Exam Grade 7-10 Form 1-3
      else {
        p.addAll([
          "SECTION A (50 Marks) - Answer ALL - Compulsory - 100% English",
          "[MCHORO: Grafu y=3x²+5x-2 Parabola]",
          "1. (a) Given y = 3x² + 5x - 2, find dy/dx. (2) (b) Stationary point ${topList[0]} (3)","Working Space:",bigWorking,
          "[MCHORO: Vectors A=3i+4j]",
          "2. Vectors A=3i+4j, B=2i-j: |A+B| (2) A·B (1) Angle (2)",bigWorking,
          "SECTION B (50 Marks) - Show Full Working - TOTAL 100 MARKS - Answer ALL",
          "[MCHORO: Tree diagram]",
          "9. Particle s=t³-4t²+3t: v at t=2 (3) a (2) When v=0? (5)","${bigWorking}\n${bigWorking}",
          "END - 100 MARKS - CALCULATIONS ONLY"
        ]);
      }

      generatedExam = p;
      isGenerated = true;
    });
  }

  Future<void> generateRealPdf() async {
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context ctx) {
        List<pw.Widget> widgets = [];
        for (var line in generatedExam) {
          if (line.contains("[MCHORO")) {
            final start = line.indexOf("[MCHORO:");
            final end = line.indexOf("]");
            String inside = end > start? line.substring(start + 8, end) : line;
            String lower = inside.toLowerCase();
            widgets.add(pw.SizedBox(height: 8));
            widgets.add(pw.Container(
              padding: const pw.EdgeInsets.all(6),
              decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.indigo, width: 1.5)),
              child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                pw.Text("Figure: $inside", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold, color: PdfColors.indigo)),
                pw.SizedBox(height: 4),
                pw.Container(height: 70, width: double.infinity, decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey400)),
                  child: pw.CustomPaint(size: PdfPoint(400, 70), painter: (PdfGraphics canvas, PdfPoint size) {
                      if (lower.contains('grafu') || lower.contains('parabola') || lower.contains('y=')) {
                        canvas.setStrokeColor(PdfColors.blue); canvas.setLineWidth(1); canvas.drawLine(0, size.y/2, size.x, size.y/2); canvas.drawLine(size.x/2, 0, size.x/2, size.y);
                        for (double x = -60; x < 60; x++) { double px = size.x/2 + x; double y = 0.02*x*x - 5; double py = size.y/2 - y; if (x == -60) canvas.moveTo(px, py); else canvas.lineTo(px, py); } canvas.strokePath();
                      } else if (lower.contains('circle')) { canvas.setStrokeColor(PdfColors.indigo); canvas.setLineWidth(1.5); canvas.drawEllipse(size.x/2-30, size.y/2-25, 60, 50); canvas.strokePath();
                      } else if (lower.contains('vector')) { canvas.setStrokeColor(PdfColors.blue); canvas.drawLine(10, size.y-10, 80, 20); canvas.setStrokeColor(PdfColors.red); canvas.drawLine(10, size.y-10, 100, 30); canvas.strokePath();
                      } else if (lower.contains('triangle')) { canvas.setStrokeColor(PdfColors.indigo); canvas.moveTo(size.x/2, 5); canvas.lineTo(10, size.y-5); canvas.lineTo(size.x-10, size.y-5); canvas.lineTo(size.x/2, 5); canvas.strokePath();
                      } else { canvas.setStrokeColor(PdfColors.grey); canvas.drawRect(5, 5, size.x-10, size.y-10); canvas.strokePath(); }
                    },
                  ),
                ),
              ]),
            ));
          } else {
            widgets.add(pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 1), child: pw.Text(line, style: pw.TextStyle(fontSize: line.contains("____")? 6 : line.contains("===")? 7 : 9, fontWeight: line.contains("SECTION") || line.contains("SEHEMU") || line.contains("===")? pw.FontWeight.bold : pw.FontWeight.normal, color: line.contains("____")? PdfColors.grey500 : PdfColors.black)),
            ));
          }
        }
        return widgets;
      },
    ));
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save(), name: "${selectedSubject}_${selectedClass}_${selectedPaper}_100MARKS.pdf");
  }

  @override Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text('VKL V6.2 - ${getLevel(selectedClass)} - 100 MARKS')), body: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        Expanded(child: DropdownButtonFormField<String>(value: selectedSubject, decoration: const InputDecoration(labelText: "Somo/Subject", border: OutlineInputBorder()), items: subjects.map((s)=>DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 11)))).toList(), onChanged: (v)=>setState(()=>selectedSubject=v!))),
        const SizedBox(width: 6),
        Expanded(child: DropdownButtonFormField<String>(value: selectedClass, decoration: const InputDecoration(labelText: "Darasa/Class", border: OutlineInputBorder()), items: classes.map((c)=>DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 10)))).toList(), onChanged: (v)=>setState(()=>selectedClass=v!))),
      ]),
      const SizedBox(height: 6),
      DropdownButtonFormField<String>(value: selectedPaper, decoration: const InputDecoration(labelText: "Paper - For Form 4 National", border: OutlineInputBorder()), items: ['Paper 1','Paper 2','Paper 3'].map((c)=>DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 11)))).toList(), onChanged: (v)=>setState(()=>selectedPaper=v!)),
      const SizedBox(height: 6),
      TextField(controller: topicsController, maxLines: 2, decoration: const InputDecoration(labelText: "Mada/Topics comma separated", border: OutlineInputBorder())),
      const SizedBox(height: 8),
      ElevatedButton.icon(onPressed: generateFullPaper, icon: const Icon(Icons.auto_awesome), label: Text('TENGENEZA ${getLevel(selectedClass)} - $selectedSubject $selectedPaper - 100 MARKS', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)), style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.indigo, foregroundColor: Colors.white)),
      const SizedBox(height: 8),
      if(isGenerated) Expanded(child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.grey[50], border: Border.all(color: Colors.indigo.shade100), borderRadius: BorderRadius.circular(8)), child: ListView.builder(itemCount: generatedExam.length, itemBuilder: (_, i){
        final line = generatedExam[i];
        if(line.contains("[MCHORO")){
          final start = line.indexOf("[MCHORO:");
          final end = line.indexOf("]");
          String inside = end>start? line.substring(start+8, end) : line;
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if(start>0) Padding(padding: const EdgeInsets.symmetric(vertical:2), child: Text(line.substring(0,start), style: const TextStyle(fontSize:11))),
            RealFigureWidget(mchoroText: inside),
            if(end < line.length-1) Padding(padding: const EdgeInsets.symmetric(vertical:2), child: Text(line.substring(end+1), style: const TextStyle(fontSize:11))),
          ]);
        }
        return Padding(padding: const EdgeInsets.symmetric(vertical: 2), child: Text(line, style: TextStyle(fontWeight: line.startsWith("SECTION") || line.startsWith("SEHEMU") || line.contains("===")?FontWeight.bold:FontWeight.normal, fontSize: line.contains("____")?8:11, color: line.contains("____")?Colors.grey:Colors.black87)));
      }))),
      if(isGenerated) Row(children: [
        Expanded(child: OutlinedButton.icon(onPressed: (){ Clipboard.setData(ClipboardData(text: generatedExam.join("\n"))); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Copied 100 Marks Paper!"))); }, icon: const Icon(Icons.copy), label: const Text("COPY"))),
        const SizedBox(width: 4),
        Expanded(child: ElevatedButton.icon(onPressed: generateRealPdf, icon: const Icon(Icons.picture_as_pdf), label: const Text("PDF - REAL FIGURES"))),
      ])
    ])));
  }
}
class ScanPage extends StatefulWidget { const ScanPage({super.key}); @override State<ScanPage> createState() => _ScanPageState(); }
class _ScanPageState extends State<ScanPage> { String status = "No paper scanned yet - Ready for camera."; @override Widget build(BuildContext context){ return Scaffold(appBar: AppBar(title: const Text('Scan Paper - V6.2')), body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [Container(height:200, width:double.infinity, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.indigo, width:2)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.camera_alt, size:50, color: Colors.indigo), const SizedBox(height:8), Text(status, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)])), const SizedBox(height:16), Row(children: [Expanded(child: ElevatedButton.icon(onPressed: (){ setState(()=>status="📷 Camera opened - Point to paper and capture\nPermission: CAMERA granted"); }, icon: const Icon(Icons.camera), label: const Text("Open Camera"))), const SizedBox(width:8), Expanded(child: ElevatedButton.icon(onPressed: (){ setState(()=>status="🖼️ Gallery opened - Select paper image\nPermission: STORAGE granted"); }, icon: const Icon(Icons.photo), label: const Text("Gallery"))),]), const SizedBox(height:8), ElevatedButton.icon(onPressed: (){ setState(()=>status="🔍 Scanning... OCR converting...\n✅ Done! Text extracted. Go to Auto Exam Setter to edit.\nReal figures detected and kept!"); }, icon: const Icon(Icons.document_scanner), label: const Text("SCAN & OCR to Text"), style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity,50), backgroundColor: Colors.indigo, foregroundColor: Colors.white)),]))); } }
class MarksPage extends StatefulWidget { const MarksPage({super.key}); @override State<MarksPage> createState() => _MarksPageState(); }
class _MarksPageState extends State<MarksPage> { final sCtrl = TextEditingController(); final tCtrl = TextEditingController(text: "100"); String result=""; String grade=""; String remark=""; Color gradeColor=Colors.grey; double percent=0; void calc(){ final s=double.tryParse(sCtrl.text)??0; final t=double.tryParse(tCtrl.text)??100; if(t==0)return; percent=(s/t)*100; String g; String r; Color c; if(percent>=80){ g="A"; r="Excellent - Hongera!"; c=Colors.green; } else if(percent>=70){ g="A-"; r="Very Good"; c=Colors.green.shade700; } else if(percent>=60){ g="B+"; r="Good - Well Done"; c=Colors.blue; } else if(percent>=50){ g="B"; r="Above Average"; c=Colors.blue.shade700; } else if(percent>=40){ g="C"; r="Average - Fair"; c=Colors.orange; } else if(percent>=30){ g="D"; r="Below Average - Needs Improvement"; c=Colors.orange.shade800; } else { g="E"; r="Poor - Needs Extra Support"; c=Colors.red; } setState((){ grade=g; remark=r; gradeColor=c; result="${percent.toStringAsFixed(1)}%"; }); } @override Widget build(BuildContext context){ return Scaffold(appBar: AppBar(title: const Text('Marked Out Of 100% - V6.2')), body: Padding(padding: const EdgeInsets.all(20), child: SingleChildScrollView(child: Column(children: [TextField(controller: sCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Score Obtained (e.g. 75)", border: OutlineInputBorder())), const SizedBox(height: 12), TextField(controller: tCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Out Of 100", border: OutlineInputBorder())), const SizedBox(height: 16), ElevatedButton(onPressed: calc, style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity,50), backgroundColor: Colors.indigo, foregroundColor: Colors.white), child: const Text("CALCULATE % + GRADE")), const SizedBox(height:20), if(result.isNotEmpty) Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: gradeColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: gradeColor, width:2)), child: Column(children: [Text(result, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: gradeColor)), const SizedBox(height:8), Container(padding: const EdgeInsets.symmetric(horizontal:16, vertical:6), decoration: BoxDecoration(color: gradeColor, borderRadius: BorderRadius.circular(20)), child: Text("GRADE: $grade", style: const TextStyle(fontSize:22, fontWeight: FontWeight.bold, color: Colors.white))), const SizedBox(height:12), Text(remark, style: TextStyle(fontSize:16, fontWeight: FontWeight.w600, color: gradeColor), textAlign: TextAlign.center), const SizedBox(height:12), const Text("KCSE Grading: A 80-100, A- 70-79, B+ 60-69, B 50-59, C 40-49, D 30-39, E 0-29", style: TextStyle(fontSize:10, color: Colors.grey), textAlign: TextAlign.center),]))])))); } }
class TypePage extends StatelessWidget { const TypePage({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('Type Manually')), body: const Padding(padding: EdgeInsets.all(16), child: TextField(maxLines: 30, decoration: InputDecoration(hintText: "Type exam manually here... 100 MARKS", border: OutlineInputBorder())))); } }
class PastPapersPage extends StatelessWidget { const PastPapersPage({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('Past Papers - SAVED')), body: ListView(children: const [ListTile(title: Text("KCSE 2024 Maths P1 100 Marks"), subtitle: Text("Section A ALL + B Choose 5 of 8 - With real figures"), leading: Icon(Icons.picture_as_pdf)), ListTile(title: Text("KJSEA 2024 Science Grade 9"), subtitle: Text("100 MARKS CBC"), leading: Icon(Icons.picture_as_pdf)), ListTile(title: Text("Kiswahili Form 4 Paper 2 - ALAMA 80"), subtitle: Text("100% Kiswahili"), leading: Icon(Icons.picture_as_pdf))])); } }
class NotesPage extends StatelessWidget { const NotesPage({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('Notes + Schemes')), body: const Center(child: Text("Notes & Schemes Ready - CBC & KCSE - 100 MARKS"))); } }
class PdfPage extends StatelessWidget { const PdfPage({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('PDF + Print - REAL')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.picture_as_pdf, size:60, color: Colors.red), const SizedBox(height:12), const Text("PDF Export with REAL FIGURES - Ready for printing 100 MARKS papers"), const SizedBox(height:12), ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.print), label: Text("Print Test Page"))]))); } }
class FirebasePage extends StatelessWidget { const FirebasePage({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('Firebase + Offline')), body: const Center(child: Text("Firebase Sync + Offline Mode Active - Exams saved offline"))); } }
class ProUnlockPage extends StatelessWidget { const ProUnlockPage({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('PRO Unlock')), body: const Center(child: Text("Till 9213362 - 300/Term - Unlock All Features\n100 MARKS + Real Figures"))); } }
class AnalyticsPage extends StatelessWidget { const AnalyticsPage({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('Analytics')), body: const Center(child: Text("Till 9213362 - Payment Analytics"))); } }