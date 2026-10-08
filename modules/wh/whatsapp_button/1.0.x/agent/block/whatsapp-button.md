<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "WhatsApp Button" block

## Install & enable

```bash
composer require drupal/whatsapp_button
drush en whatsapp_button -y
```

No dependencies beyond Drupal core. No sub-modules, permissions, routes, services or Drush.

## Place & configure

The block plugin id is **`whatsapp_button_block`** (admin label *"WhatsApp Button"*, category
*"Custom"*). Place it at **`/admin/structure/block`** into a region, or via Layout Builder. All
settings live on the **block instance** form (`blockForm()` in `WhatsappButtonBlock.php`) — there
is no global config page. The README recommends disabling *Display title* so only the floating
icon shows.

Because every setting is per-instance, you can place multiple instances (different numbers /
messages / regions).

## Settings (`defaultConfiguration()`)

| Key | Default | Form field | Meaning |
|---|---|---|---|
| `number` | `*********` | `tel`, required | WhatsApp phone number (e.g. `573053609898`). Used as `?phone=`. |
| `message` | `Hello, I want to place an order!` | textarea | Pre-filled chat text, used as `&text=`. |
| `tooltip` | `Clicking will open a new tab.` | textfield, required | `title` attribute on the link. |
| `text_contact_enabled` | `FALSE` | checkbox | Show text beside the icon. |
| `text_contact` | `Contact us here` | textfield | The text shown beside the icon when enabled. |
| `image` | `[]` | `managed_file` | Custom icon (upload location `public://whatsapp_button`; jpg/jpeg/png/svg/webp/avif). Empty → bundled logo. |
| `image_alt` | `WhatsApp Logo` | textfield, required | `alt` of the icon `<img>`. |
| `image_width` | `40` | number, required | Icon width (mobile/base). Height is `auto`. |
| `image_medition_units` | `px` | select | Unit for image widths: px/rem/em/%/vh/vw. |
| `default_image` | `/assets/WhatsApp.svg` | (not on form) | Bundled fallback icon path, resolved against the module path. |
| `position_bottom` | `40` | number, required | Base `margin-bottom` offset. |
| `position_right` | `40` | number, required | Base `margin-right` offset. |
| `position_units` | `px` | select | Unit for position offsets: px/rem/em/%/vh/vw. |
| `image_width_tablet_enabled` / `image_width_tablet` | `FALSE` / `''` | checkbox + number | Override icon width at ≥ tablet_width. |
| `image_width_desktop_enabled` / `image_width_desktop` | `FALSE` / `''` | checkbox + number | Override icon width at ≥ desktop_width. |
| `position_tablet_enabled` / `position_bottom_tablet` / `position_right_tablet` | `FALSE` / `''` / `''` | checkbox + numbers | Override offsets at ≥ tablet_width. |
| `position_desktop_enabled` / `position_bottom_desktop` / `position_right_desktop` | `FALSE` / `''` / `''` | checkbox + numbers | Override offsets at ≥ desktop_width. |
| `media_queries_enabled` | `FALSE` | checkbox | Reveal the media-query breakpoint fieldset. |
| `tablet_width` | `768` | number, required | `min-width` breakpoint (px etc.) for the tablet media query. |
| `desktop_width` | `1024` | number, required | `min-width` breakpoint for the desktop media query. |
| `media_queries_medition_units` | `px` | select | Unit for the breakpoint widths. |

The form groups these under `text_detail`, `image_fieldset`, `position_fieldset`,
`media_queries_fieldset` details/fieldsets with `#states` visibility tied to the matching
`*_enabled` checkboxes. `blockSubmit()` flattens the nested form values back into the flat
configuration keys above.

**No config schema:** the module ships no `config/schema/*.yml`, so these block settings have no
schema definition. They still save (stored in the block config entity's `settings`), but strict
config-schema tooling / `config inspector` may flag the block. Nothing here is exported to a
dedicated config object.

## How the link and markup are built

`build()` (in `WhatsappButtonBlock.php`):

1. Resolve the icon `src`. If `configuration['image'][0]` is set and the `file` entity loads, use
   `fileUrlGenerator->generateAbsoluteString($file->getFileUri())`; else build the path from
   `moduleExtensionList->getPath('whatsapp_button') . '/' . default_image` and pass it through the
   same generator.
2. Return a render array with `#theme => 'whatsapp_button_template'`, passing `number`, `message`,
   `tooltip`, `text_contact(_enabled)`, an `#theme => 'image'` sub-array for the icon
   (`width`/`height: auto`), and all the position/width/breakpoint values.
3. Attach library `whatsapp_button/whatsapp_button_block`.

`templates/whatsapp-button-template.html.twig`:

- Builds the href with `{% set hrefConcat = 'https://api.whatsapp.com/send?phone=' ~ number ~
  '&text=' ~ message %}` and renders `<a href="{{ hrefConcat }}" title="{{ tooltip }}"
  target="_blank">`. (Note: this is `api.whatsapp.com/send`, not `wa.me`.)
- Optionally renders `<span class="whatsapp-button__bubble">{{ text_contact }}</span>` when
  `text_contact_enabled` and non-empty.
- Renders the icon `<img class="whatsapp-button__image" src=… alt=… width=… height="auto">`.
- Emits an inline `<style>` block: base `.whatsapp-button` `margin-bottom`/`margin-right` from the
  position values, plus `@media (min-width: {{ tablet_width }}…)` and
  `@media (min-width: {{ desktop_width }}…)` blocks that override the button margins and
  `.whatsapp-button__image` width when the corresponding `*_enabled` flags / non-zero values are
  set. All values are Twig-auto-escaped (no `|raw`).

## Theme hook

`hook_theme()` in `whatsapp_button.module` declares **`whatsapp_button_template`** with the
variables listed above and template `whatsapp-button-template`. Override by copying
`templates/whatsapp-button-template.html.twig` into your theme.

## Assets

- `whatsapp_button.libraries.yml` → `whatsapp_button/whatsapp_button_block` attaches
  `css/whatsapp-button-block.css` (component). No JS.
- Bundled icons: `assets/WhatsApp.svg` (default) and `assets/whatsapp-logo.png`.

## Notes

- The button is a plain outbound link to WhatsApp; there is no server-side call, no API key, and
  no data leaves Drupal except the visitor's own click.
- The default `number` (`*********`) is a placeholder — set a real number or the link is useless.
