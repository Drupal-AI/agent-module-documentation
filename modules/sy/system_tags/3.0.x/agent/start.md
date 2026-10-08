# System Tags — agent index

Tag entities with a stable machine name (`system_tag` config entity) and resolve "the entity tagged X"
from code/Twig/tokens/conditions without hard-coding IDs. Three special tags (`homepage`,
`access_denied`, `page_not_found`) override `system.site` front/403/404. Depends on `field`,
`path_alias`. No Drush.

- **Tags config entity, adding the reference field, the 3 special tags + `system.site` override, the
  block-visibility condition** → [configure/tags.md](configure/tags.md)
- **`SystemTagFinder` plugin type — add a finder for a new entity type** →
  [plugins/system-tag-finder.md](plugins/system-tag-finder.md)
- **Resolve tags programmatically: finder manager/service, `system_tag_url()` Twig fn, tokens** →
  [api/tokens-and-twig.md](api/tokens-and-twig.md)
- **Permissions and system-tag field access** → [permissions/permissions.md](permissions/permissions.md)

Submodule (not documented separately here): `system_tags_theme` — adds
`node--system-tag--<tag>` theme suggestions and body classes for the current node's tags.

Key facts:
- Config entity `system_tag`; collection `entity.system_tag.collection` → `/admin/structure/system_tags`.
- Finder manager `plugin.manager.system_tags.system_tag_finder_manager`; built-in finders for `node`
  and `block_content`. Finder queries use `accessCheck()` + published-status filter + language fallback.
- Overrider `SystemPageConfigOverrider` (service `system_tags.system_page_config_overrider`,
  `config.factory.override`).
