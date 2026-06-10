class ApiConstant {
  static const String baseUrl = "https://grocery.newcinderella.online/public";
  // Auth
  static const String loginEndpoint = '/api/auth/login';
  static const String registerEndpoint = '/api/auth/register';
  static const String logoutEndpoint = '/api/auth/logout';
  static const String forgotPasswordEndpoint = '/api/auth/forgot-password';
  static const String verifyOtpEndpoint = '/api/auth/verify-otp';
  static const String resetPasswordEndpoint = '/api/auth/reset-password';
  static const String deleteAccountEndpoint = '/api/auth/delete-account';
  static const String changePasswordEndpoint = '/api/auth/change-password';
  static const String forgotPasswordEndPoint = '/api/auth/forgot-password';
  static const String verifyOtpEndPoint = '/api/auth/verify-otp';
  static const String resetPasswordEndPoint = '/api/auth/reset-password';

  // Home
  static const String categoriesEndpoint = '/api/categories';
  static const String subcategoriesEndpoint = '/api/subcategories';
  static const String todayMealsEndpoint = '/api/meals/today';
  static const String recommendationsEndpoint = '/api/meals/recommendations';
  static const String mealsEndpoint = '/api/meals';
  static const String hotMealsEndpoint = '/api/meals/hot';
  static const String newProductsEndpoint = '/api/new-products';
  static const String bestSellsEndpoint = '/api/best-sells';
  static const String slidersEndpoint = '/api/sliders';
  static const String brandsEndpoint = '/api/brands';
  static const String moreToExploreEndpoint = '/api/more-to-explore';
  static const String frequencyEndpoint = '/api/frequency';
  static const String cateEndpoint = '/api/categories';
  static String categoryDetailsEndpoint(int id) => '/api/categories/$id';

  // Cart
  static const String cartEndpoint = '/api/cart';
  static const String cartItemsEndpoint = '/api/cart/items';
  static const String clearCartEndpoint = '/api/cart/clear';

  // Favorite
  static const String favoritesEndpoint = '/api/favorites';

  // Profile
  static const String profileEndpoint = '/api/profile';
  static const String profileImageEndpoint = '/api/profile/image';
  static const String profileInfoEndpoint = '/api/profile/info';

  // Addresses
  static const String addressesEndpoint = '/api/addresses';

  // Smart Lists
  static const String smartListsEndpoint = '/api/smart-lists';

  // Notifications
  static const String notificationsEndpoint = '/api/notifications';
  static const String notificationSettingsEndpoint =
      '/api/notification-settings';

  // Chat Bot
  static const String chatbotEndpoint = '/api/chatbot';

  // Orders
  static const String ordersEndpoint = '/api/orders';
  static const String trackOrderEndpoint = '/api/orders/track';

  // Saved Cards
  static const String cardsEndpoint = '/api/cards';
  static const String setupIntentEndpoint = '/api/setup-intent';

  // Help & Support
  static const String faqsEndpoint = '/api/faqs';
  static const String contactEndpoint = '/api/contact';
  static const String settingsEndpoint = '/api/settings';
  static const String termsEndpoint = '/api/pages/slug/terms-and-conditions';
  static const String privacyPolicyEndpoint = '/api/pages/slug/privacy-policy';
  static const String aboutUsEndpoint = '/api/pages/slug/about-us';
  static const String returnPolicyEndpoint = '/api/pages/slug/return-policy';
  static const String cookiePolicyEndpoint = '/api/pages/slug/cookie-policy';

  // Special Notes
  static const String specialNotesEndpoint = '/api/special-notes';

  // Offers
  static const String offersEndpoint = '/api/offers';

  // Dashboard
  static const String dashboardEndpoint = '/api/dashboard';

  // Payment
  static const String paymentHistoryEndpoint = '/api/payments/history';
  static const String paymentReceiptEndpoint = '/api/payments/receipt';
  static const String paymentInvoiceEndpoint = '/api/payments/invoice';

  static const String mealDetailsEndpoint = "/api/meals/";
  static const String historyEndpoint = "/api/orders/";
  static const String toggleFavoriteEndpoint = "toggle";
  static const String getProfile = '/api/profile';
  static const String updateProfile = '/api/profile/info';
  static const String getAddresses = '/api/addresses';
  static const String storeAddress = '/api/addresses';
  static const String deleteAccount = '/api/auth/delete-account';
  static const String logout = '/api/auth/logout';
}