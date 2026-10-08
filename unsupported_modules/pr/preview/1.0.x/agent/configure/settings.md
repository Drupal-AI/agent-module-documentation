<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable preview per entity type / bundle

## UI

1. Go to **Configuration › Content › Entity preview** (`/admin/config/content/preview`,
   route `preview.settings`) — permission `administer site configuration`.
2. Tick the entity types/bundles that should get a **Preview** button, and pick the **default view
   mode** used when previewing each.
3. Save.

## Config object

`preview.settings` (schema `preview.schema.yml`):

```yaml
enabled:
  node:
    article: full        # <entity_type>: { <bundle>: <default_view_mode> }
    page: default
  media:
    image: full
```

- `enabled` is a nested sequence: entity type → bundle → default view mode string.
- `hook_form_alter` (in `PreviewHooks::formAlter`) only adds the Preview button when
  `enabled[<entity_type>][<bundle>]` is set **and** the current user passes the entity access check
  (see [api/access-and-events.md](../api/access-and-events.md)).
- The `update_10001` hook migrated an older flat structure into `enabled` — no action needed on fresh
  installs.

## Behaviour once enabled

- Editing an enabled entity shows a **Preview** button next to Save.
- Clicking it stores `$form_state` in the private tempstore (`entity_preview`, key = entity UUID),
  marks the entity `in_preview`, and redirects to
  `/preview/{uuid}/{default_view_mode}` (`preview.entity_preview`).
- The preview page renders the unsaved entity and shows a **PreviewForm** to switch view modes plus a
  "Back to content editing" link.
- Saving the entity runs a cleanup submit handler that deletes the tempstore entry.

No Drush commands or module-specific permissions.
