import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _langs = {'pt': 'Português', 'en': 'English', 'es': 'Español', 'zh': '中文', 'ru': 'Русский'};
const _icons = ['🍽️', '🛒', '🚗', '🧾', '💊', '🎓', '🎉', '📦'];
const _grey = TextStyle(color: Colors.grey);
const _bold = TextStyle(fontWeight: FontWeight.bold);
const _h = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

const _s = <String, Map<String, String>>{
  'pt': {'home': 'Início', 'list': 'Lançamentos', 'card': 'Cartão', 'set': 'Ajustes', 'income': 'Receitas', 'expense': 'Gastos', 'got': 'Já recebi', 'paid': 'Já paguei', 'left': 'Sobra prevista', 'now': 'Saldo atual', 'where': 'Para onde foi o dinheiro', 'none': 'Nada por aqui ainda', 'desc': 'Descrição (opcional)', 'save': 'Salvar', 'cash': 'Dinheiro', 'debit': 'Débito', 'credit': 'Cartão', 'inst': 'Parcelas', 'inv': 'Fatura do mês', 'tips': 'O que fazer com a sobra', 'prof': 'Perfil de investidor', 'con': 'Conservador', 'mod': 'Moderado', 'bol': 'Arrojado', 'lang': 'Idioma', 'res': 'Caixinha de emergência', 'rf': 'Renda fixa', 'rv': 'Ações e fundos', 'neg': 'Gastos acima das receitas. Maior peso:', 'disc': 'Sugestões educativas, não são recomendação de investimento.', 'local': 'Seus dados ficam só neste aparelho.', 'asap': 'Agora', 'later': 'Depois', 'date': 'Data', 'tot': 'Total', 'part': 'Parte', 'rem': 'Falta', 'pay': 'Pagar', 'rec': 'Receber', 'cats': 'Alimentação|Mercado|Transporte|Contas|Saúde|Estudos|Lazer|Outros'},
  'en': {'home': 'Home', 'list': 'Entries', 'card': 'Card', 'set': 'Settings', 'income': 'Income', 'expense': 'Expenses', 'got': 'Received', 'paid': 'Paid', 'left': 'Expected leftover', 'now': 'Current balance', 'where': 'Where the money went', 'none': 'Nothing here yet', 'desc': 'Description (optional)', 'save': 'Save', 'cash': 'Cash', 'debit': 'Debit', 'credit': 'Credit', 'inst': 'Installments', 'inv': 'Month statement', 'tips': 'What to do with the leftover', 'prof': 'Investor profile', 'con': 'Conservative', 'mod': 'Moderate', 'bol': 'Aggressive', 'lang': 'Language', 'res': 'Emergency fund', 'rf': 'Fixed income', 'rv': 'Stocks and funds', 'neg': 'Spending is above income. Biggest share:', 'disc': 'Educational suggestions, not investment advice.', 'local': 'Your data stays on this device only.', 'asap': 'Now', 'later': 'Later', 'date': 'Date', 'tot': 'Full', 'part': 'Part', 'rem': 'Remaining', 'pay': 'Pay', 'rec': 'Receive', 'cats': 'Food|Groceries|Transport|Bills|Health|Education|Leisure|Other'},
  'es': {'home': 'Inicio', 'list': 'Registros', 'card': 'Tarjeta', 'set': 'Ajustes', 'income': 'Ingresos', 'expense': 'Gastos', 'got': 'Ya cobré', 'paid': 'Ya pagué', 'left': 'Sobrante previsto', 'now': 'Saldo actual', 'where': 'A dónde fue el dinero', 'none': 'Aún no hay nada', 'desc': 'Descripción (opcional)', 'save': 'Guardar', 'cash': 'Efectivo', 'debit': 'Débito', 'credit': 'Crédito', 'inst': 'Cuotas', 'inv': 'Extracto del mes', 'tips': 'Qué hacer con el sobrante', 'prof': 'Perfil de inversor', 'con': 'Conservador', 'mod': 'Moderado', 'bol': 'Agresivo', 'lang': 'Idioma', 'res': 'Fondo de emergencia', 'rf': 'Renta fija', 'rv': 'Acciones y fondos', 'neg': 'Gastos por encima de los ingresos. Mayor peso:', 'disc': 'Sugerencias educativas, no son recomendación de inversión.', 'local': 'Tus datos se quedan solo en este dispositivo.', 'asap': 'Ahora', 'later': 'Después', 'date': 'Fecha', 'tot': 'Total', 'part': 'Parte', 'rem': 'Falta', 'pay': 'Pagar', 'rec': 'Cobrar', 'cats': 'Comida|Mercado|Transporte|Cuentas|Salud|Estudios|Ocio|Otros'},
  'zh': {'home': '首页', 'list': '记录', 'card': '信用卡', 'set': '设置', 'income': '收入', 'expense': '支出', 'got': '已收到', 'paid': '已支付', 'left': '预计结余', 'now': '当前余额', 'where': '钱花在哪了', 'none': '暂无记录', 'desc': '备注（可选）', 'save': '保存', 'cash': '现金', 'debit': '借记卡', 'credit': '信用卡', 'inst': '分期数', 'inv': '本月账单', 'tips': '结余怎么用', 'prof': '投资者类型', 'con': '保守型', 'mod': '稳健型', 'bol': '进取型', 'lang': '语言', 'res': '应急储备', 'rf': '固定收益', 'rv': '股票与基金', 'neg': '支出超过收入。占比最大：', 'disc': '仅为教育性建议，不构成投资建议。', 'local': '数据仅保存在本设备。', 'asap': '现在', 'later': '稍后', 'date': '日期', 'tot': '全额', 'part': '部分', 'rem': '剩余', 'pay': '支付', 'rec': '收款', 'cats': '餐饮|超市|交通|账单|健康|学习|娱乐|其他'},
  'ru': {'home': 'Главная', 'list': 'Записи', 'card': 'Карта', 'set': 'Настройки', 'income': 'Доходы', 'expense': 'Расходы', 'got': 'Получено', 'paid': 'Оплачено', 'left': 'Ожидаемый остаток', 'now': 'Текущий баланс', 'where': 'Куда ушли деньги', 'none': 'Пока пусто', 'desc': 'Описание (необязательно)', 'save': 'Сохранить', 'cash': 'Наличные', 'debit': 'Дебетовая', 'credit': 'Кредитка', 'inst': 'Платежей', 'inv': 'Счёт за месяц', 'tips': 'Что делать с остатком', 'prof': 'Профиль инвестора', 'con': 'Консервативный', 'mod': 'Умеренный', 'bol': 'Агрессивный', 'lang': 'Язык', 'res': 'Резервный фонд', 'rf': 'Облигации и депозиты', 'rv': 'Акции и фонды', 'neg': 'Расходы выше доходов. Больше всего:', 'disc': 'Образовательные советы, не инвестиционная рекомендация.', 'local': 'Данные хранятся только на этом устройстве.', 'asap': 'Сейчас', 'later': 'Позже', 'date': 'Дата', 'tot': 'Полностью', 'part': 'Частично', 'rem': 'Осталось', 'pay': 'Оплатить', 'rec': 'Получить', 'cats': 'Еда|Магазин|Транспорт|Счета|Здоровье|Учёба|Досуг|Другое'},
};

