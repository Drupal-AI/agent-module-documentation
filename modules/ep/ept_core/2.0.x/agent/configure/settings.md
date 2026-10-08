<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global EPT settings

Config object **`ept_core.settings`** (schema `config/schema/ept_core.schema.yml`, type
`config_object`). Settings form at `/admin/config/content/ept-core` (route `ept_core.settings`,
`EptCoreSettingsForm`, permission `administer site configuration`). These are site-wide
defaults shared by EPT paragraph modules.

## Keys

Colours (HEX strings, validated by `EptGenericValidator`):
- `ept_core_primary_color`, `ept_core_primary_button_text_color`
- `ept_core_secondary_color`, `ept_core_secondary_button_text_color`
- `ept_core_background_color` (default `#0d77b5`; falls back to `EptConstants::COLOR_BLUE`)

Breakpoints (px, strings):
- `ept_core_mobile_breakpoint` (default `640`)
- `ept_core_tablet_breakpoint` (`1020`)
- `ept_core_desktop_breakpoint` (`1320`)

Named container widths (px, strings):
- `ept_core_xxsmall_width` (`480`), `ept_core_xsmall_width` (`640`),
  `ept_core_small_width` (`768`), `ept_core_default_width` (`960`),
  `ept_core_large_width` (`1100`), `ept_core_xlarge_width` (`1320`),
  `ept_core_xxlarge_width` (`1600`)

Note: the shipped `config/install/ept_core.settings.yml` sets the breakpoint/width/background
keys; the four primary/secondary colour keys exist in the schema and are set via the form
(may be empty until saved).

## Read / write

```bash
drush cget ept_core.settings
drush cset ept_core.settings ept_core_background_color '#222222' -y
drush cset ept_core.settings ept_core_mobile_breakpoint 600 -y
```

```php
\Drupal::configFactory()->getEditable('ept_core.settings')
  ->set('ept_core_primary_color', '#ff0000')->save();
```

These values feed the `ept_core.generate_css` service when it builds per-paragraph CSS.
