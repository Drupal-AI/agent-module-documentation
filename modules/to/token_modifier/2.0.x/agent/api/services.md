<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: plugin manager service, interface, and base class

## Service `plugin.manager.token_modifier`

Defined in `token_modifier.services.yml`:

```yaml
plugin.manager.token_modifier:
  class: Drupal\token_modifier\Plugin\TokenModifierPluginManager
  parent: default_plugin_manager
```

`TokenModifierPluginManager extends DefaultPluginManager`, configured as:

- Plugin subdirectory: `Plugin/token_modifier`
- Plugin interface: `Drupal\token_modifier\Plugin\TokenModifierInterface`
- Annotation: `Drupal\token_modifier\Annotation\TokenModifier`
- Alter hook id: `token_modifier_info` (→ `hook_token_modifier_info_alter()`)
- Cache: `token_modifier_plugins`

Extra method beyond the standard manager:

```php
/** @return \Drupal\token_modifier\Plugin\TokenModifierInterface[] */
public function getModifiers(): array;   // instantiates every discovered modifier
```

Typical use — resolve and transform in code:

```php
$manager = \Drupal::service('plugin.manager.token_modifier');
/** @var \Drupal\token_modifier\Plugin\TokenModifierInterface $plugin */
$plugin = $manager->createInstance('uppercase');
$out = $plugin->transform('[node:title]', ['node' => $node]);   // → UPPERCASED TITLE
```

`createInstance()` with an unknown id throws `\Drupal\Component\Plugin\Exception\PluginNotFoundException`.

## Interface `TokenModifierInterface`

`Drupal\token_modifier\Plugin\TokenModifierInterface extends PluginInspectionInterface`.

```php
public function transform(string $text, array $data = [], array $options = []);
```

- `$text` — a string containing the replaceable token, passed by `hook_tokens()` as `"[$inner]"`.
- `$data` / `$options` — the keyed objects and token options for the current context, forwarded
  from the outer token so the inner token resolves the same way.
- Returns the transformed value (`mixed`; string in practice).

## Base class `TokenModifierPluginBase`

`abstract class TokenModifierPluginBase extends PluginBase implements TokenModifierInterface,
ContainerFactoryPluginInterface`.

- Injects the core token service `Drupal\Core\Utility\Token` as `protected $this->token`
  (via `create()` → `$container->get('token')`).
- Subclasses implement only `transform()`; they call `$this->token->replace($text, $data, $options)`
  to resolve the inner token, then apply their operation.

## Annotation `@TokenModifier`

`Drupal\token_modifier\Annotation\TokenModifier extends Plugin`. Properties:

| Property | Type | Purpose |
|---|---|---|
| `id` | string | the modifier id used in the token (`[token-modifier:{id}:…]`) |
| `name` | `@Translation` | label shown in the Token browser |
| `description` | `@Translation` | description shown in the Token browser |

See [plugins/token-modifier.md](../plugins/token-modifier.md) for a full modifier example.
