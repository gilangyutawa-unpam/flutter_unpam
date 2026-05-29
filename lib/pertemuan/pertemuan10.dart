import 'package:flutter/material.dart';

class Pertemuan10 extends StatefulWidget {
  const Pertemuan10({super.key});

  @override
  State<Pertemuan10> createState() => _Pertemuan10State();
}

class _Pertemuan10State extends State<Pertemuan10> {
  final TextEditingController nama = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isLogin = true;
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Icon(
                    isLogin ? Icons.lock : Icons.person_add,

                    size: 80,
                    color: Colors.blue,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    isLogin ? "Welcome Back" : "Create Account",

                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  if (!isLogin)
                    Column(
                      children: [
                        TextField(
                          controller: nama,

                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),

                            hintText: "Full Name",

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),

                  TextField(
                    controller: email,

                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),

                      hintText: "Email",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: password,
                    obscureText: isHidden,

                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),

                      hintText: "Password",

                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isHidden = !isHidden;
                          });
                        },

                        icon: Icon(
                          isHidden ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  if (!isLogin)
                    Column(
                      children: [
                        TextField(
                          obscureText: isHidden,

                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),

                            hintText: "Confirm Password",

                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isHidden = !isHidden;
                                });
                              },

                              icon: Icon(
                                isHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),

                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (context) => SuccessPage(
                              isLogin: isLogin,

                              nama: nama.text.isEmpty ? "User" : nama.text,

                              email: email.text,
                            ),
                          ),
                        );
                      },

                      child: Text(
                        isLogin ? "Login" : "Register",

                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        isLogin
                            ? "Don't have an account? "
                            : "Already have an account? ",
                      ),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },

                        child: Text(
                          isLogin ? "Register" : "Login",

                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  final bool isLogin;
  final String nama;
  final String email;

  const SuccessPage({
    super.key,
    required this.isLogin,
    required this.nama,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(30),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.green,

                  child: Icon(Icons.check, color: Colors.white, size: 60),
                ),

                const SizedBox(height: 25),

                Text(
                  isLogin ? "Login Berhasil" : "Registrasi Berhasil",

                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  isLogin
                      ? "Selamat datang kembali,"
                      : "Akun berhasil dibuat untuk",

                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),

                const SizedBox(height: 10),

                Text(
                  nama,

                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Row(
                    children: [
                      const Icon(Icons.email, color: Colors.blue),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          email,

                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: Text(
                      isLogin ? "Kembali" : "Login Sekarang",

                      style: const TextStyle(fontSize: 18),
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
}
