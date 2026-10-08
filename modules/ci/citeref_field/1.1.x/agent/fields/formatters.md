<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatters & field type

## Field type `citeref_field`

`src/Plugin/Field/FieldType/CiterefFieldItem.php` (extends `FieldItemBase`).
`category = General`, `default_widget = citeref_field_widget`,
`default_formatter = citeref_field_default`.

Properties (`propertyDefinitions()`) — all `string`: `citeref_type` (label *Type*),
`citeref_style` (*Style*), `citeref_id` (*ID*), `citeref_record` (*Citation*).

Storage (`schema()`): `citeref_type` varchar(10), `citeref_style` varchar(255), `citeref_id`
varchar(255), `citeref_record` varchar(2048). `isEmpty()` is true when both `citeref_id` and
`citeref_record` are empty/NULL.

Two `hook_theme` entries in `citeref_field.module` back the two formatters:
`citeref_field_default` and `configurable_citeref_field_formatter` (each declaring the same
`citeref_type/style/id/record` variables; the configurable one adds label + link-behaviour vars).

## Default formatter `citeref_field_default`

`src/Plugin/Field/FieldFormatter/CiterefFieldDefaultFormatter.php`, label **Default**.
`viewElements()` passes `citeref_type/style/id` straight through and post-processes
`citeref_record`: splits on newlines, joins lines with `<br>` (for ARK, splits each line on the
first `:` into a bold key/value), then linkifies bare `http(s)` URLs into `<a target="_blank">`.
Renders via `templates/citeref-field-default.html.twig` (which outputs the citation text inside a
`div.citeref_field`). This is the out-of-box formatter and shows only the citation text.

## Configurable formatter `configurable_citeref_field_formatter`

`src/Plugin/Field/FieldFormatter/ConfigurableCiterefFieldFormatter.php`, label **Citation or
Reference Field**. Renders `templates/configurable-citeref-field-formatter.html.twig`: an
optionally-labelled block showing type, style (DOI only), the citation ID as a resolver link,
and the citation text.

`defaultSettings()`:

| Setting | Default | Meaning |
|---|---|---|
| `citeTypeLabel` | `Citation Type` | Label before the type. |
| `citeStyleLabel` | `Citation Style` | Label before the style (DOI). |
| `citeIDLabel` | `Citation ID` | Label before the identifier. |
| `citeRecordLabel` | `Citation` | Label before the citation text. |
| `showIDUrl` | `TRUE` | Show the identifier block at all. |
| `showIDUrlLink` | `TRUE` | Render the identifier as a link (vs plain text). |
| `citeIDLabelIconOrLink` | `url` | `url` = text link; `icon` = link + resolver logo image. |
| `citeIDOpenLinkIn` | `_self` | Link `target` (`_self` / `_blank`). |
| `citeIDurlnoreferrer` | `FALSE` | Add `noreferrer` to `rel`. |
| `citeIDurlnoopener` | `FALSE` | Add `noopener` to `rel`. |
| `citeIDurlnofollow` | `FALSE` | Add `nofollow` to `rel`. |

`sanitizeSettings()` validates the enum/boolean settings and forces `showIDUrlLink=FALSE` when
`showIDUrl` is off. `settingsForm()` uses `#states` so the ID options only show when *Show
Citation ID URL* is checked. `settingsSummary()` lists labels + link mode.

The template builds resolver links per type: DOI → `https://doi.org/<id>`, Handle →
`https://hdl.handle.net/<id>`, ARK → `https://n2t.net/ark:/<id>`, URL → the stored id itself,
URN → `https://urn.issn.org/urn:<id>` (issn) or `https://www.isbnsearcher.com/search?isbn=<id>`
(isbn). Icon mode additionally emits the DOI/Handle/ARK logo images.

## Enable a formatter

*Structure → (bundle) → Manage display* → set the citeref field's format to **Default** or
**Citation or Reference Field**, then use the gear for the configurable one's options. Config
equivalent: set `content.<field>.type` to `citeref_field_default` or
`configurable_citeref_field_formatter` in the relevant `core.entity_view_display.*` object.
Note: the field type ships **no config schema**, so strict schema tooling may flag the
formatter/widget settings; they still save and work.
