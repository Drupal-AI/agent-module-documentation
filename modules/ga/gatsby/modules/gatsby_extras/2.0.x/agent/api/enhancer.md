# Gatsby JSON:API Extras — Alias link enhancer

## Plugin `alias_link`

`Drupal\gatsby_extras\Plugin\jsonapi\FieldEnhancer\AliasLinkEnhancer`, a
`jsonapi_extras` `@ResourceFieldEnhancer` (extends `ResourceFieldEnhancerBase`). Attach it to a **link
field** in a JSON:API Extras resource config (Admin: *Configuration > Web services > JSON:API Extras*,
or via `jsonapi_resource_config` config) — pick "Alias for link (link field only)".

- **Output** (`doUndoTransform`, Drupal -> JSON:API): for a value whose `uri` matches
  `entity:{type}/{id}`, loads the target and adds:
  - `uri_uuid` = `entity:{type}/{bundle}/{uuid}`
  - `uri_alias` = `$entity->toUrl()->toString()` (the path alias)
  If the target entity is missing, the whole value is blanked (`uri`, `uri_uuid`, `uri_alias`, `title`,
  `options` emptied).
- **Input** (`doTransform`, JSON:API -> Drupal): for a value whose `uri` matches
  `entity:{type}/{bundle}/{uuid}`, loads by UUID and rewrites `uri_uuid` to `entity:{type}/{id}`; if no
  entity matches the UUID the value is emptied.
- `getOutputJsonSchema()` returns `{ type: object }`.

## Exposing menus

Ships `config/optional/jsonapi_extras.jsonapi_resource_config.menu_link_content--menu_link_content.yml`
(installed if `jsonapi_extras` is present) which applies the enhancer so the menu link `parent`/`link`
resolve for Gatsby — a workaround for jsonapi_extras issue 2982133. To read the endpoint, the Gatsby
account needs the core **"Administer menus and menu items"** permission (supply it via `basic_auth` or
the `key_auth` module).
