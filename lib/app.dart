import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/pages/landing_page.dart';
import 'features/jobs/presentation/pages/jobs_page.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';

class EthicHireApp extends StatelessWidget {
  const EthicHireApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EthicHire',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/main': (context) => const MainShell(),
      },
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    JobsPage(),
    DashboardPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EthicHire - Recrutamento Ético e Inclusivo',
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.work_outline),
            selectedIcon: Icon(Icons.work),
            label: 'Vagas cegas',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Painel',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
