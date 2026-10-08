<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `ConfigMerger` — three-way config merge

Class: `Drupal\config_merge\ConfigMerger` (stateless; methods are static).

## The merge call

```php
use Drupal\config_merge\ConfigMerger;

$merged = ConfigMerger::mergeConfigItemStates($previous, $current, $active);
```

| Argument | Meaning |
|---|---|
| `$previous` | The config item as the extension **previously** provided (last snapshot). |
| `$current`  | The config item as the extension **now** provides (the incoming update). |
| `$active`   | The config item **currently in active storage** (possibly customized). |

Returns the merged array. (Two more args, `$parent_keys` and `$level`, are used only for
recursion — don't pass them.)

## Merge rules

Result starts from `$active`, then:

**Associative arrays** (any of the three states is a hash):
- **Change**: for a key whose value differs between `previous` and `current`, take the new value
  **only if** `active[key] === previous[key]` (the site didn't customize it) → operation
  `update`; otherwise keep the active value → operation `ignore`. If the value is itself an
  array in all three, **recurse**.
- **Addition**: keys in `current` not present in `previous` and not in `active` are added.
- **Removal**: keys removed between `previous` and `current` are dropped **only if** `active`
  still holds the previous value (unchanged).

**Indexed arrays** (elements can't be reliably diffed):
- If `previous === active` (site unchanged), replace with `current` → operation `substitute`;
  otherwise keep `active` (retain customization) → operation `ignore`.

Net effect: **uncustomized items adopt the update; customized items keep the customization.**

## Merge log

Every decision is recorded in a static log:

```php
$merged = ConfigMerger::mergeConfigItemStates($previous, $current, $active);
$logs = ConfigMerger::getLogs();
// keyed by operation: 'update' | 'ignore' | 'substitute'
// each entry: ['name' => key, 'state' => ['active'=>..,'previous'=>..,'new'=>..], 'parents' => [...]]
```

The log is reset at the start of each top-level merge call.

## POST_MERGE event

For consumers that want to react after a merge, the module defines:

- `Drupal\config_merge\Event\ConfigMergeEvents::POST_MERGE` (`'config_merge.post_merge'`)
- `Drupal\config_merge\Event\ConfigMergeEvent` with getters `getConfigName()`, `getLogs()`,
  `getProviderType()`, `getProviderName()`.

The module itself does not dispatch it; a consuming workflow (e.g. Config Sync) constructs and
dispatches `ConfigMergeEvent` so subscribers can log or post-process the merge results.

## Where it's used

The **config_merge_filter** submodule's `MergeFilter` Config Filter plugin calls
`mergeConfigItemStates($previous, $data, $active)` on read, using the config snapshot storage as
`previous` and active storage as `active`, so a config import merges into active config.
