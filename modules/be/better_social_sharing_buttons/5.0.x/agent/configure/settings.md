# Configure — settings, networks, block & fields

## Where
- Settings form: `/admin/config/services/better_social_sharing_buttons/config`
  (route `better_social_sharing_buttons.config`, class `BetterSocialSharingButtonsForm`).
- Permission: `administer site configuration` (core; the module defines no permission of its own).
- Config object (single): **`better_social_sharing_buttons.settings`**.

## Config keys (`better_social_sharing_buttons.settings`)
| Key | Type | Default | Meaning |
|---|---|---|---|
| `iconset` | string | `social-icons--square` | Icon set: `social-icons--square` (colored) or `social-icons--no-color` (flat/monochrome). |
| `services` | sequence of `{id, enabled}` | see below | Which networks show and (by list order) their order. |
| `width` | string | `20px` | Icon size (height = width). CSS length, e.g. `32px`. |
| `radius` | string | `3px` | Icon corner radius. `0px` = square, `100%` = circular. |
| `print_css` | string | `''` | Absolute path to a print stylesheet; required for the `print` button. |
| `facebook_app_id` | string | `''` | Facebook App ID; required for the `facebook_messenger` button. |
| `node_field` | boolean | `false` | Expose the buttons as a pseudo-field on all node types. |
| `paragraph_field` | boolean | `false` | Expose the buttons as a pseudo-field on paragraphs. |

## Available network ids (the `services[*].id` values)
`facebook`, `x`, `whatsapp`, `facebook_messenger`, `email`, `pinterest`, `linkedin`, `xing`,
`tumblr`, `reddit`, `truth`, `bluesky`, `evernote`, `print`, `copy` (copy URL to clipboard),
`telegram`.

**Enabled out of the box:** `facebook`, `x`, `email`, `linkedin`. All others ship disabled.
`services` is an ordered list — the first enabled entry renders first.

## Read / set with drush
```bash
# read
drush cget better_social_sharing_buttons.settings iconset
drush cget better_social_sharing_buttons.settings width

# set scalars
drush cset -y better_social_sharing_buttons.settings width 32px
drush cset -y better_social_sharing_buttons.settings iconset social-icons--no-color
```

`services` is a nested sequence, so set it with PHP (each item must be `{id, enabled}`):
```bash
drush php:eval '
  $wanted = ["facebook","x","linkedin","whatsapp","email"];   // enabled set
  $all = ["facebook","x","whatsapp","facebook_messenger","email","pinterest","linkedin",
          "xing","tumblr","reddit","truth","bluesky","evernote","print","copy","telegram"];
  $services = [];
  foreach ($all as $id) { $services[] = ["id" => $id, "enabled" => in_array($id, $wanted, TRUE)]; }
  \Drupal::configFactory()->getEditable("better_social_sharing_buttons.settings")
    ->set("services", $services)->save();
'
```

## Placing the buttons
- **Block:** admin_label "Better Social Sharing Buttons", plugin id
  `social_sharing_buttons_block`. Place at `/admin/structure/block`. The block form repeats
  the same options (services, iconset, width, radius, facebook_app_id, print_css); values set
  on a block instance **override** the global settings for that placement only.
- **Twig (Twig Tweak):** `{{ drupal_block("social_sharing_buttons_block") }}`.
- **Field:** set `node_field: true` / `paragraph_field: true`, then arrange the "Better Social
  Sharing Buttons" pseudo-field in the entity's *Manage display*.

## Notes
- Buttons are plain `<a target="_blank">` links to each network's own share URL — no external
  API/tracker calls. Share links use the current page URL + title, so use on canonical pages.
- Colored icons are recolored via `--bss-color1`…`--bss-color15` CSS custom properties in your theme.
- All icons come from one minified SVG sprite (`assets/dist/sprites/*.svg`), loaded once.
