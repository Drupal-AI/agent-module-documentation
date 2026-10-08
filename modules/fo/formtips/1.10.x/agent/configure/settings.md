<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form Tips settings (`formtips.settings`)

Route `formtips.setting_form` → `/admin/config/user-interface/formtips`
(form `Drupal\formtips\Form\FormtipsSettingForm`, permission `administer formtips`). Every value
lives in the single `formtips.settings` config object; there are no other entities.

## Config keys (with shipped defaults)

| Key | Default | Meaning |
|---|---|---|
| `formtips_trigger_action` | `'click'` | How a tooltip opens: `'hover'` or `'click'`. |
| `formtips_max_width` | `'500px'` | Max width of the tooltip box (any CSS length). |
| `formtips_selectors` | `''` | Newline-separated CSS/jQuery selectors whose elements are **excluded** from tooltip conversion. |
| `formtips_themes` | `{}` (all) | Sequence of theme machine names Form Tips applies to. Empty = every theme. |
| `formtips_hoverintent` | `1` | Attach the bundled hoverIntent plugin (hover mode only). Turn off if the theme provides one. |
| `formtips_interval` | `500` | hoverIntent polling interval (ms). |
| `formtips_sensitivity` | `3` | hoverIntent movement sensitivity (px). |
| `formtips_timeout` | `1000` | hoverIntent delay before closing (ms). |

The hoverIntent group (`formtips_hoverintent`/`interval`/`sensitivity`/`timeout`) is only
relevant when `formtips_trigger_action` is `hover`; on the form these fields are shown inside a
"Hover intent settings" fieldset that is visible only when Trigger action = Hover.

## How the settings reach the browser

`formtips_page_bottom()` (in `formtips.module`) runs on each request and:

1. If `formtips_themes` is non-empty and the active theme isn't in it, it does nothing.
2. Builds `drupalSettings.formtips` from `selectors` (exploded on newlines), `interval`,
   `sensitivity`, `timeout`, `max_width` and `trigger_action`.
3. Attaches `formtips/hoverintent` when `trigger_action == 'hover'` and `formtips_hoverintent`
   is on, then always attaches `formtips/formtips` (which reads those settings and rewrites
   descriptions into tooltips).

Config is registered as a cacheable dependency, so a settings change takes effect on the next
page build.

## Read / set via drush

```bash
drush cget formtips.settings
drush cset formtips.settings formtips_trigger_action hover -y
drush cset formtips.settings formtips_max_width '320px' -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('formtips.settings')
  ->set('formtips_trigger_action', 'hover')
  ->set('formtips_max_width', '320px')
  ->save();
```

Note: the settings form saves by iterating existing config keys and reading the matching form
value, so any key present in `formtips.settings` is round-tripped through the form.

## Optional integration

`formtips_library_info_alter()` adds `form_placeholder/form_placeholder` to the `formtips`
library's dependencies when the `form_placeholder` module is enabled, so descriptions can also
become input placeholders. No configuration needed beyond enabling that module.
