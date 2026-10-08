<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Derived ECA actions & conditions

ECA Tamper does not define a new plugin *type*. It **derives** ECA plugins from the existing
Tamper plugin manager (`plugin.manager.tamper`). For every Tamper plugin you get:

- **Action**: id `eca_tamper:<tamper_id>` — base plugin `eca_tamper`
  (`src/Plugin/Action/Tamper.php` + `TamperDeriver`), an ECA `ConfigurableActionBase`.
- **Condition**: id `eca_tamper_condition:<tamper_id>` — base plugin `eca_tamper_condition`
  (`src/Plugin/ECA/Condition/Tamper.php` + `TamperDeriver`), extends ECA
  `StringComparisonBase`. Only derived when the Tamper plugin's category is one of
  **Text, Date/time, Number, Other**.

Plugins whose Tamper definition has `itemUsage === 'required'` are skipped by both derivers.
Each derivative keeps the source Tamper id in its definition as `original_id`.

## Action config keys

`Tamper::defaultConfiguration()` = `['eca_data' => '', 'eca_token_name' => '']` **plus the
wrapped Tamper plugin's own default configuration**.

| Key | Meaning |
|---|---|
| `eca_data` | The value to tamper. Token-aware (`[node:title]`, prior-action tokens, literals). |
| `eca_token_name` | Name of the token the tampered result is written to (for later actions). |
| *(tamper settings)* | Whatever the wrapped Tamper plugin exposes (e.g. `trim`'s side/character, `find_replace`'s find/replace, `encode`'s mode). |

Runtime (`execute()` → `TamperTrait::doTamper('eca_data', 'eca_token_name')`):
token-replaces the config, instantiates the Tamper plugin via
`original_id`, runs `TamperInterface::tamper($data)`, and calls
`tokenService->addTokenData($eca_token_name, $result)`. `SkipTamper*`/`TamperException` are
caught and leave the data unchanged.

## Condition config keys

`Tamper (condition)::defaultConfiguration()` = `['left' => '', 'right' => '']` plus the
Tamper plugin defaults, plus the `StringComparisonBase` keys `operator`, `type`, `case`,
`negate`.

- `left` — data to tamper (token-aware); the tampered value is the comparison's left side.
- `right` — value to compare against (token-aware).
- `operator` / `type` — ECA comparison operator and type (validated by
  `StringComparisonBase::getAllValidOperators/Types`).
- `case` — case-sensitive comparison (bool); `negate` — invert the condition (bool).

## Referencing them in an ECA model (`eca` config entity)

An action element in an `eca.eca.<id>` config entity looks like:

```yaml
actions:
  act_trim:
    plugin: 'eca_tamper:trim'      # eca_tamper: + tamper plugin id
    label: 'Trim the title'
    configuration:
      eca_data: '[node:title]'
      eca_token_name: 'clean_title'
      # ...plus that Tamper plugin's own settings (e.g. side, character)...
    successors: {}
```

Programmatically (drush php:eval), an action's plugin id is what identifies eca_tamper usage:

```php
$eca = \Drupal::entityTypeManager()->getStorage('eca')->load('my_model');
$eca->get('actions')['act_trim']['plugin'];   // => 'eca_tamper:trim'
```

Conditions are referenced the same way under the `conditions:` key with plugin
`eca_tamper_condition:<tamper_id>`.

## Config schema

`hook_config_schema_info_alter()` (`src/Hook/ConfigSchemaHooks.php`) grafts each Tamper
plugin's schema onto `action.configuration.eca_tamper:*` and
`eca.condition.plugin.eca_tamper_condition:*` (see `config/schema/eca_tamper.schema.yml`), so
the wrapped plugin's settings validate as part of the ECA model config. The action schema
adds `eca_data` + `eca_token_name`; the condition schema adds `left`/`right`/`operator`/
`type`/`case`/`negate`.
