# Configure optionsets, formatters & sitewide settings

## Optionsets (config entity `slick`)
Optionsets are config entities `slick.optionset.*` (config_prefix `optionset`, id key `name`).
Each bundles the Slick JS options plus a skin and responsive breakpoints. Exported keys:
`id, name, weight, label, group, skin, breakpoints, optimized, options`. The `options` array
holds Slick's own settings (`settings`, `responsives`) — e.g. `slidesToShow`, `autoplay`,
`arrows`, `dots`, `centerMode`, `vertical`, `asNavFor`.

Manage optionsets in the UI (requires the **slick_ui** submodule) at
`/admin/config/media/slick` (route `entity.slick.collection`, permission `administer slick`).
Add / edit / duplicate / delete individual sets there.

Example `config/sync/slick.optionset.carousel.yml`:
```yaml
langcode: en
status: true
id: carousel
name: carousel
label: Carousel
group: ''
skin: ''
breakpoints: 0
optimized: false
options:
  settings:
    slidesToShow: 4
    autoplay: true
    arrows: true
    dots: false
  responsives: {}
```
Set `optimized: true` to strip default values from stored config (smaller exports). The module
ships `slick.optionset.default` in `config/install`.

## Field formatters
Apply a carousel to a field on **Manage display**. Formatter plugin ids:
- `slick_image` — image fields
- `slick_media` — Media reference fields
- `slick_file` — file/entity-reference bases
- `slick_text` — text/entity fields
Each formatter lets you pick an optionset (and often a thumbnail optionset for asNavFor).
There is also a text-format filter `slick_filter` for inline carousels in body content.

## Sitewide settings (`slick.settings`)
Global settings at `/admin/config/media/slick/ui` (route `slick.settings`, in slick_ui). Key:
`sitewide` (0 = off; >0 auto-attaches the Slick initializer sitewide, values toggle
`_unload` / `_vanilla` behavior on non-admin routes — see `slick_page_attachments()`).
The active JS library (Slick vs Accessible Slick) is chosen here too.
