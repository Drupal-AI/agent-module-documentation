# Setting data provider plugins (UiPatternsSettingDataProvider)

A **data provider** supplies dynamic option lists for settings (e.g. for a select) at runtime.

- Manager: `plugin.manager.ui_patterns_settings_data_provider`
  (`\Drupal\ui_patterns_settings\UiPatternsSettingsDataProviderManager`).
- Directory: `src/Plugin/UiPatterns/SettingDataProvider/`. Annotation:
  `@UiPatternsSettingDataProvider`. Interface: `PatternSettingDataProviderInterface`. Base:
  `PatternSettingDataProviderBase`.

## Built-ins

| id | Provides |
|---|---|
| `menu` | Options derived from a menu (`MenuDataProvider`) |
| `breadcrumb` | Options derived from the breadcrumb (`BreadcrumbDataProvider`) |

## Implement one

```php
/**
 * @UiPatternsSettingDataProvider(
 *   id = "vocabularies",
 *   label = @Translation("Vocabularies"),
 * )
 */
class VocabulariesDataProvider extends PatternSettingDataProviderBase {
  public function getData() {
    // return [id => label, ...] used as options for a setting
  }
}
```
