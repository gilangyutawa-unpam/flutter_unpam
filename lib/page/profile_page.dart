import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f0f0f),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER =================
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 220,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1501785888041-af3ef285b470',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // 🔥 overlay biar gelap elegan
                Container(height: 220, color: Colors.black.withOpacity(0.4)),

                Positioned(
                  bottom: -50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.amber, width: 3),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/fotprof.webp'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

            // ================= NAME =================
            const Text(
              "Ibnu Gilang Yutawa",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "NIM: 241011701355",
              style: TextStyle(color: Colors.white70),
            ),

            const Text(
              "Kelas: 04SIFE009",
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.location_on, size: 16, color: Colors.amber),
                Text(
                  " Tangerang, Indonesia",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ================= STATS =================
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem("248", "Posts"),
                _StatItem("12.5K", "Followers"),
                _StatItem("894", "Following"),
              ],
            ),

            const SizedBox(height: 20),

            // ================= ABOUT =================
            const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About Me",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Saya adalah mahasiswa aktif Universitas Pamulang jurusan Sistem Informasi. Saya adalah progammer begginer yang sedang belajar Mobile Programing.",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            // ================= INFO =================
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff1c1c1c),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Information",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    _infoItem(Icons.email, "gilangyutawa13@example.com"),
                    _infoItem(Icons.phone, "+62 81210602028"),
                    _infoItem(Icons.cake, "May 13, 2001"),
                  ],
                ),
              ),
            ),

            // ================= SKILLS =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 10,
                children: const [
                  _ChipItem("Flutter"),
                  _ChipItem("UI/UX"),
                  _ChipItem("Laravel"),
                  _ChipItem("Figma"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= BUTTON =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text("Edit Profile"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.amber),
                        foregroundColor: Colors.amber,
                      ),
                      onPressed: () {},
                      child: const Text("Share"),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.amber.withOpacity(0.2),
        child: Icon(icon, color: Colors.amber),
      ),
      title: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}

// ================= STAT =================
class _StatItem extends StatelessWidget {
  final String number;
  final String label;

  const _StatItem(this.number, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        const SizedBox(height: 5),
        const Text(" ", style: TextStyle(height: 0)),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}

// ================= CHIP =================
class _ChipItem extends StatelessWidget {
  final String text;

  const _ChipItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text, style: const TextStyle(color: Colors.black)),
      backgroundColor: Colors.amber,
    );
  }
}