String t(String k) => _s[store.lang]![k]!;
List<String> get cats => t('cats').split('|');

String money(double v) {
  final dotDec = store.lang == 'en' || store.lang == 'zh';
  final parts = v.abs().toStringAsFixed(2).split('.');
  final ip = parts[0].replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => dotDec ? ',' : '.');
  return '${v < 0 ? '−' : ''}R\$ $ip${dotDec ? '.' : ','}${parts[1]}';
}

String _dt(DateTime d) => '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';

class Tx {
  String id, d, m;
  bool income, later;
  double v, pv;
  int c;
  DateTime date;
  Tx({required this.id, required this.income, required this.v, this.pv = 0, this.d = '', this.c = 0, this.m = '', required this.date, this.later = false});
  bool get done => pv >= v - 0.001;
  Map<String, dynamic> toJson() => {'id': id, 'i': income, 'v': v, 'pv': pv, 'd': d, 'c': c, 'm': m, 'date': date.toIso8601String(), 'lt': later};
  factory Tx.fromJson(Map<String, dynamic> j) => Tx(
        id: j['id'] as String,
        income: j['i'] as bool,
        v: (j['v'] as num).toDouble(),
        pv: (j['pv'] as num).toDouble(),
        d: j['d'] as String,
        c: j['c'] as int,
        m: j['m'] as String,
        date: DateTime.parse(j['date'] as String),
        later: j['lt'] as bool,
      );
}

