<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `micon_icons` plugin type (string → icon mapping)

Separate from the icon **packages**, Micon has a YAML plugin type that maps arbitrary
**strings** to icon ids. It powers automatic icon decoration: when `micon('Some text')` has no
explicit icon, `MiconIconize` calls `plugin.manager.micon.discovery`
(`MiconDiscoveryManager::getDefinitionMatch()`) to find a matching definition and use its icon.

## Manager
`plugin.manager.micon.discovery` = `Drupal\micon\MiconDiscoveryManager` (extends
`DefaultPluginManager`, `YamlDiscovery` over `*.micon.icons.yml`). Alter hook: **`micon_icons`**.
Cache: `micon.discovery` (tag `micon.discovery`).

## Definition file: `<module|theme>.micon.icons.yml`
Each entry maps a match to an icon id. Fields (defaults in the manager):

| field | required | meaning |
|---|---|---|
| `text` | one of text/regex | exact-string match (checked first) |
| `regex` | one of text/regex | regex match (checked after all `text`) |
| `icon` | **yes** | icon id to use, e.g. `fa-user` |
| `weight` | no | ordering (default 0) |

`processDefinition()` throws if `id`, `icon`, or (`text` OR `regex`) is missing. Matching:
all `text` entries are tested for an exact `==` first; if none match, `regex` entries are tested
with `preg_match('!<regex>!', $string)`; first hit wins.

Example (`micon.micon.icons.yml`, shipped):
```yaml
published:
  regex: ^publish
  icon: fa-circle
  weight: -1
operations:
  text: operations
  icon: fa-cog
```
So `micon('published')` auto-renders with `fa-circle`. Prefixes let a module namespace its
matches; `micon('View')->addMatchPrefix('local_task')` looks up `local_task.view` (see
`micon_local_task.micon.icons.yml`).

## Adding definitions at runtime
```php
/**
 * Implements hook_micon_icons_alter().
 */
function mymodule_micon_icons_alter(array &$icons) {
  $icons['mymodule.save'] = [
    'text' => 'save changes',
    'icon' => 'fa-check',
    'regex' => '',
    'weight' => 0,
    'id' => 'mymodule.save',
  ];
}
```
Submodules use this to register per-bundle icons (e.g. `micon_content_type_micon_icons_alter()`
adds `content_type.<label>` / `content_type.<id>` entries pointing at each node type's chosen
icon). Invalidate cache tag `micon.discovery` after changing the source data.
