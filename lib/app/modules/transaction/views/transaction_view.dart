import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:ynab/app/Bloc/Auth/auth_bloc.dart';
import 'package:ynab/app/model/addtransactionmodel.dart';
import 'package:ynab/app/model/authmodel.dart';
import 'package:ynab/app/routes/app_pages.dart';
import '../controllers/transaction_controller.dart';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionView extends GetView<TransactionController> {
  TransactionView({super.key});

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final TransactionController controller = Get.find<TransactionController>();

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
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthInitial) {
                Get.offAllNamed(Routes.SIGNIN);
              }
              if (state is AuthFailed) {
                showSnackbar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is AuthSuccess) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogout(state.user));
                  },
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
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            List<Category> categories = state.user.user.categories;
            List<Account> accounts = state.user.user.accounts;
            List<Transaction> transactions = accounts.expand((account) {
              return account
                  .transactions; // Combine transactions from each account
            }).toList();

            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserInfo(state.user.user.name),
                      SizedBox(height: 16),
                      _buildCategoryHeader(
                          controller, categories, context, state.user),
                      _buildCategoryList(controller, categories),
                      _buildTransactionHeader(controller, context, state.user),
                      _buildTransactionList(
                          controller, transactions, categories, accounts),
                    ],
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildUserInfo(String name) {
    return Container(
      width: double.infinity,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.green,
      ),
      child: Text(
        name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(TransactionController controller,
      List<Category> categories, BuildContext context, AuthModel user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Kategori",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: () {
            showTambahKategoriDialog(context, user);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
          child: const Text(
            'Tambah Kategori',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryList(
      TransactionController controller, List<Category> categories) {
    return Container(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              controller.setCurrentIdCategory(categories[index].id);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: controller.currentIdCategory.value ==
                                  categories[index].id
                              ? Colors.green
                              : Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: FittedBox(
                          child: Text(
                            categories[index].name!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: index != 0
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
                            : const SizedBox(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    categories[index].name!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTransactionHeader(
      TransactionController controller, BuildContext context, AuthModel user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Semua Transaksi",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: () {
            showTambahTransaksiDialog(
                context, user); // Function to show transaction addition dialog
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
          child: const Text(
            'Tambah Transaksi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionList(
      TransactionController controller,
      List<Transaction> transactions,
      List<Category> categories,
      List<Account> accounts) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Obx(() {
            // Determine the transactions to display based on the selected category
            List<Transaction> filteredTransactions =
                controller.currentIdCategory.value == null
                    ? transactions
                    : transactions
                        .where((e) =>
                            e.categoryId == controller.currentIdCategory.value)
                        .toList();

            // Map the filtered transactions to a list of Widgets
            return Column(
              children: filteredTransactions.map((e) {
                String shortcode = categories
                    .firstWhere((element) => element.id == e.categoryId)
                    .name!;
                return _transactionCard(
                  shortCode: shortcode.substring(0, 3),
                  description: e.description,
                  category: shortcode,
                  account: accounts
                      .firstWhere((element) => element.id == e.accountId)
                      .accountName,
                  date: e.transactionDate,
                  amount: NumberFormat.currency(
                          locale: 'id', symbol: '', decimalDigits: 0)
                      .format(e.amount),
                  type: 'Ex',
                  color: Colors.blue,
                );
              }).toList(), // Ensure that this is a List<Widget>
            );
          }),
        ],
      ),
    );
  }

  Function(Transaction) _buildTransactionCard(
      List<Category> categories, List<Account> accounts) {
    return (Transaction e) {
      String shortcode =
          categories.firstWhere((element) => element.id == e.categoryId).name!;
      return _transactionCard(
        shortCode: shortcode.substring(0, 3),
        description: e.description,
        category: shortcode,
        account: accounts
            .firstWhere((element) => element.id == e.accountId)
            .accountName,
        date: e.transactionDate,
        amount:
            NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0)
                .format(e.amount),
        type: 'Ex',
        color: Colors.blue,
      );
    };
  }
}

void showTambahKategoriDialog(BuildContext context, AuthModel user) {
  Get.dialog(
    AlertDialog(
      title: Text('Tambah Kategori Baru'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Nama Kategori',
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: 'Deskripsi',
            ),
            maxLines: 3,
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: 'URL Gambar Kategori',
              hintText: 'https://example.com/image.jpg',
            ),
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

void showTambahTransaksiDialog(BuildContext context, AuthModel user) {
  List<String> accountname = user.user.accounts.map(
    (element) {
      return element.accountName;
    },
  ).toList();
  List<String> categoriesname = user.user.categories.map(
    (e) {
      return e.name!;
    },
  ).toList();
  String dropdownaccountname = accountname.first;
  String dropdowncategoriesname = categoriesname.first;
  String type = 'income';
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  DateTime selectedDate = DateTime.now();

  Get.dialog(
    BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAddTransactionSuccess) {
          Get.dialog(
            AlertDialog(
              title: const Text('Berhasil'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Get.back(); // Menutup dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 119, 122, 124), // Warna latar belakang abu-abu
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Sudut melengkung
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10), // Padding tombol
                  ),
                  child: const Text(
                    'Tutup',
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
        if (state is AuthAddTransactionFailed) {
          Get.dialog(
            AlertDialog(
              title: const Text('Gagal'),
              content: Text(state.message),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Get.back(); // Menutup dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 119, 122, 124), // Warna latar belakang abu-abu
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Sudut melengkung
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10), // Padding tombol
                  ),
                  child: const Text(
                    'Tutup',
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
      },
      child: AlertDialog(
        title: Text('Tambah Transaksi Baru'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dropdown untuk Akun
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Akun'),
                    value: dropdownaccountname,
                    items: accountname.map((String akun) {
                      return DropdownMenuItem<String>(
                        value: akun,
                        child: Text(akun),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdownaccountname = value!;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  // Dropdown untuk Kategori
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Kategori'),
                    value: dropdowncategoriesname, // Default value
                    items: categoriesname.map((String kategori) {
                      return DropdownMenuItem<String>(
                        value: kategori,
                        child: Text(kategori),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdowncategoriesname = value!;
                      });
                    },
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
                            'Tanggal Transaksi: ${formatter.format(selectedDate)}'),
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
                          if (pickedDate != null &&
                              pickedDate != selectedDate) {
                            setState(() {
                              selectedDate = pickedDate;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Dropdown untuk Tipe Transaksi
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Tipe Transaksi'),
                    value: 'Pemasukan', // Default value
                    items: ['Pemasukan', 'Pengeluaran'].map((String tipe) {
                      return DropdownMenuItem<String>(
                        value: tipe,
                        child: Text(tipe),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        if (value == 'Pemasukan') {
                          type = 'income';
                        }
                        if (value == 'Pengeluaran') {
                          type = 'expense';
                        }
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  // Input deskripsi
                  TextField(
                    controller: deskripsiController,
                    decoration: InputDecoration(
                      labelText: 'Deskripsi',
                    ),
                    maxLines: 3,
                  ),
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
              Account selectedAccount = user.user.accounts.firstWhere(
                (element) {
                  return element.accountName == dropdownaccountname;
                },
              );
              Category selectedcategories = user.user.categories.firstWhere(
                (element) {
                  return element.name == dropdowncategoriesname;
                },
              );
              if (int.parse(jumlahController.text) <= selectedAccount.balance) {
                context.read<AuthBloc>().add(AuthAddTransaction(
                    user,
                    AddTransactionModel(
                        accountid: selectedAccount.id,
                        amount: int.parse(jumlahController.text),
                        categoryid: selectedcategories.id,
                        date: DateFormat('yyyy-MM-dd').format(selectedDate),
                        description: deskripsiController.text,
                        onbudget: true,
                        type: type)));
              } else {
                Get.dialog(
                  AlertDialog(
                    title: const Text('Saldo Tidak Cukup'),
                    content: const Text(
                        'Saldo akun Anda tidak mencukupi untuk melakukan transaksi ini.'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back(); // Menutup dialog
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 119, 122,
                              124), // Warna latar belakang abu-abu
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // Sudut melengkung
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10), // Padding tombol
                        ),
                        child: const Text(
                          'Tutup',
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
                Text(
                  type == 'Ex' ? 'Ex $amount' : 'In $amount',
                  style: TextStyle(
                    color: type == 'Ex' ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
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
