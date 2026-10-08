# Field type, widgets, formatters, blocks

## Field type `attribution`
`src/Plugin/Field/FieldType/AttributionItem.php`. Properties / DB columns:

| Property | Type | Column |
|---|---|---|
| `source_name` | string | varchar(255) |
| `source_link` | uri | varchar(2048) |
| `author_name` | string | varchar(255) |
| `author_link` | uri | varchar(2048) |
| `license` | string (license id) | varchar(255) |

- Field setting `licenses` (array of allowed license ids; empty = all). Default widget
  `attribution_source_author_license`, default formatter `attribution_creative_commons`.
- Add via *Manage fields* (field type appears under the general category; the module adds a
  CSS library to that category via `hook_field_type_category_info_alter`).

## Widgets (`src/Plugin/Field/FieldWidget/`)
Four variants differing only in which inputs they expose; all store into the same five properties:
- `attribution_source_author_license` (default) — source + author + license.
- `attribution_source_license` — source + license.
- `attribution_author_license` — author + license.
- `attribution_license` — license only.

Each renders a license `select` limited to the field's allowed `licenses` setting; a non-required
field gets a "- Please choose -" option. `massageFormValues()` nulls out empty sub-values.

## Formatters (`src/Plugin/Field/FieldFormatter/`)
All load the selected `attribution_license` entity and add CSS classes
(`attribution--license-<id>`, `…is-osi-approved`/`not-osi-approved`, `…is-deprecated`/`not-deprecated`),
then render a theme hook:
- `attribution_plain` → `attribution-plain.html.twig`
- `attribution_plain_oneline` → `attribution-plain-oneline.html.twig`
- `attribution_html` → `attribution-html.html.twig`
- `attribution_creative_commons` (default) → `attribution-creative-commons.html.twig`
- `attribution_creative_commons_icons` → adds CC glyph CSS (`attribution_creative_commons_icons` library)
- `attribution_creative_commons_refined` → `attribution-creative-commons-refined.html.twig`

Theme hooks are declared in `src/Hook/AttributionHooks.php`; override the templates to restyle.

## Blocks (`src/Plugin/Block/`)
`AttributionBaseBlock` provides both; each has config `license` (a license id) and `disclaimer`
(text). `build()` loads the license and runs the disclaimer through `t()` then core Token
`->replace()`, exposing `@name`/`@link` (license) plus any token (e.g. `[site:name]`,
`[current-date:html_year]`), output as `#markup`.
- `attribution` (**Attribution**, category *Legal*): default license `gpl_2_0_or_later`,
  default disclaimer "Except where otherwise noted, content on this site is licensed under a
  &lt;a href=\"@link\"&gt;@name&lt;/a&gt; license."
- `attribution_copyright` (**Copyright**): default license `all_rights_reserved`, default
  disclaimer "Copyright © [current-date:html_year] [site:name]. @name.".

Note: the disclaimer is raw admin-entered HTML rendered unescaped; it is set on the block config
form, which requires the `administer blocks` permission (trusted). Treat it like any Full-HTML
admin field.
