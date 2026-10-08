# Site-wide settings (configure)

Form `Drupal\better_social_share\Form\BetterSocialShareSettingsForm` (form id `bss_settings_form`),
route `better_social_share.admin_settings` at **`/admin/config/services/better-social-share`**, gated
by permission `administer better_social_share` (`restrict access: TRUE`). It edits the single config
object `better_social_share.settings`. These values are the **defaults** used by the entity
pseudo-field and the Views field; the block plugin keeps its **own** copy of the same look/behaviour
keys per instance (see [block.md](block.md)).

## Config object `better_social_share.settings`

| Key | Written by form as | Meaning / values |
|---|---|---|
| `social_share_platforms` | table (`#tabledrag`) | Map keyed by platform id → `{ enabled: 0|1, weight: int, key: <id> }`. Which platforms show and in what order. Only rows with `enabled == 1` render (sorted by `weight`). |
| `buttons_size` | `bss_buttons_size` (number 8–999) | Icon size in px. Runtime clamps to `'32'` unless it is a 1–3-digit positive integer ≠ `'32'`. |
| `more_button` | `better_social_share_more_button` (radios) | `'default'` (module SVG), `'custom'` (use `custom_more_button` image), or `'none'` (hide the "More" popup trigger). |
| `custom_more_button` | `better_social_share_custom_more_button` (textfield, schema type `uri`) | Image URL for the custom "More" button. Passed through `UrlHelper::stripDangerousProtocols()` before render. |
| `more_button_placement` | `better_social_share_more_button_placement` (radios) | `'before'` or `'after'` the service buttons. |
| `btn_type` | radios | `'default'`, `'transparent'`, or `'custom'` (custom uses `btn_bg_color`). |
| `btn_bg_color` | color | Hex background colour, only applied when `btn_type` is `custom`/`transparent`. |
| `btn_border_round` | checkbox | Rounded button corners. |
| `btn_show_label` | checkbox | Show the platform name label next to each icon. |
| `enable_button_spacing` | checkbox | Add spacing between buttons. |
| `buttons_label` | textfield | Free-text label rendered above the button row. |
| `icon_color_type` | radios | `'default'` or `'custom'`. |
| `icon_color` | color | Hex icon colour when `icon_color_type == 'custom'` (default `#fff`). |
| `entities.<entity_type_id>` | one checkbox per content entity type | `1` = expose the `better_social_share` pseudo-field on that entity type's *Manage display*; see [../fields/display.md](../fields/display.md). |

## Which entity types can be toggled

The "Entities" section lists **every content entity type** on the site
(`BetterSocialShareSettingsForm::getContentEntities()` returns all `ContentEntityType` definitions),
after `hook_better_social_share_entity_types_alter()` runs (see [../api/functions.md](../api/functions.md)).
For a curated subset of entity ids (`block_content, comment, commerce_product, commerce_store,
contact_message, media, node, paragraph`) each checkbox description links to that bundle's *Manage
display* page (requires `field_ui`). The install default enables `node`, `media`, `comment`.
"A cache rebuild may be required before changes take effect."

## Schema is partial (note)

`config/schema/better_social_share.schema.yml` only types `buttons_size`, `more_button`,
`custom_more_button`, `more_button_placement`, and `entities`. The other written keys
(`social_share_platforms`, `btn_type`, `btn_bg_color`, `btn_border_round`, `btn_show_label`,
`enable_button_spacing`, `buttons_label`, `icon_color_type`, `icon_color`) have **no schema entry**,
so config-inspector/translation will flag them. Not a functional blocker.

## Set from code

```php
\Drupal::configFactory()->getEditable('better_social_share.settings')
  ->set('buttons_size', 40)
  ->set('more_button', 'default')
  ->set('social_share_platforms', [
    'facebook' => ['enabled' => 1, 'weight' => 0, 'key' => 'facebook'],
    'x'        => ['enabled' => 1, 'weight' => 1, 'key' => 'x'],
    'linkedin' => ['enabled' => 1, 'weight' => 2, 'key' => 'linkedin'],
  ])
  ->set('entities.node', 1)
  ->save();
```

Platform keys come from `better_social_share_platforms()` (see [../api/functions.md](../api/functions.md)).
