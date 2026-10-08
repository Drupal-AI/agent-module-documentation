<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views handlers + the weights sync table

## The two Views handlers

`hook_views_data()` (`views_moderation_state_weights.views.inc`) iterates all entity types that
`content_moderation.moderation_information` reports as **moderated**, and on each one's data table
**and** revision data table adds a `moderation_state_weight` entry titled **"Moderation state
weight"** with:

| Kind | Handler plugin id | Class |
|---|---|---|
| Views field | `moderation_state_weight_field` | `ModerationStateWeightField` (`@ViewsField`) |
| Views sort | `moderation_state_weight_sort` | `ModerationStateWeightSort` (`@ViewsSort`) |

Both are thin — they extend core `FieldPluginBase` / `SortPluginBase` and share
`ModerationStateWeightJoinViewsHandlerTrait`, which builds the joins:
base table → `content_moderation_state` revision data table (on revision id / entity id / type /
langcode) → `views_moderation_state_weights` (on `moderation_state` + `workflow`). So the sort
orders by the real numeric weight, the field renders it.

**Availability:** the handler only shows up in the Views UI for entity types that have a
content_moderation workflow assigned. If your view's entity type is not moderated, the
"Moderation state weight" field/sort will not be listed.

## Add it to a view

Views UI: on a view of a moderated entity (e.g. Content), add a **Field** or **Sort criteria**
and pick **Moderation state weight**. In a view's config it looks like:

```yaml
display:
  default:
    display_options:
      sorts:
        moderation_state_weight:
          id: moderation_state_weight
          table: node_field_data
          field: moderation_state_weight
          plugin_id: moderation_state_weight_sort
          order: ASC
      fields:
        moderation_state_weight:
          id: moderation_state_weight
          table: node_field_data
          field: moderation_state_weight
          plugin_id: moderation_state_weight_field
```

Add the same entry under `fields:` with `plugin_id: moderation_state_weight_field` to display it.

## The internal weights table

Table `views_moderation_state_weights` — columns `workflow` (varchar), `moderation_state`
(varchar), `weight` (int); primary key `(workflow, moderation_state)`. Maintained by
`ModerationStateWeightHandler` (class-resolved, `@internal`):

- `hook_install()` inserts weights for every existing `content_moderation` workflow.
- `views_moderation_state_weights_workflow_insert/update/delete()` keep it in sync — on update it
  deletes then re-inserts the workflow's rows inside a transaction.

You never write this table by hand; it is derived from each state's `weight()` in workflow config.
Inspect it with:

```bash
drush sqlq "SELECT workflow, moderation_state, weight FROM views_moderation_state_weights"
```

No services, permissions, config, or Drush commands are provided by this module.
