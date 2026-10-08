# Field type, widgets, formatters, blocks

## Field type `attribution`
`src/Plugin/Field/FieldType/AttributionItem.php`. Ten properties / DB columns:

| Property | Type | Column | Notes |
|---|---|---|---|
| `source_name` | string | varchar(255) | |
| `source_link` | uri | varchar(2048) | |
| `author_name` | string | varchar(255) | |
| `author_link` | uri | varchar(2048) | |
| `license` | string (license id) | varchar(255) | |
| `creation_type` | string | varchar(32) | one of `human_created`, `ai_generated`, `ai_modified` (new in 1.2) |
| `ai_tool` | string | varchar(255) | AI tool name (new in 1.2) |
| `ai_prompt` | string | text `big` | AI prompt text (new in 1.2) |
| `prompt_editor_name` | string | varchar(255) | who edited the prompt (new in 1.2) |
| `prompt_editor_link` | uri | varchar(2048) | link for the prompt editor (new in 1.2) |

- Creation-type labels via `AttributionItem::creationTypeOptions()` ("Human-created",
  "AI-generated", "AI-modified"). `isEmpty()` is TRUE only when all ten properties are NULL.
- Field setting `licenses` (array of allowed license ids; empty = all). Default widget
  `attribution_source_author_license`, **default formatter `attribution_default`** (changed from
  `attribution_creative_commons` in 1.1). Field category is `general`; the module adds a CSS
  library to that category via `hook_field_type_category_info_alter`.

## Widgets (`src/Plugin/Field/FieldWidget/`)
Four variants differing only in which name/link inputs they expose; **all now also render the
creation-type select plus the conditional AI inputs** (via `AttributionWidgetBase::buildCreationTypeElements`):
- `attribution_source_author_license` (default) — source + author + license.
- `attribution_source_license` — source + license.
- `attribution_author_license` — author + license.
- `attribution_license` — license only.

Common behaviour (`AttributionWidgetBase`):
- License `select` limited to the field's allowed `licenses`; a non-required field gets a
  "- Please choose -" option.
- Creation type `select` ("- Unspecified -" empty option). `ai_tool` (textfield), `ai_prompt`
  (textarea), and a `prompt_editor` inline container (`prompt_editor_name`, `prompt_editor_link`)
  are shown via `#states` only when creation type is `ai_generated` or `ai_modified`.
- `massageFormValues()` nulls out empty sub-values, flattens the nested containers, and — because
  `#states` only hides client-side — explicitly clears `ai_tool`/`ai_prompt`/`prompt_editor_*`
  when the creation type is not an AI type, so stale hidden values never persist.

## Formatters (`src/Plugin/Field/FieldFormatter/`)
Seven formatters. All add license CSS classes via `AttributionFormatterBase::buildLicenseClasses`
(`attribution`, `attribution--license-<id>`, `…is-osi-approved`/`not-osi-approved`,
`…is-deprecated`/`not-deprecated`) and expose a `creation` variable to their template:
- `attribution_default` (**default**, new in 1.2) — configurable, code-rendered (no twig template
  beyond `attribution-default.html.twig`). Settings: `use_identifier` (show SPDX id vs name),
  `cc_icon` (CC badge for `cc*` licenses), `divider` (dividers vs connector words like "under"/"by"),
  `ai_icon` (AI-type icon), `show_prompt` (prompt in a `<details>`), `label_toggle` (field label
  becomes a `<details>` summary). Schema `field.formatter.settings.attribution_default`.
- `attribution_plain` → `attribution-plain.html.twig`
- `attribution_plain_oneline` → `attribution-plain-oneline.html.twig`
- `attribution_html` → `attribution-html.html.twig`
- `attribution_creative_commons` → `attribution-creative-commons.html.twig`
- `attribution_creative_commons_icons` → adds CC glyph CSS (`attribution_creative_commons_icons` library)
- `attribution_creative_commons_refined` → `attribution-creative-commons-refined.html.twig`

Theme hooks are declared in `src/Hook/AttributionHooks.php` (each now carries a `creation`
variable; `attribution_default` uses `lead`/`parts`/`creation`/`divider`). Override the templates
to restyle. Assets: `assets/creative-commons/*.svg` (CC badges), `assets/ai/*.svg` (AI icons).

## Blocks (`src/Plugin/Block/`)
`AttributionBaseBlock` provides both; each has config `license` (a license id) and `disclaimer`
(text). `build()` loads the license and runs the disclaimer through `t()` then core Token
`->replace()`, exposing `@name`/`@link` (license) plus any token (e.g. `[site:name]`,
`[current-date:html_year]`), output as `#markup`.
- `attribution` (**Attribution**, category *Legal*): default license `gpl_2_0_or_later`,
  default disclaimer `Except where otherwise noted, content on this site is licensed under a <a href="@link">@name</a> license.`
- `attribution_copyright` (**Copyright**, category *Legal*): default license `all_rights_reserved`,
  default disclaimer `Copyright © [current-date:html_year] [site:name]. @name.`

Note: the disclaimer is raw admin-entered HTML rendered unescaped as `#markup`; it is set on the
block config form (requires `administer blocks`, trusted). Treat it like any Full-HTML admin field.
