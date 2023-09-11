import 'package:domain_package/usecase_extension.dart';
import 'package:jokes_app/core/controllers/base_controller.dart';
// import 'package:domain_package/domain_export.dart';

class CommonAdapterActionController with UseCaseExtension {
  static const actionCallback = 'ACTION_CALLBACK';
  static const actionKey = 'ACTION_KEY';
  static const actionData = 'ACTION_DATA';

  void onAction({required Map<String, dynamic> data, Map<String, dynamic>? params, BaseController? controller}) => _onAction(data: data, controller: controller);

  void _onAction({required Map<String, dynamic> data, Map<String, dynamic>? params, BaseController? controller}) {
    final key = data[actionKey];
    switch(key) {
      // case FeedContentView.actionFeedItemClick:
      //   _navigateToFeedDetails(data, params, viewModel);
      //   break;

      default:
    }
  }

  // void _navigateToFeedDetails(Map<String, dynamic> data, Map<String, dynamic>? params, HealofyBaseViewModel? viewModel) async {
  //   BaseFeedObject feedObject = data[actionData];
  //
  //   MediaItem? updatedMediaItem = await deeplinkHelper.handleDeeplink(params: {
  //     ...params ?? {},
  //     dlKeyDeeplink: DeepLinkSegment.comment.name,
  //     kItem: feedObject.item
  //   });
  //   if (updatedMediaItem != null) {
  //     feedObject.item = updatedMediaItem;
  //     viewModel?.notifyListeners();
  //   }
  // }
}