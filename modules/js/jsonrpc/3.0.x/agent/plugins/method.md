# Defining a JSON-RPC method plugin

## Plugin type

- Manager: `plugin.manager.jsonrpc_method` (`Drupal\jsonrpc\Plugin\JsonRpcMethodManager`).
- Discovery: classes in `src/Plugin/jsonrpc/Method/` of any module, annotated with the
  `#[\Drupal\jsonrpc\Attribute\JsonRpcMethod]` attribute (legacy `@JsonRpcMethod` annotation still works).
- Base class: `Drupal\jsonrpc\Plugin\JsonRpcMethodBase` (implements `ExecutableWithParamsInterface`).
  Definition object: `JsonRpcMethodDefinition` (implements `MethodInterface`).

## Attribute parameters (`#[JsonRpcMethod]`)

| Arg | Meaning |
|---|---|
| `id` (string) | Method name used in the RPC `method` field (e.g. `cache.rebuild`). |
| `usage` (TranslatableMarkup) | Human description. |
| `access` (array<string>) | Permissions required to execute; **AND** semantics. **Empty ⇒ allowed to anyone with `use jsonrpc services`** — always set this. |
| `params` (array\|null) | `name => JsonRpcParameterDefinition`. |
| `output` (array\|null) | JSON Schema of the result; also return it from static `outputSchema()`. |
| `responseHeaders` (array) | Headers added to the response (batch: only headers present on all responses survive). |
| `call` (string, optional) | Method to call; defaults to `execute`. |

## Implementing

```php
namespace Drupal\my_module\Plugin\jsonrpc\Method;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\jsonrpc\Attribute\JsonRpcMethod;
use Drupal\jsonrpc\Attribute\JsonRpcParameterDefinition;
use Drupal\jsonrpc\JsonRpcObject\ParameterBag;
use Drupal\jsonrpc\Plugin\JsonRpcMethodBase;

#[JsonRpcMethod(
  id: "my.method",
  usage: new TranslatableMarkup("Does a thing."),
  access: ["administer site configuration"],
  params: [
    'name' => new JsonRpcParameterDefinition('name', ["type" => "string"], NULL, NULL, TRUE),
  ],
)]
class MyMethod extends JsonRpcMethodBase {
  public function execute(ParameterBag $params): array {
    return ['echo' => $params->get('name')];
  }
  public static function outputSchema(): ?array {
    return ['type' => 'object'];
  }
}
```

- `execute(ParameterBag $params)` returns a scalar/array/`Response`/null. Return `outputSchema(): null` for a
  notification-only method.
- Access the raw request in the plugin via `currentRequest()`; the definition via `methodDefinition()`.
- Need a service? Override `create()`/constructor like any container plugin (see `jsonrpc_core` methods).

## `JsonRpcParameterDefinition`

Constructor: `(string $id, ?array $schema = NULL, ?string $factory = NULL, ?TranslatableMarkup $description = NULL,
?bool $required = FALSE)`. Exactly one of `schema` or `factory` is required. `factory` must implement
`ParameterFactoryInterface`.

### Built-in factories

| Factory | Input → value |
|---|---|
| `RawParameterFactory` (default when only `schema` given) | validates against the param's `schema`, passes value through. |
| `EntityParameterFactory` | input `{type, uuid}` → loaded entity (`entityRepository->loadEntityByUuid`); throws `invalidParams` if not found. |
| `PaginationParameterFactory` | input `{limit, offset}` (non-negative ints) → same array; use for paging. |

Write your own by extending `ParameterFactoryBase` (implement `schema()`, `getOutputValidator()`, `doTransform()`).
