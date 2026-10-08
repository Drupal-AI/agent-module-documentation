<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & settings — css_js_agg_retention

## Install / enable

```bash
composer require drupal/css_js_agg_retention
drush en css_js_agg_retention -y
drush cr
```

No module dependencies (`composer.json` requires only `drupal/core: ^10.1 || ^11`; the info.yml
`core_version_requirement` is `^10.2 || ^11`). `hook_install`/`hook_uninstall`
(`css_js_agg_retention.install`) only print a Messenger status; there is no schema, no update
hooks, and uninstall does not remove already-created aggregate files.

## Config object

Single config object **`css_js_agg_retention.settings`**:

- Schema (`config/schema/css_js_agg_retention.schema.yml`): mapping with one key
  `retention_days` (`type: integer`).
- Install default (`config/install/css_js_agg_retention.settings.yml`): `retention_days: 45`.

`retention_days` is the number of days an aggregate file is kept. During a cache rebuild, files
whose modification time is older than `retention_days` are deleted; newer files are retained.

## Settings form

Route **`css_js_agg_retention.settings`** →
`/admin/config/development/performance/css-js-agg-retention`, requirement
`_permission: 'administer site configuration'`. Form
`Drupal\css_js_agg_retention\Form\AggRetentionSettingsForm` (`ConfigFormBase`,
`getFormId()` = `css_js_agg_retention_settings_form`).

- Field `retention_days`: `#type => number`, `#min => 1`, `#max => 365`, `#required => TRUE`,
  `#default_value` = stored value or the form constant `DEFAULT_DAYS = 45`.
- A collapsible `details` element ("About this setting") with static help markup; the form
  suggests 30–90 days for most sites.
- `submitForm()` casts the value to `(int)` and saves it to `css_js_agg_retention.settings`.

Menu link `css_js_agg_retention.settings` (`*.links.menu.yml`) appears under
*Configuration → Development → Performance* (parent `system.performance_settings`, weight 20).

## Setting retention programmatically

```php
\Drupal::configFactory()
  ->getEditable('css_js_agg_retention.settings')
  ->set('retention_days', 30)
  ->save();
```

Config export snippet (`css_js_agg_retention.settings.yml`):

```yaml
retention_days: 30
```

## Notes

- If `retention_days` is unset, `BaseOptimizerSelectiveDelete::deleteAll()` falls back to
  `MAX_AGE / 86400` = 45 days.
- The retention window is global; it applies identically to both the CSS and JS aggregate
  directories.
