import 'package:amazon/features/admin/model/product.dart';
import 'package:amazon/features/admin/screens/add_a_product.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:amazon/features/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  AdminServices adminServices = AdminServices();
  List<Product>? listproducts;
  @override
  void initState() {
    fetchAllProducts();

    super.initState();
  }

  fetchAllProducts() async {
    listproducts = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        listproducts!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProduct.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: navigateToAddProduct,
          tooltip: "Add a product",
          child: const Icon(Icons.add),
        ),
        body: listproducts == null
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: listproducts!.length,
                  itemBuilder: (context, index) {
                    final produtData = listproducts![index];
                    return Column(
                      children: [
                        SizedBox(
                          height: 140,
                          child: SingleProduct(
                            image: produtData.images[0],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    produtData.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      deleteProduct(produtData, index);
                                    },
                                    icon: const Icon(
                                        Icons.delete_outline_outlined))
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ));
  }
}
