<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `advanced_header_field` field type, widget and formatters

## Install & enable

```bash
composer require drupal/advanced_header_field
drush en advanced_header_field -y
```

The core **`link`** module must also be enabled: the field type, widget and formatter classes
extend `Drupal\link\...` classes. `advanced_header_field.info.yml` declares **no** `dependencies`,
so enabling `link` is on you (plugin discovery fails with a class-not-found if it is missing).
Optional submodule `advanced_header_field_navigation` adds the jump menu.

## Add the field

*Structure → (bundle) → Manage fields → Add field* → **Advanced Header Field**. It is a normal
field, addable to any fieldable entity (node, block content, paragraph, taxonomy term, …).
Cardinality is fixed at **1** (declared on the field type).

### Field storage setting — Custom Styles

`storageSettingsForm()` adds a **Custom Styles** textarea (`custom_styles` storage setting).
One entry per line in `name|label` format (e.g. `hero|Hero banner`). `customStylesValidate()`
normalizes it to a `key => label` map and errors if any line is not `value|label`. These become
extra checkboxes in the widget's Styles list, in addition to the built-in `centered|Centered` and
`italic|Italic` (`AdvancedHeaderFieldHelper::getDefaultStyles()`). Legacy newline-string values are
still accepted on read (`getStyleOptions()` handles both array and string forms).

### Field settings

`defaultFieldSettings()` / `fieldSettingsForm()`:

| Setting | Default | Meaning |
|---|---|---|
| `title` | `Required` (`LinkTitleVisibility::Required`) | Whether Heading Text is required (inherited from link). |
| `link_type` | `LINK_GENERIC` | Which link targets are allowed (inherited from link). |
| `allowed_tags` | `[]` (**required**) | Which semantic tags editors may choose; checkboxes over `getAvailableTags()` = `h2`–`h6`. `fieldSettingsFormAllowedTagsValidate()` stores the checked keys. |

## Data model

`AdvancedHeaderFieldItem` extends `LinkItem`, so a stored value has the link columns plus a
subtitle:

- `uri` — link target, or the literal `route:<nolink>` when there is no link.
- `title` — the heading text.
- `options` — serialized array holding: `heading_tag` (h2-h6), `size`, `styles` (array of keys),
  `new_window` (bool), `custom_anchor_id`, and — when the navigation submodule is on —
  `show_in_jump_menu` and `short_title`.
- `subtitle` — `varchar(255)`, added by `schema()` / `propertyDefinitions()`.

There is **no `config/schema/`** in the module, so the `custom_styles`, `allowed_tags` and formatter
settings have no config-schema definition; strict schema tooling may warn, but values save and work.

## Widget: `advanced_header_field`

`AdvancedHeaderFieldWidget` (extends `LinkWidget`), `formElement()`. It reshapes the link widget
into a `details` element (`advanced-header-field` class, attaches library `advanced_header_field/admin`)
with:

- **Heading Text** (`title`, relabeled), required per the field's required flag.
- **Semantic Tag** (`heading_tag`) — select limited to the field's `allowed_tags`, default `h2`.
- **Subtitle Text** (`subtitle`) — plain textfield.
- **Header Options → Custom Anchor Id** — textfield, placeholder `unique-name`.
- **Display Options** — Visually hidden (checkbox), Size (select over h1-h6), Styles (checkboxes over
  default + custom styles).
- **Link Options** — the link `uri` element and **Open link in new window** (`new_window`).

Validation is custom: `formElement()` sets `$element['#element_validate'] = []` (it **replaces**
`LinkWidget`'s validators) and adds two static callbacks:

- `processFields()` — sets `uri` to `route:<nolink>` when the link field is empty, else to the entered
  uri; copies `title` and `subtitle` into the value.
- `processOptions()` — requires `custom_anchor_id` to match `^[a-z][a-z0-9-]+$` (else a form error),
  then builds the `options` array (heading_tag, visually_hidden, size, styles, new_window,
  custom_anchor_id).

The stored `uri` is resolved through `Url::fromUri()` at display time (see below), which is what
turns the value into an `<a>`.

## Formatter: `advanced_header_field_html` (default)

`AdvancedHeaderFieldHtmlFormatter` extends `LinkFormatter`. `defaultSettings()` = `['tag' => 'header']`;
`settingsForm()` lets you pick the wrapper tag **Semantic (`header`)** or **Generic (`div`)**.

`viewElement()` builds a `#theme => 'advanced_header_field'` render array:

- `#heading_text` — if `uri !== 'route:<nolink>'`, a `#type => 'link'` element (`#title` = heading
  text, `#url` = `buildUrl($item)`, `new_window` attribute when set); otherwise the plain title
  string.
- `#header_id` — `options['custom_anchor_id']` if set, else
  `AdvancedHeaderFieldHelper::createAnchorIdFromText($title, $parentId)` (`text-<entity id>`).
- `#header_tag` (the formatter's `tag` setting), `#heading_tag`, `#subtitle`, `#classes`
  (`size-<size>` and `style-<key>` modifiers), `#visually_hidden`, plus `#show_in_jump_menu` /
  `#short_title` for the navigation submodule.

The template `advanced-header-field.html.twig` prints `<header|div>` with base class
`advanced-header-field` and `--<modifier>` classes, the heading (`{{ heading_text }}` inside the
chosen `<h2..h6>`), and the subtitle. `preprocessThemeAdvancedHeaderField()` sets the element `id`
to the anchor id, adds `data-in-jump-menu` / `data-short-title` when opted in, and adds the core
`visually-hidden` class when requested. **Themes must supply the CSS** for the size/style modifier
classes.

## Formatter: `advanced_header_field_summary` (admin only)

`AdvancedHeaderFieldSummaryFormatter` extends `FormatterBase`. `defaultSettings()` =
`show_subtitle` / `show_anchor_id` (both FALSE). `viewElement()` renders
`#theme => 'advanced_header_field_summary'` showing the uppercased tag and heading text, optionally
the subtitle and the computed anchor id (as a `<button id="anchor-id-…">` for copying, wired by the
`advanced_header_field/summary` JS). Intended for admin/back-end displays, not front end.

## Service `advanced_header_field.helper`

`AdvancedHeaderFieldHelper` (constructed with the module's logger channel):

- `getAvailableTags()` → `h2`–`h6` labels (the choosable semantic tags).
- `getDefaultSizes()` → `h1`–`h6` labels (visual sizes).
- `getDefaultStyles()` → `centered`, `italic`.
- `getHeaderParentId(FieldItemInterface)` → id of the entity the field belongs to (walks
  item → list → entity adapter → entity).
- `createAnchorIdFromText($text, $id)` → slugified text + `-` + parent id (empty when no id).

## Theming / hooks

`AdvancedHeaderFieldHooks` (attribute hooks): `help` (help page text), `theme` (registers
`advanced_header_field` and `advanced_header_field_summary` with their preprocess callbacks).
Override the BEM base class per theme:

```php
function MYTHEME_preprocess_advanced_header_field(&$variables) {
  $variables['base_class'] = 'my-header';
}
```

## Update hook

`advanced_header_field_update_10000()` scans all `core.entity_view_display.*` config and rewrites any
field display of the retired type `advanced_header_field_string` to `advanced_header_field_summary`.
Run `drush updb` after upgrading from an older major.
