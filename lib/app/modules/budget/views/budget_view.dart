import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/budget_controller.dart';

import 'package:intl/intl.dart';

class BudgetView extends GetView<BudgetController> {
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
                      "Anggaran",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showTambahAnggaranDialog();
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
                        'Tambah Anggaran',
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
                  width: Get.width,
                  height: 230,
                  child: Padding(
                    padding: EdgeInsets.only(right: 0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          AllCategoryCard(), // Kategori "ALL" tanpa detail
                          SizedBox(width: 16),
                          BudgetCard(
                            title: 'MAKAN',
                            color: Colors.blue,
                            amount: 1000000,
                            totalAmount: 1500000,
                            tillDate: '31 Oct 2024',
                            isBudget: true,
                            isSelected: false,
                          ),
                          SizedBox(width: 16),
                          BudgetCard(
                            title: 'MINUM',
                            color: Colors.blue,
                            amount: 100000,
                            totalAmount: 1000000,
                            tillDate: '31 Oct 2024',
                            isBudget: true,
                            isSelected: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Semua Transaksi Anggaran",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _transactionCard(
                        shortCode: 'HEA',
                        description: 'berobat',
                        category: 'Healthcare',
                        account: 'Tabungan Healthcare',
                        date: '22 Oct 2024',
                        amount: 'Rp 2.500.000',
                        type: 'Ex',
                        color: Colors.blue,
                      ),
                      _transactionCard(
                        shortCode: 'TRA',
                        description: 'Tidak ada deskripsi',
                        category: 'Transportasi',
                        account: 'Tabungan transport',
                        date: '22 Oct 2024',
                        amount: 'Rp 150.000',
                        type: 'In',
                        color: Colors.blue,
                      ),
                      _transactionCard(
                        shortCode: 'TRA',
                        description: 'Tidak ada deskripsi',
                        category: 'Transportasi',
                        account: 'Tabungan transport',
                        date: '22 Oct 2024',
                        amount: 'Rp 150.000',
                        type: 'In',
                        color: Colors.blue,
                      ),
                      _transactionCard(
                        shortCode: 'TRA',
                        description: 'Tidak ada deskripsi',
                        category: 'Transportasi',
                        account: 'Tabungan transport',
                        date: '22 Oct 2024',
                        amount: 'Rp 150.000',
                        type: 'In',
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget khusus untuk kategori "ALL"
class AllCategoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              'ALL',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Semua',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// Widget untuk kategori lain seperti "MAKAN" dan "MINUM"
class BudgetCard extends StatelessWidget {
  final String title;
  final Color color;
  final double amount;
  final double totalAmount;
  final String tillDate;
  final bool isBudget;
  final bool isSelected;

  BudgetCard({
    required this.title,
    required this.color,
    required this.amount,
    required this.totalAmount,
    required this.tillDate,
    required this.isBudget,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (!isSelected)
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
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
                  ),
                ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Rp ${amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          Text(
            'Till: $tillDate',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 5),
          Text(
            isBudget ? 'On Budget' : 'Over Budget',
            style: TextStyle(
              fontSize: 12,
              color: isBudget ? Colors.green : Colors.red,
            ),
          ),
          SizedBox(height: 5),
          ProgressBar(
            currentAmount: amount,
            totalAmount: totalAmount,
          ),
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  final double currentAmount;
  final double totalAmount;

  ProgressBar({required this.currentAmount, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    double progress =
        totalAmount == 0 ? 0 : (currentAmount / totalAmount).clamp(0.0, 1.0);

    return Column(
      children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.shade300,
          color: Colors.blue,
        ),
        SizedBox(height: 5),
        Text(
          'Rp ${currentAmount.toStringAsFixed(0)} / Rp ${totalAmount.toStringAsFixed(0)}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

void showTambahAnggaranDialog() {
  final TextEditingController jumlahController = TextEditingController();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  DateTime selectedDate = DateTime.now();

  Get.dialog(
    AlertDialog(
      title: Text('Tambah Transaksi Baru'),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nama Anggaran',
                  ),
                ),

                SizedBox(height: 10),
                // Dropdown untuk Kategori
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Kategori'),
                  value: 'Makan', // Default value
                  items: ['Makan', 'Kesehatan', 'Transportasi']
                      .map((String kategori) {
                    return DropdownMenuItem<String>(
                      value: kategori,
                      child: Text(kategori),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 10),
                // Input jumlah
                TextField(
                  controller: jumlahController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Jumlah'),
                ),
                SizedBox(height: 10),
                // Tanggal Transaksi
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          'Tanggal Jatuh Tempo: ${formatter.format(selectedDate)}'),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null && pickedDate != selectedDate) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
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

Widget _transactionCard({
  required String shortCode,
  required String description,
  required String category,
  required String account,
  required String date,
  required String amount,
  required String type,
  required Color color,
}) {
  return Card(
    elevation: 4,
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Leading section with circle avatar
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius:
                  BorderRadius.circular(8), // Buat sudutnya sedikit melengkung
            ),
            child: Center(
              child: Text(
                shortCode,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 16),
          // Main content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '$category • $account',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          // Button to delete the transaction
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol ditekan
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Warna latar belakang biru
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Sudut melengkung
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10), // Padding tombol
              ),
              child: const Text(
                'Hapus',
                style: TextStyle(
                  color: Colors.white, // Warna teks putih
                  fontSize: 12, // Ukuran teks
                  fontWeight: FontWeight.bold, // Teks tebal
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
