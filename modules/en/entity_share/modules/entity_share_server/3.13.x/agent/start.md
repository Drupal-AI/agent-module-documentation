# entity_share_server — agent start

Submodule of **entity_share** (the **server** side). Defines the **`channel`** config entity:
exposes one entity type + bundle + language as an access-controlled JSON:API collection that
remote clients pull from. Admin UI: **Config → Web services → Entity Share → Channels**
(`entity.channel.collection`). Permissions: `administer_channel_entity`,
`entity_share_server_access_channels`. Depends on core JSON:API + `entity_share`. No plugin
types, no Drush.

Full `channel` field list, Drush create/read snippets, and access keys are in the parent doc:
- → [../../../../3.13.x/agent/configure/config-entities.md](../../../../3.13.x/agent/configure/config-entities.md) (see "`channel` (server)")

Quick create:

```bash
drush php:eval '\Drupal::entityTypeManager()->getStorage("channel")->create([
  "id" => "articles_en", "label" => "Articles EN",
  "channel_entity_type" => "node", "channel_bundle" => "article",
  "channel_langcode" => "en",
])->save();'
```

`config_export` keys: `id`, `label`, `channel_entity_type`, `channel_bundle`,
`channel_langcode`, `channel_filters`, `channel_groups`, `channel_sorts`, `channel_searches`,
`channel_maxsize`, `access_by_permission`, `authorized_roles`, `authorized_users`.
