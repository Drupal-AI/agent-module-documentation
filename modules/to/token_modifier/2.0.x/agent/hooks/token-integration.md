<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Token system integration (`token_modifier.module`)

The module hooks into core's token pipeline; there is no route, form, or config.

## `hook_token_info()` — `token_modifier_token_info()`

- Registers the token **type** `token-modifier` (label "Token modifier").
- Iterates `plugin.manager.token_modifier`'s `getModifiers()` and adds one token under
  `types['token-modifier'] → tokens['token-modifier'][{plugin-id}]` per modifier, using the
  plugin's `name` / `description` and `dynamic => TRUE`.
- Effect: every discovered modifier shows up in the Token browser under the "Token modifier" group.

## `hook_tokens()` — `token_modifier_tokens()`

Runs only when `$type === 'token-modifier'`. For each requested token `$name`:

```php
$parts    = explode(':', $name);
$modifier = array_shift($parts);          // first segment = modifier plugin id
$token    = implode(':', $parts);         // remainder = the inner token
if ($plugin = \Drupal::service('plugin.manager.token_modifier')->createInstance($modifier)) {
  $return[$original] = $plugin->transform("[$token]", $data, $options);
}
```

So the whole context (`$data`, `$options`) received by the outer token is forwarded to the plugin.

## Runtime trace

1. A token-processed string contains `[token-modifier:{modifier}:{inner}]`.
2. Core `Token::replace()` groups tokens by type and calls
   `token_modifier_tokens('token-modifier', …, $data, $options, $bubbleable_metadata)`.
3. The hook splits off the modifier id, rebuilds the inner token string, instantiates the plugin,
   and calls `transform("[inner]", $data, $options)`.
4. The plugin calls `$this->token->replace("[inner]", $data, $options)` (core token service) to
   resolve the inner token — this re-entry is what makes **chaining** work (an inner
   `[token-modifier:…]` is replaced the same way) — then applies its PHP string operation.
5. `length` additionally strips the surrounding `[ ]`, pops the leading integer as the max length,
   and `substr()`s the resolved value.

## Alter hook — `hook_token_modifier_info_alter()`

The plugin manager calls `alterInfo('token_modifier_info')`, so core's `alter()` invokes
`hook_token_modifier_info_alter()`, letting modules alter the discovered modifier definitions
before they are cached:

```php
/**
 * Implements hook_token_modifier_info_alter().
 */
function mymodule_token_modifier_info_alter(array &$info) {
  // $info is keyed by modifier id; each value is the plugin definition array.
  unset($info['strip-tags']);            // e.g. remove a modifier
}
```

(Cache id `token_modifier_plugins`; clear caches after changing plugin definitions.)
