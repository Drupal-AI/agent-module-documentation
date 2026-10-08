<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EBT Core site-wide settings

The `configure` route is `ebt_core.settings` → `/admin/config/content/ebt-core` (menu:
Configuration » Content authoring » Extra Block Types (EBT) settings). It requires the
`administer site configuration` permission. The form (`EbtCoreSettingsForm`,
`ConfigFormBase`) edits the single config object **`ebt_core.settings`**. These values are
applied to EBT blocks as defaults.

## Config keys (`ebt_core.settings`)

| Key | Group | Shipped default |
|---|---|---|
| `ebt_core_primary_color` | Colors | (unset) |
| `ebt_core_primary_button_text_color` | Colors | (unset) |
| `ebt_core_secondary_color` | Colors | (unset) |
| `ebt_core_secondary_button_text_color` | Colors | (unset) |
| `ebt_core_background_color` | Colors | `#0d77b5` (EbtConstants::COLOR_BLUE) |
| `ebt_core_mobile_breakpoint` | Breakpoints | `640` |
| `ebt_core_tablet_breakpoint` | Breakpoints | `1020` |
| `ebt_core_desktop_breakpoint` | Breakpoints | `1320` |
| `ebt_core_xxsmall_width` | Width | `480` |
| `ebt_core_xsmall_width` | Width | `640` |
| `ebt_core_small_width` | Width | `768` |
| `ebt_core_default_width` | Width | `960` |
| `ebt_core_large_width` | Width | `1100` |
| `ebt_core_xlarge_width` | Width | `1320` |
| `ebt_core_xxlarge_width` | Width | `1600` |

(Color values are stored as strings; the shipped `config/install/ebt_core.settings.yml` sets
the breakpoints, widths, and background color. The four brand/button colors have no install
default.) Config schema: `ebt_core.settings` (config_object) in `config/schema/ebt_core.schema.yml`.

## Form validation

- The three breakpoints (mobile/tablet/desktop) must all be **different**.
- The seven width values must all be **different**.
- Color fields are validated as HEX by
  `EbtSettingsDefaultWidget::validateColorElement`.
- On submit, an empty `ebt_core_background_color` falls back to `#0d77b5`.

(These rules are enforced by the form only; direct config writes via drush bypass them.)

## Read / write with drush

```bash
drush cget ebt_core.settings                          # dump all values
drush cget ebt_core.settings ebt_core_background_color # one value
drush cset ebt_core.settings ebt_core_background_color '#223344' -y
drush cset ebt_core.settings ebt_core_mobile_breakpoint '600' -y
```

Or in PHP:

```php
$config = \Drupal::configFactory()->getEditable('ebt_core.settings');
$config->set('ebt_core_secondary_color', '#ff8800')->save();
```

## Where the values are used

`hook_preprocess_block` passes the mobile/tablet/desktop breakpoints into
`drupalSettings.ebtCore` for EBT blocks, and EBT block modules read the color/width defaults
when rendering. The install hook `ebt_core_update_9101` seeds `ebt_core_background_color` to
`#0d77b5` on older sites.
