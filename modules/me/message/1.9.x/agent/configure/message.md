<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure message

## Two entity types

| Entity type id | Kind | Storage | Purpose |
|---|---|---|---|
| `message_template` | config entity (bundle of `message`) | `message.template.<id>` | reusable templated text + settings |
| `message` | content entity | table `message` / `message_field_data` | one logged instance of a template |

`message_template` config prefix is `template`, so the exported config file/name is
`message.template.<id>` (e.g. `message.template.node_created`). The message content entity's
bundle key is `template` (its bundle == the template id).

## Admin UI & routes

- `/admin/config/message` — settings hub (route `message.main_settings`, the module's `configure`).
- `/admin/config/message/message` — global settings form (route `message.settings`): purge on/off + methods, and `delete_on_entity_delete`.
- `/admin/structure/message` — list message templates (route `message.overview_templates`).
- `/admin/structure/message/template/add` — add a template (route `message.template_add`).
- `/admin/structure/message/manage/{message_template}` — edit; `.../delete/{message_template}` — delete.
- Field UI / Manage display for a template hangs off `entity.message_template.edit_form`.

All template routes require the **`administer message templates`** permission (also the
config entity `admin_permission`). Message content routes use **`administer messages`**.
Permissions: `administer message templates`, `administer messages`, `overview messages`.

## Message template config entity

`config_export` keys: `template`, `label`, `langcode`, `description`, `text`, `settings`, `status`.

`text` is a **sequence of partials**, each a text_format value:

```yaml
# message.template.node_created.yml
langcode: en
status: true
dependencies:
  config:
    - filter.format.full_html
template: node_created
label: 'Node created'
description: 'Logged when a node is created'
text:
  -
    value: '<p>[message:author:name] created [node:title].</p>'
    format: full_html
  -
    value: '<p>Read it here: [node:url]</p>'
    format: full_html
settings:
  'token options':
    clear: false
    'token replace': true
```

- Each `text` item is one **partial** (`{ value, format }`); cardinality is unlimited. Partials show as separate rows on the template's *Manage display* page and can be reordered / hidden per view mode, or rendered individually (delta) via Views.
- `settings.'token options'.'token replace'` must be `true` for `[...]` tokens to be replaced at render; `clear` decides whether unmatched tokens are blanked.
- Referencing a text `format` creates a config dependency on that filter format.

## Purge / auto-delete settings

Global (`message.settings`, also editable via `drush config:set`):

```yaml
purge_enable: true          # master switch, evaluated on cron
purge_methods: {}           # keyed by plugin id: days, quota (see plugins/purge.md)
delete_on_entity_delete:    # delete messages that reference one of these entity types
  comment: comment
  node: node
  taxonomy_term: taxonomy_term
  user: user
```

A template can **override** the global purge config with its own `settings.purge_override: true`
+ `settings.purge_methods`. Purging runs from cron via the `message.purge_orchestrator` service.

## Quick drush recipes

```bash
# Read a template / global settings
drush config:get message.template.node_created
drush config:get message.settings

# Turn global purging on and cap age via the days method (see plugins/purge.md for shape)
drush config:set message.settings purge_enable true -y

# List existing templates
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("message_template")->loadMultiple() as $t) { print $t->id()."\n"; }'
```

Prefer the API (`api/message.md`) over hand-writing `text`/`settings` YAML when you need to
create a template or a message in code — it validates the partial structure for you.
