<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookie condition plugin (`cookie`)

`src/Plugin/Condition/CookieCondition.php` — the module's only class.

## Install / enable

- `drush en cookie_block` (or via Extend). No dependencies, no config, no permissions. Enabling
  makes the condition available; nothing else changes.

## Plugin definition

- Annotation `@Condition( id = "cookie", label = @Translation("Cookie") )`.
- `class CookieCondition extends ConditionPluginBase implements ContainerFactoryPluginInterface`,
  uses `StringTranslationTrait`.
- Condition plugins are discovered by core's condition system; this one shows up in the
  **Visibility** section of any block's configuration form (and anywhere else the condition
  plugin manager is used, e.g. custom code / other modules that build condition UIs).

## Dependency injection

- `create()` gets `request_stack` from the container and stores
  `$container->get('request_stack')->getCurrentRequest()` as `$this->request`. No other services.

## Configuration keys

- `defaultConfiguration()` returns core's defaults plus `cookie_id => ''` and `cookie_value => ''`.
- `buildConfigurationForm()` adds two `textfield`s:
  - `cookie_id` — *"Cookie ID"*, described as "The id for the cookie" (i.e. the cookie name).
  - `cookie_value` — *"Cookie value"*, "The value for the cookie".
  - It then calls `parent::buildConfigurationForm()`, which adds the standard **Negate the
    condition** checkbox.
- `submitConfigurationForm()` copies both form values into `$this->configuration`.
- These values are stored as part of the host block's `visibility` settings — admin/site-builder
  authored config.

## Evaluation logic

`evaluate()`:

```
$systemCookie = $this->request->cookies->get($this->configuration['cookie_id']);
if (!empty($systemCookie)) {
  return $systemCookie == $this->configuration['cookie_value'];  // loose ==
}
return FALSE;
```

- Returns TRUE only when the request carries the named cookie AND its value **loosely** equals the
  configured `cookie_value`. An empty/missing cookie → FALSE. Core wraps the result with the
  *Negate* flag, so a negated condition is TRUE when the cookie is absent or does not match.
- Comparison is PHP loose `==` — e.g. `"0"`, `""` behave per PHP's loose rules; if exactness ever
  matters, be aware two loosely-equal strings match.

## Summary label

- `summary()` returns a translated sentence — "The cookie @cookie_id is @cookie_value." (or "…is
  not…" when negated) — with `@`-placeholders, so the admin-entered values are **escaped** by the
  translation/render layer, not output raw.

## How to use it on a block

1. Go to **Structure → Block layout**, place or configure a block.
2. In the block form's **Visibility** vertical tab, open **Cookie**.
3. Enter the **Cookie ID** (cookie name, e.g. `cookie_agreed`) and the **Cookie value** (e.g. `1`),
   optionally tick **Negate the condition**, and save.
4. The block then renders only when the visitor's browser sends that cookie with the matching value
   (or, negated, when it does not).

## Caveats

- **Cookies are client-controlled.** Any visitor can create, delete, or forge the cookie in their
  browser, so this condition governs presentation only. Do not use it as the sole control over
  content that must be restricted by authorization — combine real access checks (roles/permissions)
  for anything sensitive.
- No caching contexts are declared by the plugin itself; block visibility caching follows core's
  handling of condition plugins.
