import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_shammak_ecommerce/helper/product_type.dart';
import 'package:flutter_shammak_ecommerce/localization/language_constrants.dart';
import 'package:flutter_shammak_ecommerce/provider/auth_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/banner_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/brand_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/cart_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/category_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/featured_deal_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/flash_deal_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/home_category_product_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/product_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/profile_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/splash_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/theme_provider.dart';
import 'package:flutter_shammak_ecommerce/provider/top_seller_provider.dart';
import 'package:flutter_shammak_ecommerce/utill/color_resources.dart';
import 'package:flutter_shammak_ecommerce/utill/custom_themes.dart';
import 'package:flutter_shammak_ecommerce/utill/dimensions.dart';
import 'package:flutter_shammak_ecommerce/utill/images.dart';
import 'package:flutter_shammak_ecommerce/view/basewidget/title_row.dart';
import 'package:flutter_shammak_ecommerce/view/screen/brand/all_brand_screen.dart';
import 'package:flutter_shammak_ecommerce/view/screen/cart/cart_screen.dart';
import 'package:flutter_shammak_ecommerce/view/screen/category/all_category_screen.dart';
import 'package:flutter_shammak_ecommerce/view/screen/featureddeal/featured_deal_screen.dart';
import 'package:flutter_shammak_ecommerce/view/screen/home/widget/announcement.dart';
import 'package:flutter_shammak_ecommerce/view/screen/home/widget/banners_view.dart';
import 'package:flutter_shammak_ecommerce/view/screen/home/widget/brand_view.dart';
import 'package:flutter_shammak_ecommerce/view/screen/home/widget/category_view.dart';
import 'package:flutter_shammak_ecommerce/view/screen/home/widget/featured_deal_view.dart';
import 'package:flutter_shammak_ecommerce/view/screen/home/widget/featured_product_view.dart';
import 'package:flutter_shammak_ecommerce/view/screen/home/widget/flash_deals_view.dart';
import 'package:flutter_shammak_ecommerce/view/screen/home/widget/footer_banner.dart';
import 'package:flutter_shammak_ecommerce/view/screen/home/widget/home_category_product_view.dart';
import 'package:flutter_shammak_ecommerce/view/screen/home/widget/latest_product_view.dart';
import 'package:flutter_shammak_ecommerce/view/screen/home/widget/main_section_banner.dart';
import 'package:flutter_shammak_ecommerce/view/screen/home/widget/products_view.dart';
import 'package:flutter_shammak_ecommerce/view/screen/flashdeal/flash_deal_screen.dart';
import 'package:flutter_shammak_ecommerce/view/screen/home/widget/recommended_product_view.dart';
import 'package:flutter_shammak_ecommerce/view/screen/home/widget/top_seller_view.dart';
import 'package:flutter_shammak_ecommerce/view/screen/product/view_all_product_screen.dart';
import 'package:flutter_shammak_ecommerce/view/screen/search/search_screen.dart';
import 'package:flutter_shammak_ecommerce/view/screen/topSeller/all_top_seller_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../provider/localization_provider.dart';
import '../../../provider/wishlist_provider.dart';
import '../../basewidget/animated_custom_dialog.dart';
import '../../basewidget/guest_dialog.dart';
import '../chat/inbox_screen.dart';
import '../more/web_view_screen.dart';
import '../more/widget/html_view_Screen.dart';
import '../more/widget/sign_out_confirmation_dialog.dart';
import '../notification/notification_screen.dart';
import '../profile/address_list_screen.dart';
import '../profile/profile_screen.dart';
import '../setting/settings_screen.dart';
import '../setting/widget/delete_account_dialog.dart';
import '../support/support_ticket_screen.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  Future<void> _loadData(BuildContext context, bool reload) async {
    await Provider.of<BannerProvider>(context, listen: false)
        .getBannerList(reload, context);
    Provider.of<BannerProvider>(context, listen: false)
        .getFooterBannerList(context);
    Provider.of<BannerProvider>(context, listen: false)
        .getMainSectionBanner(context);
    Provider.of<CategoryProvider>(context, listen: false)
        .getCategoryList(reload, context);
    Provider.of<HomeCategoryProductProvider>(context, listen: false)
        .getHomeCategoryProductList(reload, context);
    Provider.of<TopSellerProvider>(context, listen: false)
        .getTopSellerList(reload, context);
    Provider.of<BrandProvider>(context, listen: false)
        .getBrandList(reload, context);
    Provider.of<ProductProvider>(context, listen: false)
        .getLatestProductList(1, context, reload: reload);
    Provider.of<ProductProvider>(context, listen: false)
        .getFeaturedProductList('1', context, reload: reload);
    Provider.of<FeaturedDealProvider>(context, listen: false)
        .getFeaturedDealList(reload, context);
    Provider.of<ProductProvider>(context, listen: false)
        .getLProductList('1', context, reload: reload);
    Provider.of<ProductProvider>(context, listen: false)
        .getRecommendedProduct(context);
  }

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool isGuestMode;
  String version;
  bool singleVendor = false;
  @override
  void initState() {
    super.initState();
    {
      isGuestMode =
          !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
      if (!isGuestMode) {
        Provider.of<ProfileProvider>(context, listen: false)
            .getUserInfo(context);
        Provider.of<WishListProvider>(context, listen: false).initWishList(
          context,
          Provider.of<LocalizationProvider>(context, listen: false)
              .locale
              .countryCode,
        );
        version = Provider.of<SplashProvider>(context, listen: false)
                    .configModel
                    .version !=
                null
            ? Provider.of<SplashProvider>(context, listen: false)
                .configModel
                .version
            : 'version';
      }
      singleVendor = Provider.of<SplashProvider>(context, listen: false)
              .configModel
              .businessMode ==
          "single";

      super.initState();
    }
    singleVendor = Provider.of<SplashProvider>(context, listen: false)
            .configModel
            .businessMode ==
        "single";
    Provider.of<FlashDealProvider>(context, listen: false)
        .getMegaDealList(true, context, true);

    _loadData(context, false);

    if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      Provider.of<CartProvider>(context, listen: false).uploadToServer(context);
      Provider.of<CartProvider>(context, listen: false).getCartDataAPI(context);
    } else {
      Provider.of<CartProvider>(context, listen: false).getCartData();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> types = [
      getTranslated('new_arrival', context),
      getTranslated('top_product', context),
      getTranslated('best_selling', context),
      getTranslated('discounted_product', context)
    ];
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await _loadData(context, true);
            await Provider.of<FlashDealProvider>(context, listen: false)
                .getMegaDealList(true, context, false);

            return true;
          },
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // App Bar

                  SliverAppBar(
                    leading: IconButton(
                      icon: Icon(Icons.menu),
                      color: Colors.redAccent,
                      tooltip: 'Menu',
                      // onPressed: () {},
                      //  onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (_) => Drawer()))},
                      onPressed: () => _scaffoldKey.currentState.openDrawer(),
                    ),
                    pinned: true,
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    title: Image.asset(Images.logo_with_name_image, height: 35),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CartScreen()));
                          },
                          icon: Stack(clipBehavior: Clip.none, children: [
                            Image.asset(
                              Images.cart_arrow_down_image,
                              height: Dimensions.ICON_SIZE_DEFAULT,
                              width: Dimensions.ICON_SIZE_DEFAULT,
                              color: ColorResources.getPrimary(context),
                            ),
                            Positioned(
                              top: -4,
                              right: -4,
                              child: Consumer<CartProvider>(
                                  builder: (context, cart, child) {
                                return CircleAvatar(
                                  radius: 7,
                                  backgroundColor: ColorResources.RED,
                                  child: Text(cart.cartList.length.toString(),
                                      style: titilliumSemiBold.copyWith(
                                        color: ColorResources.WHITE,
                                        fontSize:
                                            Dimensions.FONT_SIZE_EXTRA_SMALL,
                                      )),
                                );
                              }),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),

                  // Search Button
                  SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverDelegate(
                          child: InkWell(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SearchScreen())),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.HOME_PAGE_PADDING,
                              vertical: Dimensions.PADDING_SIZE_SMALL),
                          color: ColorResources.getHomeBg(context),
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: Dimensions.HOME_PAGE_PADDING,
                              right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            ),
                            height: 60,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[
                                        Provider.of<ThemeProvider>(context)
                                                .darkTheme
                                            ? 900
                                            : 200],
                                    spreadRadius: 1,
                                    blurRadius: 1)
                              ],
                              borderRadius: BorderRadius.circular(
                                  Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(getTranslated('SEARCH_HINT', context),
                                      style: robotoRegular.copyWith(
                                          color: Theme.of(context).hintColor)),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL))),
                                    child: Icon(Icons.search,
                                        color: Theme.of(context).cardColor,
                                        size: Dimensions.ICON_SIZE_SMALL),
                                  ),
                                ]),
                          ),
                        ),
                      ))),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          Dimensions.HOME_PAGE_PADDING,
                          Dimensions.PADDING_SIZE_SMALL,
                          Dimensions.PADDING_SIZE_DEFAULT,
                          Dimensions.PADDING_SIZE_SMALL),
                      child: Column(
                        children: [
                          BannersView(),
                          SizedBox(height: Dimensions.HOME_PAGE_PADDING),

                          // Category
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal:
                                    Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL,
                                vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: TitleRow(
                                title: getTranslated('CATEGORY', context),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => AllCategoryScreen()))),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: Dimensions.HOME_PAGE_PADDING),
                            child: CategoryView(isHomePage: true),
                          ),

                          // Mega Deal
                          Consumer<FlashDealProvider>(
                            builder: (context, flashDeal, child) {
                              return (flashDeal.flashDeal != null &&
                                      flashDeal.flashDealList != null &&
                                      flashDeal.flashDealList.length > 0)
                                  ? TitleRow(
                                      title:
                                          getTranslated('flash_deal', context),
                                      eventDuration: flashDeal.flashDeal != null
                                          ? flashDeal.duration
                                          : null,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    FlashDealScreen()));
                                      },
                                      isFlash: true,
                                    )
                                  : SizedBox.shrink();
                            },
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          Consumer<FlashDealProvider>(
                            builder: (context, megaDeal, child) {
                              return (megaDeal.flashDeal != null &&
                                      megaDeal.flashDealList != null &&
                                      megaDeal.flashDealList.length > 0)
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              .77,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom:
                                                Dimensions.HOME_PAGE_PADDING),
                                        child: FlashDealsView(),
                                      ))
                                  : SizedBox.shrink();
                            },
                          ),

                          // Brand
                          Padding(
                            padding: const EdgeInsets.only(
                                left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: TitleRow(
                                title: getTranslated('brand', context),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => AllBrandScreen()));
                                }),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          BrandView(isHomePage: true),

                          //top seller
                          singleVendor
                              ? SizedBox()
                              : TitleRow(
                                  title: getTranslated('top_seller', context),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => AllTopSellerScreen(
                                                  topSeller: null,
                                                )));
                                  },
                                ),
                          singleVendor
                              ? SizedBox(height: 0)
                              : SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          singleVendor
                              ? SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: Dimensions.HOME_PAGE_PADDING),
                                  child: TopSellerView(isHomePage: true),
                                ),

                          //footer banner
                          Consumer<BannerProvider>(
                              builder: (context, footerBannerProvider, child) {
                            return footerBannerProvider.footerBannerList !=
                                        null &&
                                    footerBannerProvider
                                            .footerBannerList.length >
                                        0
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: Dimensions.HOME_PAGE_PADDING),
                                    child: FooterBannersView(
                                      index: 0,
                                    ),
                                  )
                                : SizedBox();
                          }),

                          // Featured Products
                          Consumer<ProductProvider>(
                              builder: (context, featured, _) {
                            return featured.featuredProductList != null &&
                                    featured.featuredProductList.length > 0
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                        vertical: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom:
                                              Dimensions.PADDING_SIZE_SMALL),
                                      child: TitleRow(
                                          title: getTranslated(
                                              'featured_products', context),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => AllProductScreen(
                                                        productType: ProductType
                                                            .FEATURED_PRODUCT)));
                                          }),
                                    ),
                                  )
                                : SizedBox();
                          }),

                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: Dimensions.HOME_PAGE_PADDING),
                            child: FeaturedProductView(
                              scrollController: _scrollController,
                              isHome: true,
                            ),
                          ),

                          // Featured Deal
                          Consumer<FeaturedDealProvider>(
                            builder: (context, featuredDealProvider, child) {
                              return featuredDealProvider.featuredDealList ==
                                      null
                                  ? TitleRow(
                                      title: getTranslated(
                                          'featured_deals', context),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    FeaturedDealScreen()));
                                      })
                                  : (featuredDealProvider.featuredDealList !=
                                              null &&
                                          featuredDealProvider
                                                  .featuredDealList.length >
                                              0)
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          child: TitleRow(
                                              title: getTranslated(
                                                  'featured_deals', context),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            FeaturedDealScreen()));
                                              }),
                                        )
                                      : SizedBox.shrink();
                            },
                          ),

                          Consumer<FeaturedDealProvider>(
                            builder: (context, featuredDeal, child) {
                              return featuredDeal.featuredDealList == null &&
                                      featuredDeal.featuredDealList.length > 0
                                  ? Container(
                                      height: 150, child: FeaturedDealsView())
                                  : (featuredDeal.featuredDealList != null &&
                                          featuredDeal.featuredDealList.length >
                                              0)
                                      ? Container(
                                          height: featuredDeal
                                                      .featuredDealList.length >
                                                  4
                                              ? 120 * 4.0
                                              : 120 *
                                                  (double.parse(featuredDeal
                                                      .featuredDealList.length
                                                      .toString())),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: Dimensions
                                                    .HOME_PAGE_PADDING),
                                            child: FeaturedDealsView(),
                                          ))
                                      : SizedBox.shrink();
                            },
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: Dimensions.HOME_PAGE_PADDING),
                            child: RecommendedProductView(),
                          ),

                          //footer banner
                          Consumer<BannerProvider>(
                              builder: (context, footerBannerProvider, child) {
                            return footerBannerProvider.mainSectionBannerList !=
                                        null &&
                                    footerBannerProvider
                                            .mainSectionBannerList.length >
                                        0
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: Dimensions.HOME_PAGE_PADDING),
                                    child: MainSectionBannersView(
                                      index: 0,
                                    ),
                                  )
                                : SizedBox();
                          }),

                          // Latest Products
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: TitleRow(
                                title:
                                    getTranslated('latest_products', context),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => AllProductScreen(
                                              productType:
                                                  ProductType.LATEST_PRODUCT)));
                                }),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          LatestProductView(
                              scrollController: _scrollController),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                          //Home category
                          HomeCategoryProductView(isHomePage: true),
                          SizedBox(height: Dimensions.HOME_PAGE_PADDING),

                          //footer banner
                          Consumer<BannerProvider>(
                              builder: (context, footerBannerProvider, child) {
                            return footerBannerProvider.footerBannerList !=
                                        null &&
                                    footerBannerProvider
                                            .footerBannerList.length >
                                        1
                                ? FooterBannersView(index: 1)
                                : SizedBox();
                          }),
                          SizedBox(height: Dimensions.HOME_PAGE_PADDING),

                          //Category filter
                          Consumer<ProductProvider>(
                              builder: (ctx, prodProvider, child) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal:
                                      Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                  vertical:
                                      Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Row(children: [
                                Expanded(
                                    child: Text(
                                        prodProvider.title == 'xyz'
                                            ? getTranslated(
                                                'new_arrival', context)
                                            : prodProvider.title,
                                        style: titleHeader)),
                                prodProvider.latestProductList != null
                                    ? PopupMenuButton(
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                                value: ProductType.NEW_ARRIVAL,
                                                child: Text(getTranslated(
                                                    'new_arrival', context)),
                                                textStyle:
                                                    robotoRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                )),
                                            PopupMenuItem(
                                                value: ProductType.TOP_PRODUCT,
                                                child: Text(getTranslated(
                                                    'top_product', context)),
                                                textStyle:
                                                    robotoRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                )),
                                            PopupMenuItem(
                                                value: ProductType.BEST_SELLING,
                                                child: Text(getTranslated(
                                                    'best_selling', context)),
                                                textStyle:
                                                    robotoRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                )),
                                            PopupMenuItem(
                                                value: ProductType
                                                    .DISCOUNTED_PRODUCT,
                                                child: Text(getTranslated(
                                                    'discounted_product',
                                                    context)),
                                                textStyle:
                                                    robotoRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                )),
                                          ];
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.PADDING_SIZE_SMALL)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.PADDING_SIZE_SMALL,
                                              vertical: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          child: Image.asset(
                                            Images.dropdown,
                                            scale: 3,
                                          ),
                                        ),
                                        onSelected: (value) {
                                          if (value ==
                                              ProductType.NEW_ARRIVAL) {
                                            Provider.of<ProductProvider>(
                                                    context,
                                                    listen: false)
                                                .changeTypeOfProduct(
                                                    value, types[0]);
                                          } else if (value ==
                                              ProductType.TOP_PRODUCT) {
                                            Provider.of<ProductProvider>(
                                                    context,
                                                    listen: false)
                                                .changeTypeOfProduct(
                                                    value, types[1]);
                                          } else if (value ==
                                              ProductType.BEST_SELLING) {
                                            Provider.of<ProductProvider>(
                                                    context,
                                                    listen: false)
                                                .changeTypeOfProduct(
                                                    value, types[2]);
                                          } else if (value ==
                                              ProductType.DISCOUNTED_PRODUCT) {
                                            Provider.of<ProductProvider>(
                                                    context,
                                                    listen: false)
                                                .changeTypeOfProduct(
                                                    value, types[3]);
                                          }

                                          ProductView(
                                              isHomePage: false,
                                              productType: value,
                                              scrollController:
                                                  _scrollController);
                                          Provider.of<ProductProvider>(context,
                                                  listen: false)
                                              .getLatestProductList(1, context,
                                                  reload: true);
                                        })
                                    : SizedBox(),
                              ]),
                            );
                          }),
                          ProductView(
                              isHomePage: false,
                              productType: ProductType.NEW_ARRIVAL,
                              scrollController: _scrollController),
                          SizedBox(height: Dimensions.HOME_PAGE_PADDING),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Provider.of<SplashProvider>(context, listen: false)
                          .configModel
                          .announcement
                          .status ==
                      '1'
                  ? Positioned(
                      top: MediaQuery.of(context).size.height - 128,
                      left: 0,
                      right: 0,
                      child: Consumer<SplashProvider>(
                        builder: (context, announcement, _) {
                          return announcement.onOff
                              ? AnnouncementScreen(
                                  announcement:
                                      announcement.configModel.announcement)
                              : SizedBox();
                        },
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            // const DrawerHeader(
            //
            //
            //   decoration: BoxDecoration(
            //
            //     color: Colors.red,
            //   ),
            //   // child: Text('مـتجـر شمــاخ الإلكتروني'),
            //
            // ),

            Container(
              width: 100,
              height: 200,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.black,
                  Colors.red[800],
                ],
              )),
              child: Consumer<ProfileProvider>(
                builder: (context, profile, child) {
                  return Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_LARGE,
                          ),
                          child: Image.asset(Images.logo_with_name_image,
                              height: 35, color: ColorResources.WHITE),
                        ),
                        Expanded(child: SizedBox.shrink()),
                        InkWell(
                          onTap: () {
                            if (isGuestMode) {
                              showAnimatedDialog(context, GuestDialog(),
                                  isFlip: true);
                            } else {
                              if (Provider.of<ProfileProvider>(context,
                                          listen: false)
                                      .userInfoModel !=
                                  null) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProfileScreen()));
                              }
                            }
                          },
                          child: Row(children: [
                            Align(alignment: Alignment.center),
                            Text(
                              !isGuestMode
                                  ? profile.userInfoModel != null
                                      ? '${profile.userInfoModel.fName} ${profile.userInfoModel.lName}'
                                      : 'Full Name'
                                  : 'Guest',
                              style: titilliumRegular.copyWith(
                                  color: ColorResources.WHITE),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                            isGuestMode
                                ? CircleAvatar(
                                    child: Icon(Icons.person, size: 35))
                                : profile.userInfoModel == null
                                    ? CircleAvatar(
                                        child: Icon(
                                        Icons.person,
                                        size: 15,
                                      ))
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(75),
                                        child: FadeInImage.assetNetwork(
                                          placeholder: Images.logo_image,
                                          width: 35,
                                          height: 35,
                                          fit: BoxFit.fill,
                                          image:
                                              '${Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl}/${profile.userInfoModel.image}',
                                          imageErrorBuilder: (c, o, s) =>
                                              CircleAvatar(
                                                  child: Icon(Icons.person,
                                                      size: 45)),
                                        ),
                                      ),
                          ]),
                        ),
                      ]);
                },
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 12),
              decoration: BoxDecoration(

                  // borderRadius: BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(90)),
                  ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Buttons
                      TitleButton(
                          image: Images.fast_delivery,
                          title: getTranslated('address', context),
                          navigateTo: AddressListScreen()),
                      TitleButton(
                          image: Images.more_filled_image,
                          title: getTranslated('all_category', context),
                          navigateTo: AllCategoryScreen()),
                      TitleButton(
                          image: Images.notification_filled,
                          title: getTranslated('notification', context),
                          navigateTo: NotificationScreen()),
                      //TODO: seller
                      TitleButton(
                          image: Images.settings,
                          title: getTranslated('settings', context),
                          navigateTo: SettingsScreen()),

                      //
                      // TitleButton(
                      //     image: Images.chats,
                      //     title: getTranslated('chats', context),
                      //     navigateTo: InboxScreen()),
                      TitleButton(
                          image: Images.preference,
                          title: getTranslated('support_ticket', context),
                          navigateTo: SupportTicketScreen()),

                      TitleButton(
                          image: Images.contact_us,
                          title: getTranslated('contact_us', context),
                          navigateTo: WebViewScreen(
                            title: getTranslated('contact_us', context),
                            url: Provider.of<SplashProvider>(context,
                                    listen: false)
                                .configModel
                                .staticUrls
                                .contactUs,
                          )),
                      // isGuestMode?SizedBox():
                      // GestureDetector(
                      //   onTap: ()=>
                      //     showAnimatedDialog(context, DeleteAccountDialog()),
                      //
                      //   child: TitleButton(image: Images.delete,
                      //     title: getTranslated('delete_account', context),
                      //     //   onTap: () => showAnimatedDialog(context, DeleteAccountDialog()),
                      //   ),
                      // ),
                      isGuestMode
                          ? SizedBox()
                          : ListTile(
                              leading: Icon(
                                Icons.exit_to_app,
                                size: 25,
                                color: Colors.redAccent,
                              ),
                              title: Text(getTranslated('sign_out', context),
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      fontWeight: FontWeight.bold)),
                              onTap: () => showAnimatedDialog(
                                  context, SignOutConfirmationDialog(),
                                  isFlip: true),
                            ),

                      // TextButton.icon(
                      //   style: flatButtonStyle,
                      //     onPressed: (){ print('Button Clicked.');
                      // }, label: Text(
                      //   getTranslated(
                      //     'app_info',
                      //     context,
                      //   ),style: TextStyle(
                      //   color: Colors.red,
                      //   fontFamily: "Ubuntu",
                      // ),),
                      //   icon: Image.asset(Images.awal_image,
                      //           width: 95, height: 55),
                      //       ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 8.0),
                          child: GestureDetector(
                            child: Image.asset(
                              'assets/images/Pngtree—blue.png',
                              // On click should redirect to an URL
                              // width: 180.0,
                              // height: 40.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // ),
                      // Center(
                      //   child: Padding(
                      //     padding: EdgeInsets.only(top: 45.0, bottom: 8.0),
                      //     child: GestureDetector(
                      //       child: Image.asset(
                      //         'assets/images/awalnet.png',
                      //         fit: BoxFit.fitHeight,
                      //         // On click should redirect to an URL
                      //         // width: 80.0,
                      //         // height: 40.0,
                      //         // fit: BoxFit.cover,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Positioned.fill(
                      //   child: Image(
                      //     image: AssetImage('assets/images/Pngtree—blue.png'),
                      //     // fit: BoxFit.fill,
                      //   ),
                      // ),
                      // Positioned.fill(
                      // RaisedButton.icon(
                      //   onPressed: () {
                      //     print('Button Clicked.');
                      //   },
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius:
                      //       BorderRadius.all(Radius.circular(2.0))),
                      //   label: Text(
                      //     getTranslated(
                      //       'app_info',
                      //       context,
                      //     ),
                      //     style: TextStyle(
                      //       color: Colors.red,
                      //       fontFamily: "Ubuntu",
                      //     ),
                      //
                      //   ),
                      //
                      //   // icon: Icon(Icons.android, color:Colors.white),
                      //   icon: Image.asset(Images.awal_image,
                      //       width: 95, height: 55),
                      //   textColor: Colors.white,
                      //   splashColor: Colors.red,
                      //   color: Colors.white70,
                      // ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 70 ||
        oldDelegate.minExtent != 70 ||
        child != oldDelegate.child;
  }
}

class SquareButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;
  final int count;
  final bool hasCount;

  SquareButton(
      {@required this.image,
      @required this.title,
      @required this.navigateTo,
      @required this.count,
      @required this.hasCount});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 100;
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => navigateTo)),
      child: Column(children: [
        Container(
          width: width / 4,
          height: width / 4,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorResources.getPrimary(context),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(image, color: Theme.of(context).highlightColor),
              hasCount
                  ? Positioned(
                      top: -4,
                      right: -4,
                      child: Consumer<CartProvider>(
                          builder: (context, cart, child) {
                        return CircleAvatar(
                          radius: 5,
                          backgroundColor: ColorResources.RED,
                          child: Text(count.toString(),
                              style: titilliumSemiBold.copyWith(
                                color: ColorResources.WHITE,
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              )),
                        );
                      }),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(title, style: titilliumRegular),
        ),
      ]),
    );
  }
}

class TitleButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;
  TitleButton(
      {@required this.image, @required this.title, @required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(image,
          width: 25,
          height: 25,
          fit: BoxFit.fill,
          color: ColorResources.getPrimary(context)),
      title: Text(title,
          style: titilliumRegular.copyWith(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.bold)),
      onTap: () => Navigator.push(
        context,

        /*PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryAnimation) => navigateTo,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(parent: animation, curve: Curves.bounceInOut);
              return ScaleTransition(scale: animation, child: child, alignment: Alignment.center);
            },
          ),*/

        MaterialPageRoute(builder: (_) => navigateTo),
      ),
      /*onTap: () => Navigator.push(context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => navigateTo,
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        transitionDuration: Duration(milliseconds: 500),
      )),*/
    );
  }
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);