double _sum(Iterable<Tx> l) => l.fold<double>(0, (s, x) => s + x.v);
double _paid(Iterable<Tx> l) => l.fold<double>(0, (s, x) => s + x.pv);

class Store extends ChangeNotifier {
  late SharedPreferences _p;
  List<Tx> tx = [];
  String lang = 'pt', profile = 'mod';
  int lastCat = 0;
  DateTime month = DateTime(DateTime.now().year, DateTime.now().month);

  List<Tx> get monthTx => tx.where((x) => x.date.year == month.year && x.date.month == month.month).toList();

  Future<void> load() async {
    _p = await SharedPreferences.getInstance();
    final dev = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    lang = _p.getString('lang') ?? (_s.containsKey(dev) ? dev : 'pt');
    profile = _p.getString('profile') ?? 'mod';
    lastCat = _p.getInt('lc') ?? 0;
    final raw = _p.getString('tx');
    if (raw != null) {
      tx = (jsonDecode(raw) as List).map((e) => Tx.fromJson(e as Map<String, dynamic>)).toList();
    }
  }

  void _save() {
    _p.setString('tx', jsonEncode(tx.map((e) => e.toJson()).toList()));
    _p.setString('lang', lang);
    _p.setString('profile', profile);
    _p.setInt('lc', lastCat);
    notifyListeners();
  }

  void shift(int n) {
    month = DateTime(month.year, month.month + n);
    notifyListeners();
  }

  void setLang(String v) {
    lang = v;
    _save();
  }

  void setProfile(String v) {
    profile = v;
    _save();
  }

  void add({required bool income, required double v, required String d, required int c, required String m, required DateTime date, required bool later, required bool done, int n = 1}) {
    final base = DateTime.now().microsecondsSinceEpoch;
    final part = (v / n * 100).round() / 100;
    for (var i = 0; i < n; i++) {
      final when = i == 0 ? date : DateTime(date.year, date.month + i, date.day > 28 ? 28 : date.day);
      tx.add(Tx(id: '${base + i}', income: income, v: part, pv: (i == 0 && done) ? part : 0, d: n > 1 ? '$d (${i + 1}/$n)'.trim() : d, c: c, m: m, date: when, later: later));
    }
    if (!income) lastCat = c;
    month = DateTime(date.year, date.month);
    _save();
  }

  void remove(String id) {
    tx.removeWhere((e) => e.id == id);
    _save();
  }

  void pay(String id, double a) {
    final x = tx.firstWhere((e) => e.id == id);
    final rem = x.v - x.pv;
    x.pv = ((x.pv + (a > rem ? rem : a)) * 100).round() / 100;
    _save();
  }

  void undo(String id) {
    tx.firstWhere((e) => e.id == id).pv = 0;
    _save();
  }
}

final store = Store();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await store.load();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: store,
        builder: (_, __) => MaterialApp(
          title: 'Meu Bolso',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorSchemeSeed: const Color(0xFF0D9488), useMaterial3: true),
          darkTheme: ThemeData(colorSchemeSeed: const Color(0xFF0D9488), brightness: Brightness.dark, useMaterial3: true),
          home: Shell(),
        ),
      );
}

