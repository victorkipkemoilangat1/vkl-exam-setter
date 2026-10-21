import 'package:flutter/material.dart';

void main() => runApp(VKLExamSetterApp());

class VKLExamSetterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VKL Exam Setter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ExamHomePage(),
    );
  }
}

class ExamHomePage extends StatefulWidget {
  @override
  _ExamHomePageState createState() => _ExamHomePageState();
}

class _ExamHomePageState extends State<ExamHomePage> {
  String selectedClass = 'Form 4';
  String selectedSubject = 'Mathematics';
  String selectedTerm = 'Term 2';

  final classes = ['Grade 4', 'Grade 5', 'Grade 6', 'Grade 7', 'Grade 8', 'Grade 9', 'Form 1', 'Form 2', 'Form 3', 'Form 4'];
  final subjects = ['Mathematics', 'English', 'Kiswahili', 'Science', 'Social Studies', 'CRE', 'Biology', 'Chemistry', 'Physics', 'History', 'Geography'];
  final terms = ['Term 1', 'Term 2', 'Term 3'];

  bool get isPrimary46 => ['Grade 4', 'Grade 5', 'Grade 6'].contains(selectedClass);
  bool get isJunior79 => ['Grade 7', 'Grade 8', 'Grade 9'].contains(selectedClass);
  bool get isSecondary => ['Form 1', 'Form 2', 'Form 3', 'Form 4'].contains(selectedClass);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('VKL Exam Setter - KNEC Format'), backgroundColor: Colors.indigo),
      body: Row(
        children: [
          // Left Controls
          Container(
            width: 300,
            color: Colors.grey[100],
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('EXAM SETTINGS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 20),
                DropdownButtonFormField(value: selectedClass, items: classes.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => selectedClass = v!), decoration: InputDecoration(labelText: 'Class', border: OutlineInputBorder())),
                SizedBox(height: 12),
                DropdownButtonFormField(value: selectedSubject, items: subjects.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => selectedSubject = v!), decoration: InputDecoration(labelText: 'Subject', border: OutlineInputBorder())),
                SizedBox(height: 12),
                DropdownButtonFormField(value: selectedTerm, items: terms.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => selectedTerm = v!), decoration: InputDecoration(labelText: 'Exam', border: OutlineInputBorder())),
                SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.all(12),
                  color: Colors.blue[50],
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('FORMAT PREVIEW:', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    if (isPrimary46) Text('✓ 40 Questions\n✓ All compulsory\n✓ No sections'),
                    if (isJunior79) Text('✓ Section A: 20 Qs (1-20)\n✓ Section B: 6 Qs (21-26)\n✓ Answer 4 in B\n✓ Total: 40 marks'),
                    if (isSecondary) Text('✓ Section I: 16 Qs (1-16)\n✓ Section II: 8 Qs (17-24)\n✓ Answer ANY 5 in Sec II\n✓ Examiner\'s Table\n✓ Total: 80 Marks'),
                  ]),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () => setState(() {}),
                  style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50), backgroundColor: Colors.indigo),
                  child: Text('GENERATE EXAM', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          // Right Preview
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Center(child: Column(children: [
                      Text('VKL ACADEMY', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      Text('$selectedSubject - $selectedClass', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('$selectedTerm EXAMINATION 2026', style: TextStyle(fontSize: 14)),
                      SizedBox(height: 8),
                      Text('Time: ${isPrimary46? "1 Hr 30 Min" : isJunior79? "2 Hrs" : "2 Hrs 30 Min"}', style: TextStyle(fontSize: 12)),
                      Divider(thickness: 2),
                    ])),
                    SizedBox(height: 12),
                    Text('INSTRUCTIONS TO CANDIDATES', style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                    SizedBox(height: 8),
                    if (isPrimary46)...[
                      Text('1. Answer ALL questions.'),
                      Text('2. Each question 1 mark, total 40 marks.'),
                    ],
                    if (isJunior79)...[
                      Text('1. Answer ALL questions in Section A.'),
                      Text('2. In Section B, answer any FOUR questions.'),
                      Text('3. Each question in Section B carries 5 marks.'),
                    ],
                    if (isSecondary)...[
                      Text('1. This paper has TWO sections: I and II.'),
                      Text('2. Answer ALL questions in Section I (16 questions).'),
                      Text('3. In Section II, answer ANY FIVE questions (Questions 17-24).'),
                      Text('4. All working must be clearly shown.'),
                      Text('5. KNEC Mathematical tables may be used.'),
                    ],
                    SizedBox(height: 20),

                    // EXAMINER'S TABLE FOR SECONDARY
                    if (isSecondary)...[
                      Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          child: Column(children: [
                            Container(color: Colors.grey[300], padding: EdgeInsets.all(4), child: Text('FOR EXAMINER\'S USE ONLY', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                            Table(
                              border: TableBorder.all(),
                              columnWidths: {0: FixedColumnWidth(60)},
                              children: [
                                TableRow(children: [paddingText('Question'), paddingText('1'), paddingText('2'), paddingText('3'), paddingText('4'), paddingText('5'), paddingText('6'), paddingText('7'), paddingText('8')]),
                                TableRow(children: [paddingText('Max'), paddingText('4'), paddingText('4'), paddingText('4'), paddingText('4'), paddingText('4'), paddingText('4'), paddingText('4'), paddingText('4')]),
                                TableRow(children: [paddingText('Score'), paddingText(''), paddingText(''), paddingText(''), paddingText('')]),
                              ],
                            ),
                            Table(
                              border: TableBorder.all(),
                              children: [
                                TableRow(children: [paddingText('Q9'), paddingText('10'), paddingText('11'), paddingText('12'), paddingText('13'), paddingText('14'), paddingText('15'), paddingText('16')]),
                                TableRow(children: [paddingText('4'), paddingText('4'), paddingText('4'), paddingText('4'), paddingText('4'), paddingText('4'), paddingText('4'), paddingText('4')]),
                                TableRow(children: [paddingText(''), paddingText(''), paddingText(''), paddingText('')]),
                              ],
                            ),
                            Table(
                              border: TableBorder.all(),
                              children: [
                                TableRow(children: [paddingText('Sec II'), paddingText('17'), paddingText('18'), paddingText('19'), paddingText('20'), paddingText('21'), paddingText('22'), paddingText('23'), paddingText('24'), paddingText('TOTAL')]),
                                TableRow(children: [paddingText('10'), paddingText('10'), paddingText('10'), paddingText('10'), paddingText('10'), paddingText('10'), paddingText('10'), paddingText('10'), paddingText('80')]),
                                TableRow(children: [paddingText(''), paddingText(''), paddingText(''), paddingText(''), paddingText('')]),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],

                    // QUESTIONS
                    if (isPrimary46)...[
                      Text('Answer ALL questions (40 Marks)', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 12),
                      for (int i = 1; i <= 40; i++) questionWidget(i, '${selectedSubject} question $i: What is the correct answer for ${selectedSubject.toLowerCase()} concept $i?'),
                    ],
                    if (isJunior79)...[
                      Text('SECTION A (20 Marks) - Answer ALL questions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Divider(),
                      for (int i = 1; i <= 20; i++) questionWidget(i, 'Grade ${selectedClass} ${selectedSubject} concept $i explained with example.'),
                      SizedBox(height: 20),
                      Text('SECTION B (20 Marks) - Answer any FOUR questions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('(Each question 5 marks)', style: TextStyle(fontStyle: FontStyle.italic)),
                      Divider(),
                      for (int i = 21; i <= 26; i++) questionWidget(i, 'Section B - ${selectedSubject} structured question $i. (a) Define... (2mks) (b) Explain... (3mks)', isSectionB: true),
                    ],
                    if (isSecondary)...[
                      Text('SECTION I (64 Marks) - Answer ALL questions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Divider(),
                      for (int i = 1; i <= 16; i++) questionWidget(i, '${selectedSubject} Form ${selectedClass} - Question $i: Solve / Calculate / Explain the concept with clear working. [4 marks]', marks: 4),
                      SizedBox(height: 20),
                      Text('SECTION II (40 Marks) - Answer ANY FIVE questions from this section', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Questions 17-24, each 10 marks. Answer any FIVE.', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                      Divider(),
                      for (int i = 17; i <= 24; i++) questionWidget(i, 'SECTION II - Q$i: (a) ${selectedSubject} advanced problem solving part A [5 mks] (b) Application and analysis part B [5 mks]', marks: 10, isSectionII: true),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget paddingText(String t) => Padding(padding: EdgeInsets.all(4), child: Text(t, style: TextStyle(fontSize: 9), textAlign: TextAlign.center));
  Widget questionWidget(int no, String text, {int marks = 1, bool isSectionB = false, bool isSectionII = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$no. ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(text),
            SizedBox(height: 4),
            if (isSectionB || isSectionII) SizedBox(height: 40, child: Text('________________________________________________________________________')),
          ])),
          if (marks > 1) Text(' [$marks mks]', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}