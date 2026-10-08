# Templates, libraries & the W3.CSS asset

## Libraries (`w3css_paragraphs.libraries.yml`)

| library | attached where | contents |
|---------|----------------|----------|
| `w3css_paragraphs/w3css-paragraphs` | front-end paragraph templates (`{{ attach_library(...) }}`) | `css/w3css-color-libraries-classes.css`, `css/w3css-color-active-classes.css`, `css/w3css-paragraphs-base.css`, `js/w3css-paragraphs-base.js` |
| `w3css_paragraphs/w3css-paragraphs-admin-seven` | admin routes when the admin theme is Seven | admin form styling CSS/JS |
| `w3css_paragraphs/w3css-paragraphs-admin-claro` | admin routes otherwise | admin form styling CSS/JS |

All library assets are **bundled locally** in `css/` and `js/`; every library depends on
`core/jquery`, `core/drupal`, `core/once`. There is **no CDN reference and no remote fetch** —
grep of `css/`, `js/`, `templates/`, and the library file finds no external URL. The module's own
CSS only defines its container/spacing helpers and the color-option classes; the **full W3.CSS
framework grid/colors are supplied by the companion theme** (W3CSS / Solo, listed as a dependency
in `README.md`), not by this module.

`hook_preprocess_page()` in `w3css_paragraphs.module` attaches the matching admin library on admin
routes: it reads `system.theme` (admin theme, falling back to default) and, via
`router.admin_context`, adds `-admin-seven` when the theme name is `Seven`, else `-admin-claro`.

## Template overrides (`hook_theme` + `templates/`)

`hook_theme()` registers four overrides, all with `base hook: paragraph`:

| template | hook | used for |
|----------|------|----------|
| `paragraph--default.html.twig` | `paragraph__default` | generic W3.CSS container (strips the `w3css_display_*` fields, prints the rest) |
| `paragraph--w3css-simple.html.twig` | `paragraph__w3css_simple` | Simple bundle (title, body, link) |
| `paragraph--w3css-image.html.twig` | `paragraph__w3css_image` | Image bundle (media + optional wrapping link) |
| `field--entity-reference-revisions.html.twig` | `field__entity_reference_revisions` | nested paragraph field wrapper |

## How a paragraph renders (front-end templates)

The Simple/Image/default templates each build a `classes` array starting with
`w3-row p-container paragraph paragraph--type--<bundle> ...`, then for every set `w3css_display_*`
field they do `content.<field>|render|striptags|trim` and merge the result into the class list,
finally emitting `{{ attributes.addClass(classes) }}`. The `list_string` option fields yield fixed
W3.CSS class names; on `w3css_simple` the free-text `w3css_display_classes` value is merged the same
way. Background color is composed from `w3css_display_bg_color` + `w3css_display_opacity` into an
inline `style="background-color: rgba( … )"`. Margin/padding option values wrap the inner child
`<div>`. Links render as `<a href="{{ url }}" title="{{ title_attr }}">`, where `url` is the link
field's `#url` (a core `Url` object) and the image bundle wraps its media in that anchor.

Because output goes through Twig's `addClass()` / attribute autoescaping and rendered field
formatters, class/attribute values are HTML-escaped at print time. The color/opacity/width/etc.
inputs are constrained to their `list_string` allowed values.
