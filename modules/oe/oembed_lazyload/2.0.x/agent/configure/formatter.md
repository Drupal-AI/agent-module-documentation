<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `lazyload_oembed` field formatter

No settings page. You lazy-load embeds by choosing this formatter on a field's **Manage
display**.

- **Formatter id:** `lazyload_oembed` ("Lazy load oEmbed video").
- **Field types:** `link`, `string`, `string_long` (the field holds an oEmbed resource URL).

## Settings (schema `field.formatter.settings.lazyload_oembed`)

| Setting | Default | Meaning |
|---|---|---|
| `strategy` | `intersection_observer` | `intersection_observer` = load when it enters the viewport; `onclick` = load when the user clicks a play button |
| `intersection_observer_margin` | `''` | root margin for the observer (e.g. `20px` or `4%`); only used with the intersection_observer strategy |
| `max_width` | `0` | max embed width in px (`0` = unset) |
| `max_height` | `0` | max embed height in px (`0` = unset) |

## Where it is stored

```
core.entity_view_display.<entity>.<bundle>.<view_mode>
  content:
    <field_name>:
      type: lazyload_oembed
      settings:
        strategy: intersection_observer   # or onclick
        intersection_observer_margin: ''
        max_width: 0
        max_height: 0
```

## Programmatic (drush php:eval)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$vd->setComponent('field_video_url', [
  'type' => 'lazyload_oembed',
  'settings' => ['strategy' => 'onclick', 'max_width' => 640, 'max_height' => 360,
                 'intersection_observer_margin' => ''],
  'region' => 'content', 'label' => 'hidden',
])->save();
```

## What happens at render

The formatter resolves the oEmbed resource, renders a **placeholder** (provider, title,
thumbnail) via the `oembed_lazyload` / `oembed_lazyload_placeholder` templates, and attaches the
JS library for the chosen strategy (`oembed_lazyload/onclick` or `.../intersection-observer`).
The real provider iframe is fetched on demand through a module route protected by
`oembed_lazyload.iframe_access_checker` (`IframeUrlHelper` signs an `oembed_lazyload_hash` query
param so only placeholder-issued URLs resolve). Per-provider tweaks come from a
`ProviderEnhancer` plugin — see [../plugins/provider-enhancer.md](../plugins/provider-enhancer.md).
There is no permission and no config entity beyond the view-display component.
