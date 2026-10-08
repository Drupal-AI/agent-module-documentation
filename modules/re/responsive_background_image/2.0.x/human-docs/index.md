# Responsive Background Image — manual setup guide

**Responsive Background Image** (`responsive_background_image`) is a small
**developer/themer helper**. It gives you one PHP method that generates a
`<style>` tag full of CSS media queries so a Drupal **Responsive Image Style** can
be applied as a responsive `background-image` on a CSS selector of your choosing.
In other words, it lets a background image swap between different files at different
breakpoints — a smaller image on mobile, a larger one on desktop, and a 2x version
for retina screens — using the same Responsive Image Style you already configure for
foreground images.

This is exactly what you want for a hero or banner region where the image is a CSS
background rather than an `<img>` tag. Typical uses are a Paragraph hero, a custom
block, or a node's banner, where you give each instance a unique CSS class and let
the module emit the right media queries into the page `<head>`.

There is **no user interface, no settings, no permissions, and no admin routes** —
the module is meant to be called from your theme's or module's preprocess code. That
is why this guide has an installation page and a usage walkthrough here, but no
configuration page.

This guide is written for a **human** developer. If you want a terse, token-cheap
reference for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (needs core's Responsive Image module).

## Where it lives in the admin menu

Nowhere — there is no admin UI. You do need to set up a **Responsive Image Style**
first (at **Configuration → Media → Responsive image styles**), because this module
turns that style into background-image CSS. Note it only supports the "**Select a
single image style**" option per breakpoint, not the `sizes`/multi-style option.

## How to use it

Call the one static method from a `hook_preprocess_HOOK()` and attach the result to
the page `<head>`:

```php
use Drupal\responsive_background_image\ResponsiveBackgroundImage;

function mytheme_preprocess_paragraph(&$vars) {
  $paragraph = $vars['paragraph'];
  if ($paragraph->bundle() === 'hero'
      && !$paragraph->get('field_hero_background_image')->isEmpty()) {

    // A unique class per entity so multiple heroes on one page don't collide.
    $css = 'paragraph--id--' . $paragraph->id();
    $vars['attributes']['class'][] = $css;

    $style = ResponsiveBackgroundImage::generateMediaQueries(
      '.' . $css . ' .hero__image',        // the CSS selector to style (no braces)
      $paragraph,                           // the entity holding the image field
      'field_hero_background_image',        // the image field's machine name
      'hero_paragraph'                      // the Responsive Image Style machine name
    );

    if ($style) {
      $vars['#attached']['html_head'][] = $style;
    }
  }
}
```

The method signature is:

```php
ResponsiveBackgroundImage::generateMediaQueries(
  string $css_selector,
  $entity,                        // a content entity with the image field, or a File entity
  ?string $field_machine_name,    // the image field name; pass NULL when $entity is a File
  string $responsive_image_style_machine_name,
  string $media_entity_field_machine_name = 'field_media_image'  // only for Media image fields
): array|false
```

Things worth knowing:

- **Make the selector unique** — include the entity id (as in the example) so
  several backgrounds on one page don't overwrite each other.
- **It supports three sources** — a classic core Image field, a Media (image)
  reference field (needs the core Media module), or a `File` entity you pass
  directly.
- **It returns `FALSE`** (and logs to the `responsive_background_image` channel) if
  the field or file is empty or the field type is unsupported — so guard with
  `if ($style)` as shown.
- **You must attach the result** to `$vars['#attached']['html_head'][]`, or nothing
  happens.
- **Add your own `background-size: cover;`** (and any positioning) in your theme CSS
  — the module only generates the `background-image` rules.

The generated CSS includes a base fallback rule (from the Responsive Image Style's
fallback image), one `@media` block per breakpoint at 1x, and matching
device-pixel-ratio blocks for any 2x mappings — all driven by your theme's
breakpoint group. See the [`agent/`](../agent/api/generate.md) docs for the exact
return shape.
