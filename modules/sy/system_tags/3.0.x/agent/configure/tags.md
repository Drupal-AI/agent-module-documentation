# System Tags — tags, fields, special pages, condition

## The `system_tag` config entity

- Config entity type `system_tag` (`Drupal\system_tags\Entity\SystemTag`). Collection route
  `entity.system_tag.collection` → `/admin/structure/system_tags` (the `configure` route).
  Add/edit/delete forms provided; list builder + HTML route provider.
- A tag is just an `id` (machine name) + `label`. Ships three in `config/install`: `homepage`,
  `access_denied`, `page_not_found` (constants in `Config\SystemTagDefinitions`).
- Access handler `SystemTagAccessControlHandler`: `view` needs `view system tags`; all other ops need
  `administer system tags`.

## Marking content with a tag

1. Add an `entity_reference` field (target type **System Tag** / `system_tag`) to any bundle, e.g.
   `field_page_system_tag` on `node.page`.
2. Set the tag on the entity. `SystemTagHelper::getFieldMap()` discovers every field storage whose
   `target_type` is `system_tag`, so any such field on any entity type is picked up automatically.

## Special pages via config override

`SystemPageConfigOverrider` (service `system_tags.system_page_config_overrider`, tagged
`config.factory.override`, priority 5) overrides `system.site` when these node tags exist (resolved by
the `node` finder, one node each):

- `access_denied` → `system.site:page.403`
- `homepage` → `system.site:page.front`
- `page_not_found` → `system.site:page.404`

Each becomes `'/' . $node->toUrl()->getInternalPath()`. So tagging a node `homepage` makes it the front
page with no manual front-page path configuration. (Only nodes are used for these three overrides.)

## Block visibility condition

Condition plugin `system_tags` (`Plugin/Condition/SystemTags`): configure a set of tags; it evaluates
TRUE when a fieldable entity in the current route match has a `system_tag` reference field whose value
intersects the selected tags. With no tags selected and not negated it returns TRUE. Config schema
`condition.plugin.system_tags` stores `system_tags` as a sequence of strings. Use it in block
visibility to show a block only on pages tagged X.

## Config schema

`system_tags.system_tag.*` (config entity: `id`, `label`, `uuid`) and
`condition.plugin.system_tags`. No general settings object — the module has no settings form.
