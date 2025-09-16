import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_supabase_google_auth/api/auth/provider.dart';
import 'package:flutter_supabase_google_auth/custom_app_page.dart';
import 'package:flutter_supabase_google_auth/model/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  Widget _contactCard(IconData icon, String title, String subtitle) {
    String url = subtitle;

    if (title.toLowerCase() == 'email') {
      url = 'mailto:$subtitle';
    } else if (title.toLowerCase() == 'phone') {
      final phoneNumber = subtitle.replaceAll(RegExp(r'\D'), '');
      final message = Uri.encodeComponent(
        "Merhaba, Uygulamanızdaki bağlantıdan size ulaşıyorum. Nasılsınız?",
      );
      url = 'https://wa.me/$phoneNumber?text=$message';
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue, size: 28),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: () async {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            );
          } else {
            debugPrint('Could not launch $url');
          }
        },
      ),
    );
  }

  Widget _buildDefaultProfilePage(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white70),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white70),
        ),
      ),
      home: CustomScaffoldPage(
        appBar: AppBar(
          title: const Text('My Profile'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.login),
              onPressed: () =>
                  ref.read(authProvider.notifier).signInWithGoogle(),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, size: 80, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                "Anıl Aydın",
                style: Theme.of(
                  context,
                ).textTheme.displayMedium!.copyWith(color: Colors.white),
              ),

              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Contact Me",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium!.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              _contactCard(Icons.email, "Email", "anilaydin288@gmail.com"),
              _contactCard(Icons.phone, "Phone", "+90 505 802 81 93"),
              _contactCard(
                Icons.link,
                "LinkedIn",
                "https://www.linkedin.com/in/anil-aydin-7bb91b21a/",
              ),
              _contactCard(
                Icons.code,
                "GitHub",
                "https://www.github.com/anilaydinaa",
              ),

              const SizedBox(height: 24),
              Text(
                "Frontend Skills",
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 12),
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    label: Text("Flutter"),
                    backgroundColor: Colors.blueAccent,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text("Dart"),
                    backgroundColor: Colors.blueAccent,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text("Riverpod"),
                    backgroundColor: Colors.orange,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text("BLoC"),
                    backgroundColor: Colors.orange,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text("Provider"),
                    backgroundColor: Colors.orange,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text("React"),
                    backgroundColor: Colors.green,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              Text(
                "Backend Skills",
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 12),
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    label: Text("C#"),
                    backgroundColor: Colors.purple,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text("ASP.NET Core"),
                    backgroundColor: Colors.purple,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text("GraphQL"),
                    backgroundColor: Colors.deepPurple,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text("REST API"),
                    backgroundColor: Colors.deepPurple,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text("PostgreSQL"),
                    backgroundColor: Colors.teal,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text("MSSQL"),
                    backgroundColor: Colors.teal,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              Text(
                "General & Tools",
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 12),
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    label: Text("Git"),
                    backgroundColor: Colors.brown,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text("GitHub"),
                    backgroundColor: Colors.brown,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text("CI/CD"),
                    backgroundColor: Colors.brown,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text("Firebase Services"),
                    backgroundColor: Colors.yellow,
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  Chip(
                    label: Text("RevenueCat"),
                    backgroundColor: Colors.red,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text("Easy Localization"),
                    backgroundColor: Colors.cyan,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthenticatedProfilePage(
    BuildContext context,
    WidgetRef ref,
    UserModel user,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white70),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white70),
        ),
      ),
      home: CustomScaffoldPage(
        appBar: AppBar(
          title: const Text('My Profile'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => ref.read(authProvider.notifier).signOut(),
            ),
          ],
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: user.photoUrl != null
                      ? NetworkImage(user.photoUrl!)
                      : null,
                  child: user.photoUrl == null
                      ? const Icon(Icons.person, size: 80, color: Colors.white)
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  user.displayName ?? "Misafir Kullanıcı",
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge!.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    if (user != null) {
      return _buildAuthenticatedProfilePage(context, ref, user);
    } else {
      return _buildDefaultProfilePage(context, ref);
    }
  }
}
