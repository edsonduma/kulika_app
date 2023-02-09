import 'package:kulika/presenters/base_presenter.dart';
import 'package:kulika/contracts/base_views.dart';

abstract class View extends BaseView {
  showError(var msg);
  showSuccess(var msg);
  goToHomePage();
}

abstract class Presenter extends BasePresenter {
  setEmail(String email);
  setPassword(String pwd);
  doLogin();
}
