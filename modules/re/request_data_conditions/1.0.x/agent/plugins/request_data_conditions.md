<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The four condition plugins

All four are `@Condition` plugins in `src/Plugin/Condition/` extending the abstract
`BaseCondition` (`ConditionPluginBase` + `ContainerFactoryPluginInterface`). They differ **only** in
which request bag they read, returned by `getDataContext()`:

| Plugin id | Class | Reads (`$this->requestStack->getCurrentRequest()->…`) | Cache context added |
| --- | --- | --- | --- |
| `cookie_values` | `CookieValuesCondition` | `cookies->all()` | `cookies:NAME` per rule |
| `http_headers` | `HttpHeadersCondition` | `headers->all()` | `headers:NAME` per rule |
| `url_query_parameters` | `UrlQueryParametersCondition` | `query->all()` | `url.query_args:NAME` per rule |
| `session_values` | `SessionValuesCondition` | `getSession()->all()` (`[]` if no session) | `session` (once, if any rule) |

`summary()` returns a fixed translated sentence per plugin (no request data is ever echoed). Injected
services: `request_stack`, `current_route_match` (the route match is only used to fix the "Add
another" AJAX URL when the condition is edited on Context's `context.condition_add` route).

## Config shape

Stored in the host entity (block `visibility`, Context `conditions`, etc.) under the plugin id:

```yaml
conditions:
  - { name: 'my_cookie', op: 'equals', value: 'blue' }
  - { name: 'debug',     op: 'set',    value: '' }
require_all_params: true          # AND across rules; false = OR
```

`defaultConfiguration()` seeds `conditions: []` and `require_all_params: TRUE`.

## Matching semantics (`BaseCondition::conditionPasses()`)

The looked-up value is `$context[$name]` (headers/query values may themselves be **arrays** — Symfony
returns header values as arrays; array handling is built in). Operators (constants on `BaseCondition`):

| Operator (`op`) | Label in UI | Passes when |
| --- | --- | --- |
| `equals` | must equal | scalar `== value`; array → `in_array(value, …)` |
| `not_equals` | must not equal | scalar `!= value`; array → not `in_array` |
| `set` | must be set | `isset($context[name])` |
| `not_set` | must not be set | `!isset($context[name])` |
| `empty` | must be set and have no value | set **and** `mb_strlen((string) v) === 0` |
| `not_empty` | must be set and have any value | set **and** `mb_strlen((string) v) > 0` |
| `contains` | must contain | `strstr(v, value)` truthy (any element, if array) |
| `not_contains` | must not contain | set and `strstr` falsy (all elements, if array) |
| `regex` | matches regular expression | `@preg_match('/' . value . '/', v)` (any element, if array) |
| *(unknown)* | — | `FALSE` |

Notes and edge cases:

- `equals` uses loose `==`; `contains`/`not_contains` use `strstr()` (substring, case-sensitive).
- **Regex**: the stored `value` is wrapped as `'/' . value . '/'` at evaluate time — enter the pattern
  **without** leading/trailing slashes (the form says so). `preg_match` errors are suppressed with
  `@`, so an invalid pattern silently fails to match rather than erroring.
- A rule whose **Name** is empty is treated as empty and dropped on submit (`conditionIsEmpty()` /
  `removeEmptyConditions()`).

## `evaluate()` — AND / OR and the empty case

```
if (no rules configured && condition is not negated) return TRUE;   // "no rules" = always show
count passing rules; require_all_params ? (count>0 && passes === count) : passes > 0
```

So an unconfigured condition is a no-op (always TRUE) unless negated. With rules, **Require all**
(`require_all_params`) means every rule must pass (AND); unchecked means any single rule passing is
enough (OR). The condition system's standard **Negate** toggle inverts the final result.

## Calling from code

These are ordinary condition plugins, so instantiate via the condition manager and set config:

```php
/** @var \Drupal\Core\Condition\ConditionManager $cm */
$cm = \Drupal::service('plugin.manager.condition');
$condition = $cm->createInstance('url_query_parameters', [
  'conditions' => [
    ['name' => 'campaign', 'op' => 'equals', 'value' => 'spring'],
  ],
  'require_all_params' => TRUE,
]);
$visible = $condition->execute(); // applies negation; evaluate() is the raw result
```

Remember to fold the condition's cache contexts/tags into whatever render array you gate, so caching
varies per request value.
