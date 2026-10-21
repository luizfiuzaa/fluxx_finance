import 'package:Fluxx/blocs/theme_cubit/theme_cubit.dart';
import 'package:Fluxx/data/db_factory/db_factory.dart';
import 'package:Fluxx/pages/bill_form_pageView/bill_form_page_view.dart';
import 'package:Fluxx/pages/invoice_bill_form_pageView/invoice_bill_form_page_view.dart';
import 'package:Fluxx/pages/invoice_payment_page.dart';
import 'package:Fluxx/pages/month_bills_page/detail_invoice_bill_page.dart';
import 'package:Fluxx/pages/month_bills_page/invoice_bills_page.dart';
import 'package:Fluxx/pages/month_bills_page/month_bills_page.dart';
import 'package:Fluxx/pages/category_form_pageView/category_form_page_view.dart';
import 'package:Fluxx/pages/category_list_page.dart';
import 'package:Fluxx/pages/credit_card_form_pageView/credit_card_form_page_view.dart';
import 'package:Fluxx/pages/credit_card_info/credit_card_stats_page.dart';
import 'package:Fluxx/pages/credit_card_list_page.dart';
import 'package:Fluxx/pages/credit_card_info/credit_card_info_page.dart';
import 'package:Fluxx/pages/credit_card_info/credit_card_detail_page.dart';
import 'package:Fluxx/pages/month_bills_page/detail_common_bill_page.dart';
import 'package:Fluxx/pages/intro_page.dart';
import 'package:Fluxx/pages/month_list_page.dart';
import 'package:Fluxx/pages/profile_page.dart';
import 'package:Fluxx/pages/qr_scan_page.dart';
import 'package:Fluxx/pages/resume_page.dart';
import 'package:Fluxx/pages/revenue_form_pageView/revenue_form_page_view.dart';
import 'package:Fluxx/pages/revenue_list_page.dart';
import 'package:Fluxx/pages/stats_page.dart';
import 'package:Fluxx/themes/app_theme.dart';
import 'package:Fluxx/utils/app_routes.dart';
import 'package:Fluxx/utils/setup_dependences.dart';
import 'package:flashy_flushbar/flashy_flushbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Antes de qualquer acesso ao banco.
  await initDatabaseFactory();
  await initializeDateFormatting('pt_BR', null);
  setupDependencies();
  // Antes do primeiro frame, senão o app pisca no tema errado.
  await GetIt.I<ThemeCubit>().load();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // O sistema trocou de claro para escuro (ou o contrário).
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    GetIt.I<ThemeCubit>().updatePlatformBrightness(
      WidgetsBinding.instance.platformDispatcher.platformBrightness,
    );
  }

  /// Marca toda a árvore como suja.
  ///
  /// As telas leem `AppTheme.colors` direto, um getter estático, então trocar a
  /// paleta não cria dependência nenhuma e nada reconstrói sozinho. Pior: as
  /// rotas já empilhadas vivem em OverlayEntries, que não reconstroem nem
  /// quando o MaterialApp reconstrói. Sem isto a troca de tema só aparece nas
  /// telas abertas depois dela.
  void _markTreeDirty(BuildContext context) {
    void markDirty(Element element) {
      element.markNeedsBuild();
      element.visitChildren(markDirty);
    }

    context.visitChildElements(markDirty);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThemeCubit, ThemeState>(
      bloc: GetIt.I(),
      listenWhen: (previous, current) =>
          previous.brightness != current.brightness,
      listener: (context, state) => _markTreeDirty(context),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        bloc: GetIt.I(),
        builder: (context, themeState) => MaterialApp(
          // debugShowCheckedModeBanner: false,
          title: 'Fluxx',
          theme: AppTheme.themeData,
          builder: FlashyFlushbarProvider.init(),
          initialRoute: AppRoutes.intro,
          routes: {
            AppRoutes.intro: (ctx) => const IntroPage(),
            AppRoutes.homePage: (ctx) => const ResumePage(),
            AppRoutes.monthListPage: (ctx) => const MonthListPage(),
            AppRoutes.creditCardListPage: (ctx) => const CreditCardListPage(),
            AppRoutes.categoryListPage: (ctx) => const CategoryListPage(),
            AppRoutes.revenueListPage: (ctx) => const RevenueListPage(),
            AppRoutes.monthBillsPage: (ctx) => const MonthBillsPage(),
            AppRoutes.invoiceBillsPage: (ctx) => const InvoiceBillsPage(),
            AppRoutes.invoicePaymentPage: (ctx) => const InvoicePaymentPage(),
            AppRoutes.billStatsPage: (ctx) => const StatsPage(),
            AppRoutes.creditCardStatsPage: (ctx) => const CreditCardStatsPage(),
            AppRoutes.creditCardInfoPage: (ctx) => const CreditCardInfoPage(),
            AppRoutes.billFormPage: (ctx) => const BillFormPageview(),
            AppRoutes.invoiceBillFormPage: (ctx) => const InvoiceBillFormPageview(),
            AppRoutes.creditCardFormPage: (ctx) => const CreditCardFormPageview(),
            AppRoutes.detailCommonBillPage: (ctx) => const DetailCommonBillPage(),
            AppRoutes.detailInvoiceBillPage: (ctx) => const DetailInvoiceBillPage(),
            AppRoutes.creditCardDetailPage: (ctx) => const CreditCardDetailPage(),
            AppRoutes.categoryFormPage: (ctx) => const CategoryFormPageview(),
            AppRoutes.revenueFormPage: (ctx) => const RevenueFormPageview(),
            AppRoutes.profilePage: (ctx) => const ProfilePage(),
            AppRoutes.qrScanPage: (ctx) => const QrScanPage(),
          },
        ),
      ),
    );
  }
}
