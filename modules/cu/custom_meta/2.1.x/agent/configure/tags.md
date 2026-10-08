# Configure Custom Meta tags

All UI is under *Configuration → Search and Metadata → Metatag → Custom Meta Tags*, gated by the
`administer custom meta tags` permission.

## Routes (`custom_meta.routing.yml`)

| Route | Path | Purpose |
|---|---|---|
| `custom_meta.admin_overview` | `/admin/config/search/metatag/custom-meta` | Table of defined tags (the `configure` route). |
| `custom_meta.admin_add` | `.../custom-meta/add` | Add-tag form (`AddForm`). |
| `custom_meta.admin_edit` | `.../custom-meta/edit/{id}` | Edit-tag form (same `AddForm`, `{id}` = tag machine name). |
| `custom_meta.delete` | `.../custom-meta/delete/{id}` | Delete confirmation (`DeleteForm`). |
| `custom_meta.settings` | `.../custom-meta/settings` | Global settings form (`CustomMetaSettingsForm`) — sets `prefix`. |

## Config object `custom_meta.settings` (schema `custom_meta.schema.yml`)

```yaml
tag:                      # sequence keyed by the tag machine name
  sitename:               # <- key == name
    attribute: name       # one of: name | property | http-equiv
    name: sitename        # machine name / the meta tag's name value
    label: Sitename       # shown on the Metatag form
    description: Sitename  # help text on the Metatag form
prefix: ''                # optional; prepended to the rendered tag name by the derivers
```

The shipped default (`config/install/custom_meta.settings.yml`) defines one `sitename` tag.

## Add/edit behaviour (`src/Form/AddForm.php`)

- Fields: `attribute` (select: Name/Property/Http Equiv), `name`, `label`, `description` — all required.
- On add, the machine name must be unique (validated against existing `tag` keys); editing passes `{id}`
  so the uniqueness check is skipped.
- Submit writes the whole `tag` array back to `custom_meta.settings` keyed by `name`.

## Global prefix (`CustomMetaSettingsForm`)

Sets `custom_meta.settings:prefix`. The derivers prepend it to each derivative's `name`, so a prefix of
`og:` plus a tag named `foo` renders as `name/property="og:foo"`.

## Important caveat

Metatag plugin definitions are cached. After adding/editing/deleting a definition you must **flush caches**
(`drush cr`) before the corresponding derivative tag appears (or disappears) on the Metatag forms and output.

## Manage with Drush (example)

```bash
# Add a custom "property" tag named og_section.
drush cset custom_meta.settings tag.og_section.attribute property -y
drush cset custom_meta.settings tag.og_section.name og_section -y
drush cset custom_meta.settings tag.og_section.label 'OG Section' -y
drush cset custom_meta.settings tag.og_section.description 'Open Graph section' -y
drush cr
```
