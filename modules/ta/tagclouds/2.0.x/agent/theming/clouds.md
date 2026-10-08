# Theming — hooks, templates, level classes

## Theme hooks (`hook_theme()` in `tagclouds.module`)

- `tagclouds_list_box` — variables `vocabulary`, `children`. Template
  `templates/tagclouds-list-box.html.twig`. Used by the `/tagclouds/list/{voc}` page.
- `tagclouds_weighted` — variables `terms`, `children`. Template
  `templates/tagclouds-weighted.html.twig`. Renders the weighted cloud itself.

## Size levels

Each term is assigned a weight from `1`…`levels` (the `levels` setting, default 6) based on
usage, output as a CSS class **`level1` … `level{levels}`**. Style these classes to control font
size/color per level. More levels = finer size gradation.

## CSS library

`tagclouds.libraries.yml` defines `tagclouds/clouds` → `css/tagclouds.css` (theme layer).
Attach it when rendering a cloud yourself:

```php
$build['#attached']['library'][] = 'tagclouds/clouds';
```

The shipped `css/tagclouds.css` gives baseline sizes for the `levelN` classes; override it in
your theme (or provide larger/smaller steps) to restyle the cloud. To change markup, override the
two twig templates above in your theme.
