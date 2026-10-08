<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Define a StaticSettings plugin & use the condition

## Define a static setting (enum plugin)
Create `src/Plugin/StaticSettings/MySetting.php` in your module. A plugin is a backed `enum`
implementing `StaticSettings\BaseStaticSettingInterface`, annotated with the module's attribute:

```php
namespace Drupal\MY_MODULE\Plugin\StaticSettings;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\static_setting_contexts\Attribute\StaticSettings;
use StaticSettings\BaseStaticSettingInterface;

#[StaticSettings(
  id: 'site_mode',
  label: new TranslatableMarkup('Site Mode'),
  description: new TranslatableMarkup('Current environment mode.'),
)]
enum SiteMode: string implements BaseStaticSettingInterface {
  case Prod = 'prod';
  case Staging = 'staging';
  case Dev = 'dev';
}
```

- `id` **must** equal the "group" or be prefixed `group:child` (per the attribute docblock) or the
  plugin will not be discovered.
- The enum's `cases()` supply the condition's options: the case `name` is the stored/checked key, the
  case `value` (ucwords) is the shown label.

### Autoloader gotcha (required)
Static-settings validates settings via its own resolution, which needs your namespace autoloadable.
Add to your project/module `composer.json`:
```json
"autoload": { "psr-4": {
  "Drupal\\MY_MODULE\\Plugin\\StaticSettings\\": "web/modules/custom/MY_MODULE/src/Plugin/StaticSettings"
}}
```
See the owenbush/static-settings docs for how a setting's live value is resolved (env/deployment).

## Use it as a condition
Once at least one setting exists, the **Static Settings** condition
(`static_setting_contexts_static_settings`) appears anywhere core Conditions are used (e.g. block
visibility). It renders one checkbox group per defined setting (`buildConfigurationForm`), stores
selected case names (schema `condition.plugin.static_setting_contexts_static_settings` →
`static_settings` nested sequences), and evaluates:

- Empty selection + not negated → `TRUE`.
- For each setting with selected values: get the live value `StaticSettings::get($definition['class'])->name`
  and require it to be `in_array(...)` the selection; any miss → `FALSE`.
- Multiple settings are ANDed; `InvalidStaticSettingsException` is swallowed (that setting is skipped).
- Negation (`isNegated()`) flips the summary to "IS NOT".

There is no plugin-manager service to call directly for most uses; you consume it through core's
condition/visibility UI. Programmatically, the manager is `plugin.manager.static_setting_contexts`.
