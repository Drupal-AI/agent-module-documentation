# Configure Bootstrap Simple Carousel

## Global settings — `bootstrap_simple_carousel.settings`

Form `SettingsForm` (ConfigFormBase), route `bootstrap_simple_carousel.admin_settings` at
`/admin/config/media/bootstrap_simple_carousel`, permission `administer site configuration`.
Config is nested under a `bootstrap_simple_carousel:` key. Install defaults:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `interval` | int (ms) | 3000 | Auto-advance delay; 0 = no auto-cycle; empty = Bootstrap default 5s |
| `wrap` | int 0/1 | 1 | Cycle continuously vs. hard stop |
| `pause` | int 0/1 | 1 | Pause on mouse hover (`hover` vs `false`) |
| `indicators` | int 0/1 | 1 | Show indicator dots |
| `controls` | int 0/1 | 1 | Show prev/next arrows |
| `assets` | int 0/1 | 0 | Attach module's Bootstrap 5.3.3 library (CDN) — leave off if theme ships Bootstrap |
| `image_type` | string | `[]` | Bootstrap image class: `img-default`, `img-fluid`, or `img-circle` |
| `image_style` | string | `[]` | Image style machine name, or `original` for no style |

Set via Drush:
`ddev drush cset bootstrap_simple_carousel.settings bootstrap_simple_carousel.interval 5000 -y`

## Carousel items — the `bootstrap_simple_carousel` entity

Content entity (base table `bootstrap_simple_carousel`, no bundles). Managed through **custom forms**, not
the entity UI:

| Route | Path | Form | Permission |
|---|---|---|---|
| `bootstrap_simple_carousel.table` | `/admin/structure/bootstrap_simple_carousel` | `ItemsForm` (list) | `access bootstrap simple carousel` |
| `bootstrap_simple_carousel.add` | `/admin/structure/bootstrap_simple_carousel/add` | `EditForm` | `access bootstrap simple carousel` |
| `bootstrap_simple_carousel.edit` | `/admin/structure/bootstrap_simple_carousel/edit/{id}` | `EditForm` | `access bootstrap simple carousel` |
| `bootstrap_simple_carousel.delete` | `/admin/structure/bootstrap_simple_carousel/delete/{id}` | `DeleteForm` | `access bootstrap simple carousel` |

Item base fields: `image_id` (managed_file → file id), `image_alt`, `image_title`, `image_link`,
`caption_title` (≤100), `caption_text`, `weight`, `status` (1 active / 0 inactive).

EditForm notes:
- On **add**, `image_id` is a `managed_file` upload (extensions `gif png jpg jpeg`, ~25 MB limit,
  destination `public://bootstrap_simple_carousel/`); the uploaded file is set permanent on save.
- On **edit**, the image is **not changeable** — only a preview is shown. To swap an image, delete/deactivate
  the item and create a new one.
- `image_link` accepts a full URL, or an internal path like `node/1` / `about` (resolved at render by
  `Url::fromUri()`, prefixing `internal:/` when no host is present).

## Displaying the carousel — the block

Block plugin `bootstrap_simple_carousel_block` ("Bootstrap simple carousel block"). Place it in a region via
Block layout. `blockAccess()` allows anyone with `access content`. It renders **active** items only, ordered by
`weight` DESC, through the theme template, applying the configured `image_style` (or original) and the
`image_type` class. If the `assets` setting is on, the block attaches library
`bootstrap_simple_carousel/bootstrap` (Bootstrap 5.3.3 JS+CSS from jsDelivr).

## Theming

Theme hook `bootstrap_simple_carousel_block`; template `templates/bootstrap--simple--carousel--block.html.twig`
receives `items` (each with `image_url`, `image_link`, `image_alt`, `image_title`, `caption_title`,
`caption_text`) and `settings` (the ImmutableConfig). All text is output through Twig autoescaping. Override the
template in your theme to change markup. Container id is `#carousel-block-generic`; Bootstrap `data-bs-*`
attributes are driven by the settings.