class Shell extends StatefulWidget {
  Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[Home(), ListPage(card: false), ListPage(card: true), SettingsPage()];
    return Scaffold(
      body: SafeArea(child: pages[i]),
      floatingActionButton: FloatingActionButton(onPressed: () => showAdd(context), child: const Icon(Icons.add)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: i,
        onDestinationSelected: (v) => setState(() => i = v),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home_outlined), label: t('home')),
          NavigationDestination(icon: const Icon(Icons.receipt_long_outlined), label: t('list')),
          NavigationDestination(icon: const Icon(Icons.credit_card), label: t('card')),
          NavigationDestination(icon: const Icon(Icons.settings_outlined), label: t('set')),
        ],
      ),
    );
  }
}

Widget _card(Widget child) => Card(child: Padding(padding: const EdgeInsets.all(16), child: child));

Widget _monthBar() => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(onPressed: () => store.shift(-1), icon: const Icon(Icons.chevron_left)),
      Text('${store.month.month.toString().padLeft(2, '0')}/${store.month.year}', style: _h),
      IconButton(onPressed: () => store.shift(1), icon: const Icon(Icons.chevron_right)),
    ]);

Widget _bar(String l, double v, double mx, Color col, {String? sub}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l), Text(money(v), style: _bold)]),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(value: mx <= 0 ? 0 : (v / mx).clamp(0.0, 1.0), minHeight: 8, color: col, backgroundColor: Colors.grey.withAlpha(50)),
        ),
        if (sub != null) Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ]),
    );

String _split(List<Tx> l) => '${t('asap')}: ${money(_sum(l.where((x) => !x.later)))} · ${t('later')}: ${money(_sum(l.where((x) => x.later)))}';

class Home extends StatelessWidget {
  Home({super.key});
  @override
  Widget build(BuildContext context) {
    final a = store.monthTx;
    final ei = a.where((x) => x.income).toList();
    final ee = a.where((x) => !x.income).toList();
    final inc = _sum(ei), exp = _sum(ee), left = inc - exp, now = _paid(ei) - _paid(ee);
    final mx = inc > exp ? inc : exp;
    final cs = List.generate(8, (i) => MapEntry(i, _sum(ee.where((x) => x.c == i)))).where((e) => e.value > 0).toList()..sort((p, q) => q.value.compareTo(p.value));
    Widget tip;
    if (left > 0) {
      final p = {'con': [80, 20, 0], 'mod': [50, 30, 20], 'bol': [30, 20, 50]}[store.profile]!;
      const ks = ['res', 'rf', 'rv'];
      tip = Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        for (var i = 0; i < 3; i++)
          if (p[i] > 0)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('${t(ks[i])} · ${p[i]}%'), Text(money(left * p[i] / 100), style: _bold)]),
            ),
        const SizedBox(height: 8),
        Text(t('disc'), style: _grey),
      ]);
    } else if (cs.isNotEmpty) {
      tip = Text('${t('neg')} ${_icons[cs.first.key]} ${cats[cs.first.key]}');
    } else {
      tip = Text(t('none'), style: _grey);
    }
    return ListView(padding: const EdgeInsets.all(16), children: [
      _monthBar(),
      _card(Column(children: [
        Text(t('left'), style: _grey),
        Text(money(left), style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: left < 0 ? Colors.red : null)),
        Text('${t('now')}: ${money(now)}', style: _grey),
      ])),
      _card(Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _bar(t('income'), inc, mx, Colors.green, sub: _split(ei)),
        _bar(t('expense'), exp, mx, Colors.red, sub: _split(ee)),
      ])),
      _card(Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(t('where'), style: _h),
        if (cs.isEmpty) Text(t('none'), style: _grey),
        for (final e in cs) _bar('${_icons[e.key]} ${cats[e.key]}', e.value, exp, Theme.of(context).colorScheme.primary, sub: '${(e.value / exp * 100).round()}%'),
      ])),
      _card(Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [Text(t('tips'), style: _h), const SizedBox(height: 8), tip])),
    ]);
  }
}

