<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Responsive insert styles

Insert Responsive Image is ~90 lines and adds **no config**. It contributes styles and variables to
the parent Insert module through two hooks.

## `hook_insert_styles($insertType)`

Only for `$insertType === 'image'`. Loads every `ResponsiveImageStyle` and returns:

```php
'responsive_image__' . $style->id() => ['label' => 'Responsive: ' . $style->id()]
```

So each Responsive Image style becomes a selectable insert style `responsive_image__<id>`. These keys
appear in an image field widget's **Insert** settings and, once ticked, are stored in the parent's
`content.<field>.third_party_settings.insert.styles` map.

## `hook_insert_variables($insertType, &$element, $styleName, &$vars)`

Runs **after** the parent Insert's implementation (ordered via `hook_module_implements_alter`). It:

1. Ignores style names whose prefix is not `responsive_image`.
2. Loads the `ResponsiveImageStyle` from the id after `responsive_image__`.
3. Builds `$responsiveImageVars` (uri, width, height) and calls core
   `template_preprocess_responsive_image()` to generate the `srcset` / `sizes` attributes.
4. Sets `$vars['url']` from the responsive style's **fallback image style** (or the original file if
   there is no fallback), honouring `insert.config`'s `absolute` setting.
5. Merges the generated attributes into `$vars['attributes']` so the inserted `<img>` is responsive.

## To make a responsive insert style available

1. Create/enable a Responsive Image style (`/admin/config/media/responsive-image-style`), e.g. id
   `wide`.
2. On the image field's *Manage form display*, open **Insert** and tick `Responsive: wide`
   (`responsive_image__wide`), optionally set it as the default style.
3. Result: the widget's `third_party_settings.insert.styles` now contains
   `responsive_image__wide`, and inserting produces responsive `<img>` markup.

No config schema, config object, or persistent state ships with this submodule.
