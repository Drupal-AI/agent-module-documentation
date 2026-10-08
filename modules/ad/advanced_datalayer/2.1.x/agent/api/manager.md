# Services & how the dataLayer is generated

## Services

| Service | Class | Role |
|---|---|---|
| `advanced_datalayer.manager` | `AdvancedDatalayerManager` | Collects, sorts, token-resolves and renders datalayer tags. |
| `advanced_datalayer.token` | `AdvancedDatalayerToken` | Token replacement helper (wraps `token` + `token.entity_mapper`). |
| `plugin.manager.advanced_datalayer.tag` | `AdvancedDatalayerTagPluginManager` | Discovers `@AdvancedDatalayerTag` plugins. |
| `plugin.manager.advanced_datalayer.group` | `AdvancedDatalayerGroupPluginManager` | Discovers `@AdvancedDatalayerGroup` plugins. |

Useful `AdvancedDatalayerManager` methods:

- `tagsFromEntity($entity)` / `tagsFromEntityWithDefaults($entity)` — tags for an entity.
- `defaultTagsFromEntity($entity)` / `getEntityDefaultDatalayerTags($entity)` — context defaults.
- `getGlobalDatalayerTags()` / `getSpecialDatalayerTags()` — global + special (403/404/login…) tags.
- `sortedGroups()` / `sortedTags()` / `sortedGroupsWithTags()` — ordered plugin structures.
- `generateElements(array $tags, $entity = NULL)` / `generateRawElements(...)` — resolve tokens
  (per-language) and produce the final `tag_id => value` array.
- `form(...)` — builds the tag-value form used by the defaults edit forms.

## How the dataLayer reaches the page

`advanced_datalayer_page_attachments()` (`hook_page_attachments`):

1. Returns early unless `advanced_datalayer_is_current_route_supported()`.
2. `advanced_datalayer_get_tags_from_route()` gathers global + page-context + entity tags and
   fires `hook_advanced_datalayer_alter()`.
3. Fires `hook_advanced_datalayer_attachments_alter()` on the resolved tags.
4. Attaches two head scripts:
   ```js
   var dataLayer_tags = { /* resolved tags */ };            // weight -100
   window.dataLayer = window.dataLayer || []; window.dataLayer.push(dataLayer_tags);  // weight -90
   ```

So the module targets GTM's `window.dataLayer`. Some values (e.g. device type, `gaClientID`)
are intended to be finalized client-side.

## Tokens

Tag values are strings containing tokens resolved by `advanced_datalayer.token` against the
current route entity (keyed by entity type). Non-translatable tags resolve in the site default
language; translatable tags resolve in the current content language
(`generateRawElements()` switches the config override language accordingly).
