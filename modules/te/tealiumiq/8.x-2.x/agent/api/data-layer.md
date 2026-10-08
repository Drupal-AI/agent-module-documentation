<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data-layer API

## Services
| Service id | Class | Role |
|---|---|---|
| `tealiumiq.tealiumiq` | `Service\Tealiumiq` | Orchestrator: composes loader URLs, assembles + JSON-encodes the data layer. |
| `tealiumiq.udo` | `Service\Udo` | Holds the `utag_data` namespace + properties array (the data layer). |
| `tealiumiq.helper` | `Service\Helper` | Reads entity fields, token replacement, tag/group plugin sorting, route entity resolution. |
| `tealiumiq.token` | `Service\TealiumiqToken` | Wraps core `token.replace`; provides the token-browser form element. |
| `plugin.manager.tealiumiq.tag` | `Service\TagPluginManager` | `@TealiumiqTag` plugin manager. |
| `plugin.manager.tealiumiq.group` | `Service\GroupPluginManager` | `@TealiumiqGroup` plugin manager. |

## Build pipeline
`Tealiumiq::setUdoPropertiesFromRoute()` → `setProperties(array $properties, ?ContentEntityInterface)`:
1. If `defaults_everywhere`, merge `getDefaultTagValues()` (from `tealiumiq.defaults`) under the tags
   (`defer_fields` flips whether field tags go before or after).
2. Dispatch **`AlterUdoPropertiesEvent`** (`tealiumiq.udo.alterproperties`) — subscribers may add/replace
   properties (the `tealiumiq_context` submodule injects Context reactions here).
3. `Helper::generateRawElements()` — for each tag: instantiate the `@TealiumiqTag` plugin, `setValue`,
   `processTokens()`, then `output()` (builds `{#tag, #attributes:{name, content}}`). Tags without a
   matching plugin are emitted as arbitrary name/content pairs.
4. `Helper::tokenisedTags()` flattens to `{key: content}`.
5. Dispatch **`FinalAlterUdoPropertiesEvent`** (`tealiumiq.udo.finalalterproperties`) — last-chance
   rename/reshape (e.g. `page_name` → `pageName`).
6. `Udo::setProperties()` stores the result.

`getProperties()` returns the array; `getPropertiesJson()` returns JSON (`Json::encode` unless
`json_encoded == 'php'`).

### Token handling
`Helper::processTokens()` = `PlainTextOutput::renderFromHtml(htmlspecialchars_decode($token->replace(...)))`.
Values are resolved against the route entity (`{entity_type: $entity}`) in the current content language
and **reduced to plain text** (HTML tags stripped). `TealiumiqToken::replace()` also collapses
double slashes left by empty tokens and passes `clear => TRUE`.

## Subscribing to alter the data layer
```php
// my_module.services.yml → tags: [{ name: event_subscriber }]
use Drupal\tealiumiq\Event\AlterUdoPropertiesEvent;
public static function getSubscribedEvents() {
  return [AlterUdoPropertiesEvent::UDO_ALTER_PROPERTIES => 'onAlter'];
}
public function onAlter(AlterUdoPropertiesEvent $event) {
  $props = $event->getProperties();
  $props['custom_var'] = '[current-page:title]'; // tokens still resolved downstream
  $event->setProperties($props);
}
```
`FinalAlterUdoPropertiesEvent::FINAL_UDO_ALTER_PROPERTIES` fires after tokenization (values are final
strings). Stub example subscribers ship in `src/EventSubscriber/` (commented-out bodies).

## Per-entity field
- `hook_entity_base_field_info` adds a computed, translatable `tealiumiq` **map** base field
  (`Plugin\Field\TealiumiqEntityFieldItemList`) to content entities with a base table + canonical link
  (except `comment`). This is for REST normalization (`src/Normalizer/*`), not editing.
- Editable values: add the `tealiumiq` **FieldType** ("Tealium tags") via Field UI. Widget
  `tealiumiq_widget` renders `Tealiumiq::form()` and serializes `{tag_id: value}` into one text column
  (`preg`/`serialize`); read back with `unserialize($value, ['allowed_classes' => FALSE])`. Formatter
  `tealiumiq_formatter` outputs nothing (data goes to the data layer, not the entity display).

## Adding a data-layer variable (plugin)
```php
namespace Drupal\my_module\Plugin\tealium\Tag;
use Drupal\tealiumiq\Plugin\tealium\Tag\TagBase;
/**
 * @TealiumiqTag(
 *   id = "product_id", label = @Translation("Product ID"), name = "product_id",
 *   group = "page", weight = 5, type = "label", secure = FALSE, multiple = FALSE
 * )
 */
class ProductId extends TagBase {}
```
Groups are `@TealiumiqGroup` plugins (`id`, `label`, `description`, `weight`); shipped group `page`.

## Public entry points on `Tealiumiq`
`getAccount()`, `getProfile()`, `getEnvironment()`, `getUtagBaseUrl()`, `getUtagUrl()`,
`getUtagSyncUrl()`, `getAsync()`, `getProperties()`, `getPropertiesJson()`,
`setUdoPropertiesFromRoute()`, `setUdoPropertiesFromEntity(ContentEntityInterface)`,
`setProperties(array, ?ContentEntityInterface)`, `getDefaultTagValues()`,
`form(values, element, tokenTypes, includedGroups, includedTags)`.
