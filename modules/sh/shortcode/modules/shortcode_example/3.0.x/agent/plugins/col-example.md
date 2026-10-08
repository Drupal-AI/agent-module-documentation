<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `[col]` example plugin

`src/Plugin/Shortcode/BootstrapColumnShortcode.php` is the whole module — a minimal reference
shortcode to copy when writing your own.

## Definition

```php
#[Shortcode(
  id: 'col',
  title: new TranslatableMarkup('Bootstrap column'),
  description: new TranslatableMarkup('Builds a div with bootstrap column size classes'),
)]
class BootstrapColumnShortcode extends ShortcodeBase { … }
```

Id and parse token are both `col`. It extends `ShortcodeBase`, so it inherits the renderer and the
attribute/config plumbing and does not declare its own constructor (nothing extra to inject).

## `process(array $attributes, string $text, string $langcode)`

1. `getAttributes(['class' => '', 'xs' => '', 'sm' => '', 'md' => '', 'lg' => ''], $attributes)`
   — declares the five supported attributes and their defaults.
2. For each size in `['xs', 'sm', 'md', 'lg']` that is set, appends a `col-<size>-<value>` class
   with `addClass()` (e.g. `md="4"` → `col-md-4`).
3. Returns `'<div class="' . $class . '">' . $text . '</div>'`.

So `[col md="4"]hello[/col]` → `<div class="col-md-4">hello</div>` and
`[col xs="12" md="6"]…[/col]` → `<div class="col-xs-12 col-md-6">…</div>`.

## `tips($long = FALSE)`

Returns the filter-tips help: a bold usage line
`[col class="custom-class" xs="12" sm="6" md="4" lg="3"]…[/col]` plus a short or long explanation.

## Using it as a template

- Copy the file to `web/modules/custom/<mymodule>/src/Plugin/Shortcode/`, change the namespace,
  `id`, `title`, `description`, and the `process()` body.
- Add attribute defaults in `getAttributes()`, compose classes with `addClass()`, and return your
  markup.
- `drush cr`, then enable the *Shortcodes* filter and tick your new tag on a text format.
- For anything that resolves a media/path/URL attribute, inject
  `Drupal\shortcode\MediaUrlResolverInterface` and `use MediaUrlResolverTrait` (see the parent
  module's plugin guide and `shortcode_basic_tags`' `LinkShortcode`).
