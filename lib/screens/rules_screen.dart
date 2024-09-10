import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFE5DA),
      appBar: AppBar(
        title: Text(
          'Règles du jeu',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF8F7A66),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Comment jouer au 2048 :',
                style: GoogleFonts.poppins(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF8F7A66),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Liste à puces
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.brightness_1,
                          size: 8, color: Color(0xFF8F7A66)),
                      title: Text(
                        'Effectuez un swipe vers la direction souhaitée pour déplacer les tuiles.',
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          color: const Color(0xFF8F7A66),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.brightness_1,
                          size: 8, color: Color(0xFF8F7A66)),
                      title: Text(
                        'Lorsque deux tuiles avec le même nombre se touchent, elles fusionnent en une seule.',
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          color: const Color(0xFF8F7A66),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.brightness_1,
                          size: 8, color: Color(0xFF8F7A66)),
                      title: Text(
                        'Le but est d\'atteindre la tuile 2048.',
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          color: const Color(0xFF8F7A66),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.brightness_1,
                          size: 8, color: Color(0xFF8F7A66)),
                      title: Text(
                        'Le jeu se termine lorsque vous ne pouvez plus faire de mouvements ou lorsque vous atteignez la tuile 2048.',
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          color: const Color(0xFF8F7A66),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Text(
                'Bonne chance !',
                style: GoogleFonts.poppins(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF8F7A66),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
