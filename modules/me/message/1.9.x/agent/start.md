# message — agent start

General logging utility. Two entity types: **`message_template`** (config entity, bundle,
stored as `message.template.<id>`) holds the templated text; **`message`** (content entity,
`base_table` = `message`) is one logged instance of a template. Template text is a sequence
of *partials* (formatted-text values) that can contain Drupal **tokens** and per-instance
**arguments**. Config UI at `/admin/config/message` and `/admin/structure/message`.

- Create/configure templates, purge settings, global config keys → [configure/message.md](configure/message.md)
- Create templates & messages in code, render text, set arguments → [api/message.md](api/message.md)
- Add a custom auto-purge method (`message_purge` plugin type) → [plugins/purge.md](plugins/purge.md)
- Alter message rendering & default templates via hooks → [hooks/message.md](hooks/message.md)

Key facts: config prefix `template` → config name `message.template.<id>`; message bundle key
is `template`; `admin_permission` = `administer message templates` (templates) /
`administer messages` (messages). No Drush commands ship with the module.
