import '../../../model/settings/app_settings.dart';
import 'app_settings_repository.dart';

class AppSettingsRepositoryMock implements AppSettingsRepository {
  AppSettings? _settings;

  @override
  Future<AppSettings> load() async {
    // Mock implementation: return default settings if not already loaded
    _settings ??= AppSettings(themeColor: ThemeColor.blue);
    return _settings!;
  }

  @override
  Future<void> save(AppSettings settings) async {
    // Mock implementation: store settings in memory
    _settings = settings;
  }
}
