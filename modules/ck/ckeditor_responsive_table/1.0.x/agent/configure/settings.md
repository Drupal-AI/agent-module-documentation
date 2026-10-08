<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Module settings (front-end responsive script)

Config object: **`ckeditor_responsive_table.settings`**. Admin form route
`ckeditor_responsive_table.form` at `/admin/config/content/ckeditor-responsive-table`
(menu link under *Configuration → Content authoring*), permission
`administer site configuration`. (The `info.yml` `configure` key is absent, so `data.json`
`configure` is `null`.)

## Keys

Shipped defaults live under `default_*` keys (`config/install/…settings.yml`); the form
writes the live values under the un-prefixed keys, each falling back to its `default_*` when
empty:

| Live key | Default (`default_*`) | Purpose |
|---|---|---|
| `table_selector` | `table:not([data-drupal-selector="edit-settings-selection-table"])` | CSS selector the front-end script applies to |
| `fail_class` | `tabled--stacked` | class added to a table that can't be made responsive |
| `caption_side` | `top` | `top` or `bottom` caption placement |
| `large_character_threshold` | `50` | cell char count treated as "large" width |
| `small_character_threshold` | `8` | cell char count treated as "small" width |

Only `table_selector` is declared in `config/schema` (`type: text`); the other live keys are
written by the form without schema.

## Set / read via drush

```bash
drush config:set ckeditor_responsive_table.settings caption_side bottom -y
drush config:get ckeditor_responsive_table.settings
```

```php
\Drupal::configFactory()->getEditable('ckeditor_responsive_table.settings')
  ->set('table_selector', '.field--type-text-long table')
  ->save();
```

## How the values are used

`hook_page_attachments()` (in the `.module`) runs on every **non-admin** route
(`router.admin_context`), attaches the `ckeditor_responsive_table/responsive_table_display`
library, and passes the five settings to JS as
`drupalSettings.ckeditorResponsiveTable.{tableSelector, failClass, captionSide,
largeCharacterThreshold, smallCharacterThreshold}`, using the `default_*` value whenever the
live key is empty.
