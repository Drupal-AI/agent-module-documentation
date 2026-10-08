# Make a theme color-compatible

Color only shows its picker for themes that opt in by shipping **`color/color.inc`** in the theme
root (loaded by `color_get_info()` in `color.module`). The file must define an `$info` array; the
module merges in defaults for the optional keys.

```php
// mytheme/color/color.inc
$info = [
  // Element keys → labels shown as palette fields.
  'fields' => [
    'base'   => t('Base'),
    'text'   => t('Text'),
    'link'   => t('Links'),
  ],
  // Predefined schemes; 'default' is required and is the reference palette.
  'schemes' => [
    'default' => [
      'title'  => t('Blue lagoon (default)'),
      'colors' => ['base' => '#0f7dc2', 'text' => '#333333', 'link' => '#0071b3'],
    ],
  ],
  // CSS files whose hex colors get rewritten with the chosen palette.
  'css' => ['css/colors.css'],
];
```

Optional keys (defaults applied by `color_get_info()`): `copy` (neutral files to copy verbatim),
`gradients`, `fill` (`[x,y,w,h]` solid-color regions), `slices` (image cut-outs keyed by filename),
`blend_target` (blend reference, default `#ffffff`), plus `base_image` (a PNG rendered via GD),
`preview_library` and `preview_html` (custom preview assets).

How recoloring works:
- Colors in the default palette are swapped for the chosen palette; any other hex in the CSS is
  **extrapolated** from the `base` color via `_color_shift()` so custom shades track the palette.
- Wrap a stylesheet region with a `Color Module: Don't touch` comment marker to exclude it from
  rewriting.
- `base` is auto-selected for `a{}` (uses `link`) and `color:` declarations (uses `text`).

Theme hook / template: `color_scheme_form` (`hook_theme()`), template
`templates/color-scheme-form.html.twig`, preprocessed by `template_preprocess_color_scheme_form()`
which injects `form.scheme`, `form.palette` and `html_preview` (defaults to the module's
`preview.html` unless `preview_html` is set). The JS picker/preview come from libraries
`color/drupal.color` + `color/admin` (farbtastic).

The stock `bartik` theme (a `test_dependency`) is the canonical reference implementation.
