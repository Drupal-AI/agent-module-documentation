<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `title` paragraph bundle, fields, templates and library

Everything this module does is configuration + theming. No PHP beyond `hook_theme()`.

## Install / enable

`drush en drutopia_paragraph_title -y` imports the config in `config/install/`: the
`title` paragraph type, its field storages/instances, form + view displays, and two
image styles. On disk here it is a **dev checkout** (no `version:` in `info.yml`) and it
will not enable without the full Drutopia dependency chain (`drutopia_core`, the
`ui_patterns` family, `minimalhtmltitle`, etc.) present.

## Paragraphs type

`paragraphs.paragraphs_type.title.yml` — id `title`, label "Title", description
"A title for your content with an optional image and subtitle.", no behavior plugins.

## Fields (bundle `paragraph.title`)

| Field | Type | Storage / constraints | Notes |
|-------|------|-----------------------|-------|
| `field_title` | `text` | max_length 140, cardinality 1, **required** | Format locked to `minimalhtmltitle` via `allowed_formats` third-party settings (all other formats set to `'0'`). |
| `field_subtitle` | `text` | max_length 255, cardinality 1 | Same `minimalhtmltitle`-only format constraint. |
| `field_image` | `image` | png/gif/jpg/jpeg, `alt_field_required: true`, upload dir `title-image/[date:custom:Y]-[date:custom:m]` | Rendered via image styles `max_650x650` (default) / `max_325x325` (columnar). |
| `field_style_color` | `list_string` | cardinality 1, **fixed `allowed_values`**: fuchsia, blue, orange, yellow, red, dark, marine, grey, white | Author picks one named colour (options_select widget). Used only to build a CSS class. |
| `field_style_classes` | `list_string` | cardinality -1, **fixed `allowed_values`**: hero-main (Main), is-large (Large), is-light (Light) | Section modifier classes (options_buttons widget); label "Section style". |
| `field_style_titlebar` | `boolean` | on "Titlebar" / off "Normal", default 0 | Chooses layout branch (titlebar vs project/columnar). |

Form display (`core.entity_form_display.paragraph.title.default`): title/subtitle as
`text_textfield` (allowed_formats help/guidelines hidden), image as `image_image`,
colour as `options_select`, classes as `options_buttons`, titlebar as `boolean_checkbox`.

## View displays

- **default** (`core.entity_view_display.paragraph.title.default`): image via `max_650x650`
  image formatter, title/subtitle as `text_default`, colour/classes as `list_key`,
  titlebar as `boolean` (true-false). All labels hidden.
- **columnar** (`…title.columnar`): image via `image_url` + `max_325x325`, style_classes and
  style_titlebar hidden; used for card/teaser rendering.

## The `.module`

`drutopia_paragraph_title.module` implements only `hook_theme()`
(`drutopia_paragraph_title_theme()`), registering four overrides — `paragraph__title`,
`field__field_title`, `field__field_subtitle`, `field__field_style_color` — each pointing at
a template in `templates/` with the appropriate `base hook`. No preprocess functions, no
markup built in PHP, no `#markup` from field values.

## Library

`drutopia_paragraph_title.libraries.yml` declares one library, `title_paragraphs`
(component CSS `styles.css`, compiled from `scss/`). No JavaScript, no external/CDN
dependencies. It is attached at render time by `paragraph--title.html.twig` via
`attach_library('drutopia_paragraph_title/title_paragraphs')`.

## Templates — what markup each produces

- **`paragraph--title.html.twig`** — the main renderer. Attaches the CSS library; sets
  `data-headerbg="transparent"` (removed when colour is `white`); builds a `<section>` whose
  classes include `hero`, `is-<style_color>` (from the whitelisted colour value), any selected
  `field_style_classes` values, `hero-project` when the titlebar toggle is off, and
  `paragraph--unpublished` for unpublished paragraphs. When titlebar is **on** and an image is
  set, it applies a `style="background-image: url(<file_url of the image entity uri>)"`. Two
  layout branches: titlebar-off renders `container > hero-image (field_image) + hero-body
  (field_title, field_subtitle)`; titlebar-on renders a `titlebar` block with an `<h1>` holding
  the first title item.
- **`paragraph--title--columnar.html.twig`** — renders the paragraph as an `<a>` card linking to
  the parent node (`path('entity.node.canonical', …getParentEntity().id())`). Classes include
  `card`, `card-project`, `is-<style_color>`; card-image uses the rendered image URL as a
  background; title/subtitle rendered (with `striptags|trim`) into `<h3>`/`<p>`.
- **`paragraph--title--preview.html.twig`** — preview/teaser view mode: outputs the image and a
  `byline` subtitle; sets a background-image style from the image when titlebar is on.
- **`field--field-title.html.twig`** — wraps each item in `<h1>` and adds an item class `title`.
- **`field--field-subtitle.html.twig`** — wraps each item in `<h2>` and adds an item class
  `subtitle`.
- **`field--field-style-color.html.twig`** — simply prints each `item.content`.
- **`field--paragraph--field-subtitle--preview.html.twig`** — bare subtitle output for the
  preview view mode (used by case-study teasers).

## UI Patterns component

`templates/patterns/title_paragraph/title_paragraph.ui_patterns.yml` defines a `title_paragraph`
pattern (label "Title paragraph") with one field `paragraphs` (accepts a paragraph field and
outputs only the title paragraph). Its template
`pattern-title-paragraph.html.twig` iterates `paragraphs.field_body_paragraph`, and for each item
whose entity type id is `title` wraps it in a `<div class="column is-one-third">`; if none is
found it emits an HTML comment noting the node id. (`tile.ui_patterns.yml.bak` is an unused
backup and not loaded.)

## How to operate

1. Enable the module (and its Drutopia/UI Patterns dependencies).
2. On a content type with a Paragraphs field, allow the `title` paragraph type.
3. Editors add a `title` paragraph, fill title/subtitle/image, pick a colour, optional section
   classes and the titlebar toggle.
4. Tune the paragraph's view display (default vs columnar) to select the layout; the bundled
   templates + `styles.css` theme the result. There is no admin settings form.
