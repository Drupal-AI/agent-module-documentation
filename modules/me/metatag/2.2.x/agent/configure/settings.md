# Configure meta tags

Two layers: **defaults** (config entities) and **per-entity overrides** (a field).

## Default meta tags (config entities)
`metatag_defaults` config entities (`metatag.metatag_defaults.*`), managed at
`/admin/config/search/metatag` (route `entity.metatag_defaults.collection`).

- **Global** — applies everywhere; the base of the inheritance chain.
- **Per entity type / bundle** — e.g. `node`, `node__article`, `taxonomy_term`, `user`.
  Add one via `/admin/config/search/metatag/add`.
- Inheritance: Global → entity type → bundle → per-entity field value. More specific wins.
- Each tag value supports **tokens** (`[node:title]`, `[node:summary]`, `[site:name]`).
- Revert a default back to shipped values: `.../revert`. Delete a custom one: `.../delete`.
- Read/write with drush: `drush config:get metatag.metatag_defaults.node`,
  `drush config:set metatag.metatag_defaults.global tags.title '[current-page:title] | [site:name]' -y`.

The defaults collection at `/admin/config/search/metatag` — each row is a config entity in the
inheritance chain, Edit/Revert/Delete under Operations:
![Metatag defaults collection](../../../../../../../screenshots/metatag/2.2.x/defaults-collection.png)

Editing a default (here **Global**) shows the grouped tag fields (Basic tags, Open Graph, etc.);
every value field accepts tokens via the "Browse available tokens" link:
![Edit the Global metatag default](../../../../../../../screenshots/metatag/2.2.x/global-defaults-edit.png)

## Global settings
Form at `/admin/config/search/metatag/settings` (route `metatag.settings`), stored in
`metatag.settings`: control which entity types expose the Metatag field, tag output on
`<head>`, trimming defaults, and separator/maxlength behavior (`metatag.trimmer` service).

## Per-entity override field
Add a field of type **Meta tags** (`metatag` field type, widget `MetatagFirehose`) to a
bundle to let editors override tags on individual entities. The
`MetatagEmptyFormatter` renders nothing visible — tags are attached to the page head.

## Schema
`config/schema/metatag.*.schema.yml` (`metatag.metatag_defaults.*`, `metatag.settings.*`).
