<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `textimage_formatter` theme hook

Registered by `hook_theme()` (template `textimage-formatter.html.twig`). Use it to render a
Textimage produced via the API into an `<img>` (optionally wrapped in a `<div>` and/or `<a>`).

## Variables

| Variable | Purpose |
|---|---|
| `uri` | (required) URI of the Textimage; nothing renders without it |
| `item` | optional field item; used to source missing `alt`/`title` |
| `width`, `height` | optional pixel dimensions of the image |
| `alt` | image alternate text |
| `title` | tooltip text |
| `attributes` | associative array of attributes for the `<img>` tag |
| `image_container_attributes` | if set, wraps the `<img>` in a `<div>` with these attributes |
| `anchor_url` | if set (string or `Url`), wraps the output in an `<a href>` |

## Example render array

```php
$build['image'] = [
  '#theme'  => 'textimage_formatter',
  '#uri'    => $textimage->getUri(),
  '#width'  => $textimage->getWidth(),
  '#height' => $textimage->getHeight(),
  '#alt'    => $this->t('Generated banner'),
  '#title'  => $this->t('Banner'),
];
$textimage->getBubbleableMetadata()->applyTo($build['image']);
```

The preprocess (`TextimageThemeHooks::preprocessTextimageFormatter`) builds an inner
`image__textimage` render element and derives `anchor_attributes` / container attributes as
needed.
