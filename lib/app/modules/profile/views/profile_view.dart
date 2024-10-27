import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/logo/logo.png'),
          onPressed: () {
            // Get.offNamed(Routes.BOTTOMNAVIGATION);
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: StadiumBorder(),
            ),
            child: Text(
              "Keluar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Akun",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showAkunBaruDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.blue, // Warna latar belakang biru
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Sudut melengkung
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10), // Padding tombol
                      ),
                      child: const Text(
                        'Tambah Akun',
                        style: TextStyle(
                          color: Colors.white, // Warna teks putih
                          fontSize: 12, // Ukuran teks
                          fontWeight: FontWeight.bold, // Teks tebal
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  height: 130, // Tinggi container agar semua konten muat
                  child: ListView.builder(
                    scrollDirection:
                        Axis.horizontal, // Scroll secara horizontal
                    itemCount: 5, // Jumlah item (sesuaikan dengan kebutuhan)
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 10), // Jarak antar item
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 100, // Lebar item
                                  height: 80, // Tinggi item
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: index == 0
                                        ? Colors.green
                                        : Colors.blue, // Warna item
                                    borderRadius: BorderRadius.circular(
                                        10), // Sudut melengkung
                                  ),
                                  child: Text(
                                    index == 0 ? "All" : "Bank", // Contoh teks
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: index !=
                                          0 // X button hanya tampil jika bukan "All"
                                      ? Container(
                                          width: 16,
                                          height: 16,
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const SizedBox(), // Kosong untuk item "All"
                                ),
                              ],
                            ),
                            const SizedBox(
                                height: 5), // Jarak antara item dan teks label
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.center, // Rata kiri
                              children: [
                                Text(
                                  index == 0
                                      ? "Semua"
                                      : "Tabungan Makan", // Contoh label
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  index == 0
                                      ? ""
                                      : "Rp. 2.000.000", // Teks di bawah "Tabungan Makan"
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Semua Transaksi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    TransactionCard(
                      title: 'Healthcare',
                      subtitle: 'Tabungan Healthcare',
                      date: '2024-10-22',
                      amount: '- Rp 2.500.000',
                      note: 'berobat',
                      amountColor: Colors.red,
                    ),
                    SizedBox(height: 8),
                    TransactionCard(
                      title: 'Transportasi',
                      subtitle: 'Tabungan transport',
                      date: '2024-10-22',
                      amount: '+ Rp 150.000',
                      note: '',
                      amountColor: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showAkunBaruDialog() {
  final TextEditingController jumlahController = TextEditingController();
  Get.dialog(
    AlertDialog(
      title: Text('Tambah Akun Baru'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Nama Akun',
            ),
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Tipe Akun'),
            value: 'Kas', // Default value
            items: ['Kas', 'Bank', 'Kartu Kredit', 'E-Wallet']
                .map((String kategori) {
              return DropdownMenuItem<String>(
                value: kategori,
                child: Text(kategori),
              );
            }).toList(),
            onChanged: (value) {},
          ),
          SizedBox(height: 10),
          TextField(
            controller: jumlahController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Jumlah'),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(
                255, 119, 122, 124), // Warna latar belakang biru
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Sudut melengkung
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 10), // Padding tombol
          ),
          child: const Text(
            'Batal',
            style: TextStyle(
              color: Colors.white, // Warna teks putih
              fontSize: 12, // Ukuran teks
              fontWeight: FontWeight.bold, // Teks tebal
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            //aksi
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Warna latar belakang biru
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Sudut melengkung
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 10), // Padding tombol
          ),
          child: const Text(
            'Simpan',
            style: TextStyle(
              color: Colors.white, // Warna teks putih
              fontSize: 12, // Ukuran teks
              fontWeight: FontWeight.bold, // Teks tebal
            ),
          ),
        ),
      ],
    ),
  );
}

class TransactionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String amount;
  final String note;
  final Color amountColor;

  TransactionCard({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    required this.note,
    required this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 16,
                    color: amountColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  note,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
