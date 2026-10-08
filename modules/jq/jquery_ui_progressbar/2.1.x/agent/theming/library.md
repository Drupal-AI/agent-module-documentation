<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attach & use the progressbar library

## The asset library

- **Id:** `jquery_ui_progressbar/progressbar`
- **Version:** jQuery UI 1.13.2
- **Files (physically in the `jquery_ui` module):**
  `assets/vendor/jquery.ui/ui/widgets/progressbar-min.js`,
  `assets/vendor/jquery.ui/themes/base/progressbar.css`
- **Auto dependencies:** `core/jquery`, `jquery_ui/internal.version`, `jquery_ui/widget`,
  `jquery_ui/internal.widget-css`

The `jquery_ui_progressbar` module itself contains **no** `*.libraries.yml`. The definition
is injected by `jquery_ui_library_info_alter()` in the base `jquery_ui` module, which reads
`jquery_ui/jquery_ui.libraries.data.json` and declares libraries "on behalf of" each
`jquery_ui_*` sub-module. Enabling `jquery_ui_progressbar` is what makes the id resolvable.

## Attach it

Render array:

```php
$build['#attached']['library'][] = 'jquery_ui_progressbar/progressbar';
```

Another module/theme's `*.libraries.yml` dependency:

```yaml
my_widget:
  dependencies:
    - jquery_ui_progressbar/progressbar
```

Twig:

```twig
{{ attach_library('jquery_ui_progressbar/progressbar') }}
<div id="progress"></div>
```

## Use the widget (client JS)

```js
// Determinate
$('#progress').progressbar({ value: 37 });
$('#progress').progressbar('value', 60);      // update

// Indeterminate / loading
$('#progress').progressbar({ value: false });

// Events
$('#progress').progressbar({
  change:   function () {},
  complete: function () {}
});
```

## Notes

- No Drupal settings, permissions, or Drush — placement and values are entirely up to the
  attaching code.
- jQuery UI is unmaintained upstream. For new work prefer a native `<progress>` element or a
  modern component; use this only to keep legacy `$.ui.progressbar` code running on D10/D11.
