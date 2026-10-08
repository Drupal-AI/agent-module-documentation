<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type: `config_event_ignore`

Declares, per config **type**, which changed keys the upgrade tracker should treat as expected
noise and NOT log as a manual override. When a tracked config is saved, `ConfigEventSubscriber`
asks the manager (`plugin.manager.config_event_ignore`) whether the diff can be ignored; if a
plugin matches the config type and all changed keys pass its rules, no upgrade-log entry is
created. Used to suppress churn like Views `cache_metadata`.

- **Discovery:** annotation `@ConfigEventIgnore`, namespace `Plugin/ConfigEventIgnore`.
- **Manager service:** `plugin.manager.config_event_ignore` (class `ConfigEventIgnorePluginManager`).
- **Alter hook:** `hook_config_event_ignore_info_alter()`. **Cache bin:** `config_event_ignore`.
- **Base class:** `Drupal\openy_upgrade_tool\ConfigEventIgnoreBase`.
- **Interface:** `Drupal\openy_upgrade_tool\ConfigEventIgnorePluginInterface`.

## Annotation properties

| Key | Meaning |
|---|---|
| `id` | plugin id |
| `label` | `@Translation` human name |
| `type` | config type this plugin applies to (e.g. `view`, `entity_form_display`, `field_config`) |
| `weight` | when several plugins target the same `type`, the one with the **highest** weight wins (only one is used per type) |

## How rules are evaluated

The manager reduces the saved config's diff to a flat list of dotted key paths
(`getModifiedKeys()`), then calls the plugin. Two escape hatches:

- `fullIgnore()` returns TRUE → every change for this config type is ignored (base default: FALSE).
- `getRules()` returns a list of `['value' => …, 'operator' => …]`. A changed key is ignorable if
  ANY rule matches it; the whole save is ignorable only if EVERY changed key is ignorable.

Operators (constants on `ConfigEventIgnoreBase`):
- `self::REGEXP_OPERATOR` (`'regexp'`) — `value` is a PCRE pattern matched against the key path.
- `self::EQUAL_OPERATOR` (`'equal'`, the default) — `value` must equal the key path exactly.

## Implement one

Create `src/Plugin/ConfigEventIgnore/MyType.php` in any module, extend `ConfigEventIgnoreBase`,
and override `getRules()` (or `fullIgnore()`):

```php
namespace Drupal\my_module\Plugin\ConfigEventIgnore;

use Drupal\openy_upgrade_tool\ConfigEventIgnoreBase;

/**
 * @ConfigEventIgnore(
 *   id = "my_content_type_ignore",
 *   label = @Translation("Content type"),
 *   type = "node_type",
 *   weight = 0
 * )
 */
class ContentType extends ConfigEventIgnoreBase {

  public function getRules() {
    return [
      ['value' => 'dependencies.module', 'operator' => self::EQUAL_OPERATOR],
      ['value' => '/^display\..+\.cache_metadata.*/', 'operator' => self::REGEXP_OPERATOR],
    ];
  }

}
```

The only shipped example is `Plugin/ConfigEventIgnore/Views` (id `views_ignore`, type `view`),
which ignores `display.*.cache_metadata*` changes via a regexp rule.
