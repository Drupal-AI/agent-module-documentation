# Configure the ImageLightbox formatters

No global settings page (`configure` null). You select an ImageLightbox formatter on an
entity's **Manage display** tab (`admin/structure/.../display`) for an image or media field and
open the cog to set options. Settings persist in the `entity_view_display` config entity.

## The two formatters

| Formatter id | Field type | Class | Notes |
|---|---|---|---|
| `imagelightbox` | `image` | `ImageLightboxFormatter` (extends core `ImageFormatterBase`) | Core Image fields. |
| `mediaimagelightbox` | `entity_reference` | `MediaImageLightboxFormatter` | Media reference fields; reads the referenced media's `field_media_image`. Only image media works. |

Both build a `#theme => 'imagelightbox_formatter'` element per delta and group every item in the
field into one lightbox (`data-imagelightbox="g"`).

## Settings keys (identical for both, from `defaultSettings()`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `image_style` | string | `thumbnail` | Image style for the **thumbnail** trigger. Empty = original image. |
| `imagelightbox_image_style` | string | `large` | Image style for the **full image shown in the lightbox**. Empty = original. |
| `captions_source` | string | `image_title` | Caption text source: `image_title`, `image_alt`, or `none`. |
| `inline` | bool | `true` | Adds `container-inline` to the field wrapper so thumbnails sit inline. |
| `lightmode` | bool | `false` | Use the light theme for the lightbox chrome (→ JS `lightmode`). |
| `navigation` | bool | `false` | Show the navigation bar (→ JS `navigation`). |
| `activity` | bool | `false` | Show the loading/activity spinner (→ JS `activity`). |
| `label` | string | `hidden` | Standard formatter label setting. |
| `buttons` | bool | `true` | Legacy default (not exposed in the settings form). |

Only `captions_source`, `lightmode`, `navigation`, `activity` are forwarded to the JS at runtime
(see below); the two image-style keys drive server-side rendering.

## Where settings are stored

```
core.entity_view_display.<entity>.<bundle>.<view_mode>:
  content:
    <field_name>:
      type: imagelightbox          # or mediaimagelightbox
      label: hidden
      settings:
        image_style: thumbnail
        imagelightbox_image_style: large
        captions_source: image_title
        inline: true
        lightmode: false
        navigation: false
        activity: false
```

## Set a formatter with Drush (example)

```php
// drush php:eval — put the lightbox formatter on node.article field_image
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_image', [
  'type' => 'imagelightbox',
  'label' => 'hidden',
  'settings' => [
    'image_style' => 'thumbnail',
    'imagelightbox_image_style' => 'large',
    'captions_source' => 'image_alt',
    'inline' => TRUE,
  ],
])->save();
```

## Runtime wiring

- Each rendered link gets `class="lightbox"`, `data-imagelightbox="g"` (the shared group id) and
  `data-ilb2-caption="<caption>"`. The caption is emitted through a Drupal `Attribute` object, so
  it is HTML-attribute-escaped automatically.
- The element attaches the `imagelightbox/formatter` library and sets
  `drupalSettings.imagelightbox` to the formatter settings array.
- `libraries/imagelightbox.config.js` runs `$('a[data-imagelightbox="g"]').imageLightbox({...})`,
  reading `activity`, `navigation`, `lightmode`, and `captions_source` (caption on/off) from
  `drupalSettings.imagelightbox`. Arrows, fullscreen, keyboard, preload, quit-on-esc are hard-coded on.

## Library loading (bundled vs site-level)

The `imagelightbox/formatter` and `imagelightbox/imagelightbox` libraries point at the module's own
bundled files (`libraries/imagelightbox.js`, `.config.js`, `.css`). Nothing to download. The
`install/imagelightbox.libraries.yml.root` variant (referencing `/libraries/imagelightbox/…`) is
provided for sites that prefer a site-level `libraries/` copy; swap it in manually if desired.

## Overriding behaviour from a theme

Override the JS init options (animation speed, arrows, fullscreen, etc.) by copying
`libraries/imagelightbox.config.js` into your theme and adding to the theme's `.info.yml`:

```yaml
libraries-override:
  imagelightbox/formatter:
    js:
      libraries/imagelightbox.config.js: js/imagelightbox.config.js
```

Override `imagelightbox-formatter.html.twig` (theme hook `imagelightbox_formatter`,
variables: `item`, `item_attributes`, `link_attributes`, `url`, `image_style`) for custom markup.

## Views note

In a View, enable **"Use field template"** on the field (or add the `imagelightbox` class in the
field's style settings) so the grouped `data-imagelightbox="g"` links are emitted correctly.

## Caption / XSS responsibility

Captions come from the image field's `title`/`alt` and are rendered into the `data-ilb2-caption`
attribute via Drupal's `Attribute` object, which escapes them. imageLightbox.js then injects the
caption into the overlay; as with any client-side caption, keep the caption source (title/alt) as
plain author-controlled text.
