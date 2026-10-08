# Share block (configure)

Block plugin **`better_social_share_block`** — `Plugin\Block\BetterSocialShareBlock`, admin label
"Better Social Share Buttons". Place it in any region at `/admin/structure/block`. Unlike the entity
pseudo-field / Views field (which read the site-wide `better_social_share.settings`), the block stores
its **own** settings in the block config entity, so each placement is configured independently through
`buildConfigurationForm()` / `submitConfigurationForm()`.

## What the block renders

`build()` (`BetterSocialShareBlock.php:146`) computes the current page URL and title itself:

- `#entity_url` ← `$data['entity_url'] ?? Url::fromRoute('<current>', …, {absolute:true})`.
- `#entity_title` ← `$data['entity_title'] ?? $this->titleResolver->getTitle($request, $routeObject)`.
- Adds `#float` / `#top` (from the "Button Position" fieldset) — the block is the only placement that
  supports left/right floating.
- `#theme => 'better_social_share_standard'`, `#cache => { contexts: ['url'] }`.
- Attaches library `better_social_share/better_social_share.front` and `drupalSettings`:
  `base_url` (the `better_social_share.ajax` popup URL), `current_url`, `current_title` (JS fallbacks
  used when the popup's stored URL is empty — see [../api/functions.md](../api/functions.md)).

## Per-block settings (stored on the block config)

| Setting key | Form control | Notes |
|---|---|---|
| `social_share_platforms` | draggable table of checkboxes + weights | Map keyed by platform id → `{enabled, weight, key}`. On submit, rows with `enabled == 0` are `unset`. Default enables `facebook, twitter, linkedin, pinterest`. |
| `buttons_size` | number 8–999 | Icon size in px (default `32`). |
| `more_button` | radios `default` / `custom` / `none` | "More" popup trigger button. |
| `custom_more_button` | textfield | Image URL when `more_button == custom`. |
| `more_button_placement` | radios `before` / `after` | Position of the "More" button relative to services. |
| `btn_type` | radios `default` / `transparent` / `custom` | Background style. `btn_bg_color` only used for `custom`/`transparent`. |
| `btn_bg_color` | color | Custom background hex. |
| `btn_border_round` | checkbox | Rounded corners. |
| `btn_show_label` | checkbox | Show platform labels. |
| `enable_button_spacing` | checkbox | Spacing between buttons. |
| `buttons_label` | textfield | Label above the row. |
| `icon_color_type` | radios `default` / `custom` | Icon colour mode. |
| `icon_color` | color | Custom icon hex. |
| `float` | select `none` / `left` / `right` | Floating placement (block only). |
| `top` | select `top-25` / `top-50` / `top-75` | Vertical offset for the floating row (only stored when `float != none`). |

The platform table and button/style controls mirror the site-wide settings form
([settings.md](settings.md)); the two are independent stores. There is no config schema shipped for
the block's settings (block plugin settings are stored inside the `block.block.*` config entity).

## Place a configured block from code

```php
$values = [
  'id' => 'sharebar',
  'plugin' => 'better_social_share_block',
  'region' => 'content',
  'theme' => \Drupal::theme()->getActiveTheme()->getName(),
  'settings' => [
    'label' => 'Share',
    'label_display' => '0',
    'float' => 'left',
    'top' => 'top-50',
    'buttons_size' => 32,
    'more_button' => 'default',
    'more_button_placement' => 'after',
    'social_share_platforms' => [
      'facebook' => ['enabled' => 1, 'weight' => 0, 'key' => 'facebook'],
      'x'        => ['enabled' => 1, 'weight' => 1, 'key' => 'x'],
      'whatsapp' => ['enabled' => 1, 'weight' => 2, 'key' => 'whatsapp'],
    ],
  ],
];
\Drupal\block\Entity\Block::create($values)->save();
```
