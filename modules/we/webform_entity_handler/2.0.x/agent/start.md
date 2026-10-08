# Webform Entity Handler — agent index

Provides ONE Webform handler plugin, id `webform_entity_handler`
(`Drupal\webform_entity_handler\Plugin\WebformHandler\WebformEntityHandler`), that creates or
updates a content entity from a webform submission. No configure route, no permissions, no Drush.
Persistent state lives in the **webform config entity** `webform.webform.<id>` under
`handlers.<handler_id>` (`id: webform_entity_handler`, `settings: {...}`).

- **The handler: settings keys, mapping syntax, and what postSave() does** →
  [plugins/webform-entity-handler.md](plugins/webform-entity-handler.md)
- **Add/configure the handler on a webform (UI + config + drush)** →
  [configure/add-handler.md](configure/add-handler.md)

Key facts:
- Requires `webform` (`^5.6||^6.0`); suggests `token`. Tokens are supported in every mapped value.
- Handler cardinality is UNLIMITED — a webform can carry several Entity handlers.
- Config schema key: `webform.handler.webform_entity_handler`.
