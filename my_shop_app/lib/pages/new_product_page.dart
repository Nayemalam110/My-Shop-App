import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/product.dart';
import 'package:my_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class NewProductPage extends StatefulWidget {
  static const routeName = '/new-page-product';

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final _priceFoucsNode = FocusNode();
  final _imgUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  var _editProduct = Product(
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  var isInts = true;
  var _intiValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void didChangeDependencies() {
    if (isInts) {
      var productId = ModalRoute.of(context)?.settings.arguments as String?;

      if (productId != null) {
        _editProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);
        _intiValues = {
          'title': _editProduct.title,
          'description': _editProduct.description,
          'price': _editProduct.price.toString(),
          'imageUrl': '',
        };
        _imgUrlController.text = _editProduct.imageUrl;
      }
    }
    isInts = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imgUrlController.dispose();
    _priceFoucsNode.dispose();
    super.dispose();
  }

  void _saveFrom() {
    print(_editProduct.title);

    final isVaild = _form.currentState!.validate();
    if (!isVaild) {
      return;
    }

    _form.currentState!.save();
    if (_editProduct.id == '') {
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_editProduct);
    }
    Provider.of<ProductsProvider>(context, listen: false)
        .updateProduct(_editProduct.id, _editProduct);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                    initialValue: _intiValues['title'].toString(),
                    decoration: const InputDecoration(labelText: 'Title'),
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_priceFoucsNode),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a title';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _editProduct = Product(
                        id: _editProduct.id,
                        title: newValue!,
                        description: _editProduct.description,
                        price: _editProduct.price,
                        imageUrl: _editProduct.imageUrl,
                      );
                    }),
                TextFormField(
                  initialValue: _intiValues['price'].toString(),
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  focusNode: _priceFoucsNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a Price';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _editProduct = Product(
                      id: _editProduct.id,
                      title: _editProduct.title,
                      description: _editProduct.description,
                      price: double.parse(newValue!),
                      imageUrl: _editProduct.imageUrl,
                    );
                  },

                  // onFieldSubmitted: (_) =>
                  //      FocusScope.of(context).requestFocus(_priceFoucsNode),
                ),
                TextFormField(
                  initialValue: _intiValues['description'].toString(),
                  decoration: const InputDecoration(labelText: 'Description'),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a Description';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _editProduct = Product(
                      id: _editProduct.id,
                      title: _editProduct.title,
                      description: newValue!,
                      price: _editProduct.price,
                      imageUrl: _editProduct.imageUrl,
                    );
                  },

                  // focusNode: _priceFoucsNode,
                  // onFieldSubmitted: (_) =>
                  //     FocusScope.of(context).requestFocus(_priceFoucsNode),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: FittedBox(
                        child: _imgUrlController.text.isEmpty
                            ? Text('Enter A url')
                            : Image.network(
                                _imgUrlController.text,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'imgUrl'),
                        keyboardType: TextInputType.url,
                        controller: _imgUrlController,
                        textInputAction: TextInputAction.done,
                        onSaved: (newValue) {
                          _editProduct = Product(
                            id: _editProduct.id,
                            title: _editProduct.title,
                            description: _editProduct.description,
                            price: _editProduct.price,
                            imageUrl: newValue!,
                          );
                        },
                        onFieldSubmitted: (_) => _saveFrom(),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