class ListPage extends StatelessWidget {
  final bool card;
  ListPage({super.key, required this.card});
  @override
  Widget build(BuildContext context) {
    final a = store.monthTx.where((x) => !card || (!x.income && x.m == 'c')).toList()..sort((p, q) => q.date.compareTo(p.date));
    return ListView(padding: const EdgeInsets.all(16), children: [
      _monthBar(),
      if (card)
        _card(Column(children: [
          Text(t('inv'), style: _grey),
          Text(money(_sum(a)), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        ])),
      if (a.isEmpty)
        Padding(padding: const EdgeInsets.all(32), child: Center(child: Text(t('none'), style: _grey)))
      else
        Card(child: Column(children: [for (final x in a) _row(context, x)])),
    ]);
  }
}

Widget _row(BuildContext c, Tx x) => ListTile(
      leading: IconButton(
        icon: Icon(x.done ? Icons.check_circle : (x.pv > 0 ? Icons.timelapse : Icons.radio_button_unchecked), color: x.done ? Colors.green : null),
        onPressed: () => x.done ? store.undo(x.id) : showPay(c, x),
      ),
      title: Text(x.d.isEmpty ? (x.income ? t('income') : '${_icons[x.c]} ${cats[x.c]}') : x.d),
      subtitle: Text([
        _dt(x.date),
        if (!x.income) cats[x.c],
        if (x.later) '⏳ ${t('later')}',
        if (x.pv > 0 && !x.done) '${money(x.pv)} / ${money(x.v)}',
      ].join(' · ')),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        Text('${x.income ? '+' : '−'}${money(x.v)}', style: TextStyle(fontWeight: FontWeight.bold, color: x.income ? Colors.green : Colors.red)),
        IconButton(icon: const Icon(Icons.close, size: 18), onPressed: () => store.remove(x.id)),
      ]),
    );

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [
        _card(Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(t('lang'), style: _h),
          DropdownButton<String>(
            isExpanded: true,
            value: store.lang,
            items: [for (final e in _langs.entries) DropdownMenuItem(value: e.key, child: Text(e.value))],
            onChanged: (v) => store.setLang(v!),
          ),
        ])),
        _card(Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(t('prof'), style: _h),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            showSelectedIcon: false,
            segments: [for (final k in ['con', 'mod', 'bol']) ButtonSegment(value: k, label: Text(t(k)))],
            selected: {store.profile},
            onSelectionChanged: (s) => store.setProfile(s.first),
          ),
        ])),
        Padding(padding: const EdgeInsets.all(16), child: Center(child: Text(t('local'), style: _grey))),
      ]);
}

const _numKb = TextInputType.numberWithOptions(decimal: true);

