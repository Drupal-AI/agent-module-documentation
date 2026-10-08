<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_entity_operation implementation

Everything the module does lives in one function in `entity_display_modes_listing.module`:
`entity_display_modes_listing_entity_operation(EntityInterface $entity)`.

## Install / enable

`drush en entity_display_modes_listing -y`. No configuration follows — the operation links appear
automatically. Nothing to uninstall beyond the module itself (no config, no schema, no state).

## When it fires

The hook returns an empty array unless BOTH conditions hold (checked against
`\Drupal::routeMatch()->getRouteName()`):

- `$entity instanceof NodeTypeInterface` **and** route `entity.node_type.collection`
  (`/admin/structure/types`), or
- `$entity instanceof VocabularyInterface` **and** route
  `entity.taxonomy_vocabulary.collection` (`/admin/structure/taxonomy`).

So the extra operations show only on the node-type and vocabulary listing pages, per row.

## What it builds

Per matched bundle it resolves the entity type/bundle:

- node → `$entity_type = $entity->get('type')`, `$entity_name = 'node'`, base URL from
  `Url::fromRoute('entity.node_type.collection')`.
- vocabulary → `$entity_type = $entity->get('vid')`, `$entity_name = 'taxonomy_term'`, base URL from
  `Url::fromRoute('entity.taxonomy_vocabulary.collection')`.

It then calls core's **`entity_display.repository`** service (`EntityDisplayRepositoryInterface`):

- `getViewModeOptionsByBundle($entity_name, $entity_type)` → view modes.
- `getFormModeOptionsByBundle($entity_name, $entity_type)` → form modes.

For every returned mode whose key is **not `default`** it adds one operation:

- **View modes** → title `Manage display <entity_type> <view_mode_label>`, weight starting at 26
  (incremented per mode), CSS class `entity-display-modes-listing-item`. URL is a `base:` URI:
  - node: `<collection>/manage/<type>/display/<key>`
  - taxonomy: `<collection>/manage/<vid>/overview/display/<key>`
- **Form modes** → title `Manage form display <entity_type> <form_mode_label>`, weight starting at
  21, CSS class `entity-form-display-modes-listing-item`. URL is a `base:` URI:
  - node: `<collection>/manage/<type>/form-display/<key>`
  - taxonomy: `<collection>/manage/<vid>/overview/form-display/<key>`

Operation array keys are derived names like
`trim(str_replace(' ', '-', strtolower($title) . ' ' . $entity_type)) . '_' . $key`. URLs are built
with `Url::fromUri('base:' . …)`; titles use `t()` with `@entity_type` / `@view_mode` /
`@form_display_mode` placeholders (auto-escaped). All inputs are config-derived bundle machine names
and display-mode labels — there is no request/user-supplied data.

## Operating notes

- The target *Manage display* / *Manage form display* routes enforce their own core access when
  visited; the module only adds the link on pages an admin can already reach.
- No `default` mode is listed (core already exposes the default *Manage display* / *Manage form
  display* operations).
- Only node types and taxonomy vocabularies are handled — other entity-type bundle listings get
  nothing.
