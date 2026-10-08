<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Authority Link field (`authority_link`)

A link field that also records **which authority the URL comes from** (LCNAF, VIAF, geonames, …),
chosen from a per-field configurable list. Meant for linking a local term/agent to its external
authority record.

- Field type class: `Plugin\Field\FieldType\AuthorityLink` (id `authority_link`). Extends core
  `LinkItem`, so it keeps `uri` + `title` and adds a `source` string column
  (`schema()` adds a tiny-text `source`; `propertyDefinitions()` adds a `source` string property).
- Default widget `authority_link_default`, default formatter `authority_formatter_default`.
- Inherits core link constraints `LinkType`, `LinkAccess`, `LinkExternalProtocols`,
  `LinkNotExistingInternal` — so protocols are restricted and access-checked like any core link.
- Default field settings: `link_type` = `LinkItemInterface::LINK_EXTERNAL`, `authority_sources` =
  `['other' => 'Other']`.

## Field settings — authority sources

`fieldSettingsForm()` shows one textarea, one `key|label` per line (e.g. `lcnaf|Library of Congress`).
Parsed by `extractPipedValues()` into `authority_sources`, stored per config schema
`field.field_settings.authority_link` (`authority_sources` sequence, plus inherited `title`,
`link_type`). `getSources()` returns the map.

## Widget: `authority_link_default`

Class `Plugin\Field\FieldWidget\AuthorityLinkWidget` (extends core `LinkWidget`). Renders a fieldset
with: a **Source** `select` populated from `authority_sources`; a **URL** field (`#type => url`,
maxlength 2048, validated by core `validateUriElement`); and an optional **Alternate link text**
textfield (maxlength 255). Widget settings `placeholder_url` / `placeholder_title`
(`field.widget.settings.authority_link_default`).

## Formatter: `authority_formatter_default`

Class `Plugin\Field\FieldFormatter\AuthorityLinkFormatter` (extends core `LinkFormatter`). Link text
defaults to the source label (`authority_sources[source]`, falling back to the raw source key). If an
alternate `title` is set, it is run through `\Drupal::token()->replace()` (entity context) and used as
the link title — rendered as a core `#type => link` element (so the title is auto-escaped by the link
generator) or as `#plain_text` when URL-only + plain. Adds `target="_blank"` by default.

Formatter settings (`field.formatter.settings.authority_formatter_default`): `trim_length`,
`url_only`, `url_plain`, `rel` (adds `rel="nofollow"`), `target`.

## JSON-LD

`hook_jsonld_field_mappings()` (in the .module) maps `authority_link` to `@type: xsd:anyURI`. The
defaults submodule's RDF mappings point authority links at `schema:sameAs`.

## Create the field in code

```php
\Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_authority_link', 'entity_type' => 'taxonomy_term',
  'type' => 'authority_link', 'cardinality' => -1,
])->save();
\Drupal\field\Entity\FieldConfig::create([
  'field_name' => 'field_authority_link', 'entity_type' => 'taxonomy_term', 'bundle' => 'person',
  'settings' => ['authority_sources' => ['lcnaf' => 'LC Name Authority File', 'viaf' => 'VIAF']],
])->save();
```
