# Plugin type: `mentions_type`

A mentions type says *what* can be mentioned by a marker: which entity type, how candidates are
queried from the typed string, and what token fields each suggestion carries.

- Manager service: `plugin.manager.mentions_type` (`MentionsType\MentionsTypeManager`, extends `DefaultPluginManager`).
- Annotation: `@MentionsType` (`Drupal\ckeditor_mentions\Annotation\MentionsType`) — keys: `id`, `label`, `entity_type`.
- Interface: `MentionsType\MentionsTypeInterface`; base class: `MentionsType\MentionsTypeBase`.
- Discovery namespace: `Plugin/MentionsType`. Cache key `mentions_type`. Alter hook: `hook_mentions_type_plugin_info_alter(&$definitions)`.
- `MentionsTypeManager::getAllMentionsTypes()` returns `[id => label]` (sorted) — used to build the config form and to iterate types.

## Built-in types
| id | class | entity_type | Query (`getQuery()`) | Notes |
|---|---|---|---|---|
| `user` | `Plugin\MentionsType\User` | `user` | `name` CONTAINS OR `mail` CONTAINS match | `buildTokens()` adds `user_name`, `email`, `avatar` (via image style `mentions_icon`, else `img/placeholder.png`) |
| `node` | `Plugin\MentionsType\Node` | `node` | `title` CONTAINS match AND `status = PUBLISHED` | bundle-able → supports `filterByBundle` |
| `realname` | `ckeditor_mentions_realname\…\Realname` (submodule) | `user` | joins `realname` table, `realname` LIKE match, `status = 1` | extends `User`; needs the realname module |

## Request flow (`Controller\CKMentionsController::getMatch`)
1. Loads the `editor` entity by `{editor_id}`; 404 if missing.
2. Reads `settings.plugins.ckeditor_mentions_mentions.plugins.{plugin_id}`; 404 if absent or not `enable`d.
3. `createInstance($plugin_id, ['match' => $match] + $pluginConfig)`.
4. Returns `array_values($plugin->buildResponse())` as JSON.

## `MentionsTypeBase` — what a subclass gets / must provide
- **Must implement** `getQuery(): AlterableInterface` — return an entity query (or DB select) of matching ids.
- `buildResponse()`: runs `buildQuery()` → executes → `loadMultiple()` → `buildTokens()` → dispatches the [suggestion event](../events/events.md) → returns suggestions.
- `postProcessQuery()` (called for every plugin): applies `filterByBundle` (`condition('type', …, 'IN')`), `dropdownLimit` (`range()`), adds tag `ckeditor_mentions_{plugin_id}` and metadata `plugin` for `hook_query_TAG_alter`.
- `buildTokens(array $entities)`: default per-suggestion fields — `entity_type`, `entity_id`, `entity_uuid`, `label`, `search_label`, `mention_uuid` (generated), `url` (canonical, or alias when `useRewrittenUrl`). Then invokes `hook_ckeditor_mentions_build_token_alter` and `hook_ckeditor_mentions_build_tokens_alter` (see [hooks](../hooks/hooks.md)).
- `getMatch()`, `isBundable()`, `defaultConfiguration()` (`match`, `filterByBundle`, `dropdownLimit`, `useRewrittenUrl`).

## Add a custom mentions type
```php
namespace Drupal\my_module\Plugin\MentionsType;

use Drupal\ckeditor_mentions\MentionsType\MentionsTypeBase;
use Drupal\Core\Database\Query\AlterableInterface;

/**
 * @MentionsType(
 *   id = "term",
 *   label = @Translation("Taxonomy term"),
 *   entity_type = "taxonomy_term"
 * )
 */
class Term extends MentionsTypeBase {

  protected function getQuery(): AlterableInterface {
    return $this->entityManager
      ->getStorage($this->getPluginDefinition()['entity_type'])
      ->getQuery()
      ->accessCheck()
      ->condition('name', $this->getMatch(), 'CONTAINS');
  }
}
```
The new type then appears in every CKEditor 5 format's Mentions settings; enable and give it a
unique marker. Override `buildTokens()` if you need extra fields on each suggestion. Note that
`getQuery()` decides which records and which of the caller's rights are honored — filter by
`status` and use a meaningful `accessCheck()`/query-tag policy for the entity type you expose.
