import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fic23pos_flutter/data/models/response/product_response_model.dart';
import 'package:fic23pos_flutter/presentation/home/bloc/product/product_bloc.dart';

class ProductFormDialog extends StatefulWidget {
  final Product? product;

  const ProductFormDialog({Key? key, this.product}) : super(key: key);

  @override
  State<ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<ProductFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _stockController;
  late TextEditingController _categoryIdController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _priceController = TextEditingController(text: widget.product?.price?.toString() ?? '');
    _descriptionController = TextEditingController(text: widget.product?.description ?? '');
    _stockController = TextEditingController(text: widget.product?.stock?.toString() ?? '');
    _categoryIdController = TextEditingController(text: widget.product?.categoryId?.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _stockController.dispose();
    _categoryIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product == null ? 'Tambah Produk' : 'Edit Produk'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Nama wajib diisi' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Harga wajib diisi' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                maxLines: 3,
              ),
              TextFormField(
                controller: _stockController,
                decoration: const InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Stok wajib diisi' : null,
              ),
              TextFormField(
                controller: _categoryIdController,
                decoration: const InputDecoration(labelText: 'ID Kategori'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'ID Kategori wajib diisi' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final product = Product(
                id: widget.product?.id,
                name: _nameController.text,
                price: double.tryParse(_priceController.text.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0,
                description: _descriptionController.text,
                stock: int.tryParse(_stockController.text) ?? 0,
                categoryId: int.tryParse(_categoryIdController.text) ?? 0,
              );

              if (widget.product == null) {
                context.read<ProductBloc>().add(ProductEvent.addProduct(product));
              } else {
                context.read<ProductBloc>().add(ProductEvent.updateProduct(product));
              }

              Navigator.pop(context);
            }
          },
          child: Text(widget.product == null ? 'Simpan' : 'Update'),
        ),
        if (widget.product != null)
          TextButton(
            onPressed: () {
              context.read<ProductBloc>().add(ProductEvent.deleteProduct(widget.product!.id!));
              Navigator.pop(context);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
      ],
    );
  }
}
