<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `media_power_bi` render (iframe template)

The display formatter renders a theme hook rather than raw markup.

## Theme hook

Defined in `media_power_bi_theme()`:

```php
'media_power_bi' => [
  'variables' => ['url' => NULL, 'title' => NULL, 'width' => NULL, 'height' => NULL],
]
```

Template: `templates/media-power-bi.html.twig`, whose entire body is:

```twig
<iframe src="{{ url }}"></iframe>
```

So by default only `url` is used; `title`, `width`, and `height` are passed as variables but
the shipped template does not apply them to the iframe markup. Override the template in your
theme if you want to honour width/height/title (e.g. add `width="{{ width }}" height="{{ height }}"`
or a wrapping style).

## What the formatter passes

`MediaPowerBiEmbedFormatter::viewElements()` builds, per non-empty valid item:

```php
[
  '#theme' => 'media_power_bi',
  '#url' => $url,                                   // trimmed field value
  '#title' => $item->getParent()->getParent()->get('name')->value,  // the media entity name
  '#width' => $this->getSetting('width'),           // default 100%
  '#height' => $this->getSetting('height'),         // default 900px
]
```

Items whose URL fails `MediaPowerBiHelper::isValidPowerBiUrl()` (wrong host) or are empty are
skipped, so nothing is rendered for them.

## To customise size/appearance

Since the base template ignores `width`/`height`, either override
`media-power-bi.html.twig` in your theme to use those variables, or wrap the iframe with CSS.
The formatter settings (`width`/`height`) still round-trip in config regardless.
