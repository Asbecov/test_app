import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

const String kFontFamily = "Montserrat Alternates";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) =>
      const MaterialApp(home: SubscriptionPage());
}

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  late RadioCardInfo _selectedCard = radioCards.first;

  final List<RadioCardInfo> radioCards = <RadioCardInfo>[
    const RadioCardInfo(
      type: SubscriptionType.month,
      description: "Подписка на 1 месяц",
      price: 299,
      features: [
        "Безлимитный доступ к тренировкам",
        "Персональные рекомендации",
        "Поддержка тренера",
      ],
    ),
    const RadioCardInfo(
      type: SubscriptionType.halfYear,
      description: "Подписка на 6 месяцев",
      price: 1499,
      oldPrice: 1794,
      features: [
        "Безлимитный доступ к тренировкам",
        "Персональные рекомендации",
        "Поддержка тренера",
      ],
    ),
  ];

  void _handleCardChange(RadioCardInfo value) {
    setState(() {
      _selectedCard = radioCards.firstWhere(
        (card) => card.type == value.type,
      );
    });
  }

  List<Widget> get _effectiveChildren => radioCards
      .map(
        (card) => card.oldPrice == null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: RadioCard<RadioCardInfo>(
                  groupValue: _selectedCard,
                  value: card,
                  onChange: _handleCardChange,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SaleWrapper(
                  child: RadioCard<RadioCardInfo>(
                    groupValue: _selectedCard,
                    value: card,
                    onChange: _handleCardChange,
                  ),
                ),
              ),
      )
      .toList();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white.withOpacity(0.4),
              size: 18,
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: AppBackdrop(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              36.5,
              kToolbarHeight,
              36.5,
              53,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Выберите подписку",
                      style: TextStyle(
                        fontFamily: kFontFamily,
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0, 4),
                            blurRadius: 12,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 80.0),
                    ..._effectiveChildren,
                    BrandButton(
                      title: "Купить",
                      onTap: () {},
                    ),
                  ],
                ),
                const Footer(),
              ],
            ),
          ),
        ),
      );
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureRecognizerBuilder(
              onTap: () {},
              builder: (context, recognizer) {
                return Text.rich(
                  overflow: TextOverflow.fade,
                  TextSpan(
                    text: "terms of use",
                    recognizer: recognizer,
                    mouseCursor: SystemMouseCursors.click,
                    style: TextStyle(
                      fontFamily: kFontFamily,
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }),
          GestureRecognizerBuilder(
              onTap: () {},
              builder: (context, recognizer) {
                return Text.rich(
                  overflow: TextOverflow.fade,
                  TextSpan(
                    text: "privacy policy",
                    recognizer: recognizer,
                    mouseCursor: SystemMouseCursors.click,
                    style: TextStyle(
                      fontFamily: kFontFamily,
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0x1A6B66D8),
                  borderRadius: BorderRadius.circular(29),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  overflow: TextOverflow.fade,
                  "Restore purchase",
                  style: TextStyle(
                    fontFamily: kFontFamily,
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}

class BrandButton extends StatelessWidget {
  const BrandButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: 60,
            width: constraints.maxWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Material(
                child: Ink(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF6B66D8),
                        Color(0xFFBABAD7),
                      ],
                    ),
                  ),
                  child: InkWell(
                    onTap: onTap,
                    child: Center(
                      child: Text(
                        overflow: TextOverflow.fade,
                        title,
                        style: const TextStyle(
                          fontFamily: kFontFamily,
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
}

class AppBackdrop extends StatelessWidget {
  const AppBackdrop({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: 80,
            left: -199,
            child: Container(
              width: 317,
              height: 359,
              decoration: const BoxDecoration(
                color: Color(0xFF6B66D8),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 370,
            right: -245,
            child: Container(
              width: 414,
              height: 359,
              decoration: const BoxDecoration(
                color: Color(0xFF6B66D8),
                shape: BoxShape.circle,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: const SizedBox.expand(),
          ),
          child,
        ],
      );
}

class RadioCard<T extends RadioCardInfo> extends StatelessWidget {
  const RadioCard({
    super.key,
    required this.groupValue,
    required this.value,
    required this.onChange,
  });

  final T groupValue;
  final T value;
  final ValueChanged<T> onChange;

  Duration get _duration => const Duration(milliseconds: 300);

  bool get _selected => groupValue == value;

  Widget get _effectiveRadio => _selected
      ? Container(
          height: 28,
          width: 28,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF6B66D8),
                Color(0xFFBABAD7),
              ],
            ),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 14,
          ),
        )
      : Container(
          height: 28,
          width: 28,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            shape: BoxShape.circle,
          ),
        );

  double get _effectiveHeight => _selected ? 272 : 131;

  Decoration get _effectiveDecoration => _selected
      ? BoxDecoration(
          borderRadius: BorderRadius.circular(29),
          color: Colors.black.withOpacity(0.37),
        )
      : BoxDecoration(
          borderRadius: BorderRadius.circular(29),
          color: Colors.white.withOpacity(0.1),
        );

  CrossFadeState get _effectiveCrossFadeState =>
      _selected ? CrossFadeState.showSecond : CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _selected ? GradientTrimPainter() : null,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => onChange(value),
            child: AnimatedContainer(
              duration: _duration,
              height: _effectiveHeight,
              decoration: _effectiveDecoration,
              padding: const EdgeInsets.all(25.0),
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          _effectiveRadio,
                          const SizedBox(width: 15.0),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.type.name,
                                overflow: TextOverflow.fade,
                                style: const TextStyle(
                                  fontFamily: kFontFamily,
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                value.description,
                                overflow: TextOverflow.fade,
                                style: const TextStyle(
                                  fontFamily: kFontFamily,
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${value.price}р",
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontFamily: kFontFamily,
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (value.oldPrice != null)
                            Text(
                              "${value.oldPrice}р",
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontFamily: kFontFamily,
                                color: Colors.white.withOpacity(0.46),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.white.withOpacity(0.46),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: AnimatedCrossFade(
                      duration: _duration,
                      crossFadeState: _effectiveCrossFadeState,
                      firstChild: const SizedBox(width: double.infinity),
                      secondChild: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: value.features
                                .map(
                                  (feature) => Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 7,
                                          height: 7,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          feature,
                                          overflow: TextOverflow.fade,
                                          style: const TextStyle(
                                            fontFamily: kFontFamily,
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

enum SubscriptionType {
  month("1 меcяц"),
  halfYear("6 месяцев");

  const SubscriptionType(this.name);

  final String name;
}

class RadioCardInfo {
  const RadioCardInfo({
    required this.type,
    required this.description,
    required this.price,
    this.oldPrice,
    required this.features,
  });

  final SubscriptionType type;
  final String description;
  final int price;
  final int? oldPrice;
  final List<String> features;
}

class GradientTrimPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;

    final Paint paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.transparent,
          Color(0xFFFFFFFF),
        ],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(29)),
      paint,
    );
  }

  @override
  bool shouldRepaint(GradientTrimPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(GradientTrimPainter oldDelegate) => false;
}

class SaleWrapper extends StatelessWidget {
  const SaleWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          child,
          Positioned(
            right: -11,
            top: -15,
            child: UnconstrainedBox(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "выгодно",
                  style: TextStyle(
                    fontFamily: kFontFamily,
                    color: Color(0xFF6B66D8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}

class GestureRecognizerBuilder extends StatefulWidget {
  const GestureRecognizerBuilder({
    super.key,
    required this.onTap,
    required this.builder,
  });

  final VoidCallback onTap;
  final Widget Function(BuildContext, GestureRecognizer) builder;

  @override
  State<GestureRecognizerBuilder> createState() =>
      _GestureRecognizerBuilderState();
}

class _GestureRecognizerBuilderState extends State<GestureRecognizerBuilder> {
  late final GestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();

    _recognizer = TapGestureRecognizer()..onTap = widget.onTap;
  }

  @override
  void dispose() {
    _recognizer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _recognizer);
}