void showAdd(BuildContext ctx) {
  var income = false, later = false, done = true;
  var cat = store.lastCat, n = 2;
  var m = 'x';
  final cur = DateTime.now();
  var date = cur;
  if (store.month.year != cur.year || store.month.month != cur.month) {
    final last = DateTime(store.month.year, store.month.month + 1, 0).day;
    date = DateTime(store.month.year, store.month.month, cur.day > last ? last : cur.day);
  }
  final amt = TextEditingController(), desc = TextEditingController();
  showModalBottomSheet(
    context: ctx,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (c) => StatefulBuilder(builder: (c, set) {
      void fix() => done = !later && (income || m != 'c');
      return Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.of(c).viewInsets.bottom + 16),
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SegmentedButton<bool>(
              showSelectedIcon: false,
              segments: [ButtonSegment(value: false, label: Text(t('expense'))), ButtonSegment(value: true, label: Text(t('income')))],
              selected: {income},
              onSelectionChanged: (s) => set(() {
                income = s.first;
                fix();
              }),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: amt,
              autofocus: true,
              keyboardType: _numKb,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(hintText: '0,00', border: OutlineInputBorder()),
            ),
            if (!income) ...[
              const SizedBox(height: 12),
              Wrap(spacing: 8, children: [
                for (var i = 0; i < 8; i++) ChoiceChip(label: Text('${_icons[i]} ${cats[i]}'), selected: cat == i, onSelected: (_) => set(() => cat = i)),
              ]),
            ],
            const SizedBox(height: 12),
            TextField(controller: desc, decoration: InputDecoration(hintText: t('desc'), border: const OutlineInputBorder())),
            if (!income) ...[
              const SizedBox(height: 12),
              SegmentedButton<String>(
                showSelectedIcon: false,
                segments: [ButtonSegment(value: 'x', label: Text(t('cash'))), ButtonSegment(value: 'd', label: Text(t('debit'))), ButtonSegment(value: 'c', label: Text(t('credit')))],
                selected: {m},
                onSelectionChanged: (s) => set(() {
                  m = s.first;
                  fix();
                }),
              ),
            ],
            if (!income && m == 'c')
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(t('inst')),
                DropdownButton<int>(value: n, items: [for (var i = 1; i <= 24; i++) DropdownMenuItem(value: i, child: Text('$i'))], onChanged: (v) => set(() => n = v!)),
              ]),
            const SizedBox(height: 12),
            SegmentedButton<bool>(
              showSelectedIcon: false,
              segments: [ButtonSegment(value: false, label: Text(t('asap'))), ButtonSegment(value: true, label: Text(t('later')))],
              selected: {later},
              onSelectionChanged: (s) => set(() {
                later = s.first;
                fix();
              }),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(t('date')),
              TextButton(
                onPressed: () async {
                  final d = await showDatePicker(context: c, initialDate: date, firstDate: DateTime(2020), lastDate: DateTime(2100));
                  if (d != null) set(() => date = d);
                },
                child: Text(_dt(date)),
              ),
            ]),
            if (!later) CheckboxListTile(contentPadding: EdgeInsets.zero, title: Text(t(income ? 'got' : 'paid')), value: done, onChanged: (v) => set(() => done = v!)),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () {
                final v = double.tryParse(amt.text.replaceAll(',', '.'));
                if (v == null || v <= 0) return;
                store.add(income: income, v: v, d: desc.text.trim(), c: cat, m: income ? '' : m, date: date, later: later, done: done, n: (!income && m == 'c') ? n : 1);
                Navigator.pop(c);
              },
              child: Padding(padding: const EdgeInsets.all(12), child: Text(t('save'))),
            ),
          ]),
        ),
      );
    }),
  );
}

void showPay(BuildContext ctx, Tx x) {
  var full = true;
  final amt = TextEditingController();
  final rem = ((x.v - x.pv) * 100).round() / 100;
  showModalBottomSheet(
    context: ctx,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (c) => StatefulBuilder(
      builder: (c, set) => Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.of(c).viewInsets.bottom + 16),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Center(child: Text(x.d.isEmpty ? (x.income ? t('income') : cats[x.c]) : x.d, style: _h)),
          Center(child: Text('${t('rem')}: ${money(rem)}', style: _grey)),
          const SizedBox(height: 12),
          SegmentedButton<bool>(
            showSelectedIcon: false,
            segments: [ButtonSegment(value: true, label: Text(t('tot'))), ButtonSegment(value: false, label: Text(t('part')))],
            selected: {full},
            onSelectionChanged: (s) => set(() => full = s.first),
          ),
          const SizedBox(height: 12),
          if (full)
            Center(child: Text(money(rem), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)))
          else
            TextField(
              controller: amt,
              autofocus: true,
              keyboardType: _numKb,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(hintText: '0,00', border: OutlineInputBorder()),
            ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () {
              final a = full ? rem : double.tryParse(amt.text.replaceAll(',', '.'));
              if (a == null || a <= 0) return;
              store.pay(x.id, a);
              Navigator.pop(c);
            },
            child: Padding(padding: const EdgeInsets.all(12), child: Text(t(x.income ? 'rec' : 'pay'))),
          ),
        ]),
      ),
    ),
  );
}
