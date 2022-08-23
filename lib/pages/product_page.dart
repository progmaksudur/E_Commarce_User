

import 'package:e_commerce_user/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../provider/product_provider.dart';
import '../utility/widgets/app_slider.dart';
import '../utility/widgets/main_drawer.dart';
import '../utility/widgets/product_iteam.dart';
import '../utility/widgets/show_loading.dart';


class ProductPage extends StatefulWidget {
  static const routeName = "product-page";
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductProvider productProvider;
  late CartProvider cartProvider;
  int _chipValue = 0;
  @override
  void didChangeDependencies() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    productProvider.getAllProducts();
    productProvider.getAllFeatureProducts();
    cartProvider.getAllCartItems();

    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          "Product",
        ),

        elevation: 0,
        actions: [
          InkWell(
            onTap: ()=> Navigator.pushNamed(context, CartPage.routeName),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.shopping_cart,
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    alignment: Alignment.center,
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                        color: Color(0xffff704d), shape: BoxShape.circle),
                    child: Consumer<CartProvider>(
                        builder: (context, provider, child) => FittedBox(
                            child: Text(provider.totalItemsInCart.toString()))),
                  ),
                )
              ],
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: ImageIcon(AssetImage("assets/images/filter.png"))),
        ],
      ),

      drawer: MainDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: ((BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[


            SliverAppBar(
              expandedHeight: 165,
              flexibleSpace: FlexibleSpaceBar(
                background: AppSlider(),
                collapseMode: CollapseMode.parallax,
              ),
              leading: Container(),
              floating: true,
              elevation: 0,
              backgroundColor: Colors.white.withOpacity(0),

            ),
          ];
        }),
        body: Consumer<ProductProvider>(
          builder: (context, provider, child) => Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.categoryNameList.length,
                    itemBuilder: (context, index) {
                      final category = provider.categoryNameList[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ChoiceChip(
                          elevation: 5,
                          backgroundColor: Color(0xffEFEFEF),
                          selectedShadowColor: Color(0xffff8566),
                          selectedColor: Theme.of(context).primaryColor,
                          label: Text(category),
                          selected: _chipValue == index,
                          onSelected: (value) {
                            setState(() {
                              _chipValue = value ? index : 0;
                            });
                            if (_chipValue == 0) {
                              provider.getAllProducts();
                            } else {
                              provider.getAllProductsByCategory(
                                  provider.categoryNameList[_chipValue]);
                            }
                          },
                          labelStyle: _chipValue == index
                              ? TextStyle(color: Colors.white)
                              : TextStyle(color: Color(0xff666666)),
                        ),
                      );
                    }),
              ),
              provider.productList.isEmpty
                  ? const Center(
                child: ShowLoading(),
              )
                  : Expanded(
                child: GridView.builder(
                    padding:
                    const EdgeInsets.only(left: 5, right: 5, top: 5),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 4 / 5,
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 5),
                    itemCount: provider.productList.length,
                    itemBuilder: (context, index) => ProductItem(
                        product: provider.productList[index])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
