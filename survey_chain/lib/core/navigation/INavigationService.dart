abstract class INavigationService {
  void navigateToPop();
  Future<void> navigateToPage({String? path, Object? data});
  Future<void> navigateToPageClear({String? path, Object? data});
}
