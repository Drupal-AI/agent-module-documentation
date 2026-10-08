<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mechanism: overriding the `request_path` condition

This module does **not** register a new condition plugin id. It **replaces the class** behind
the existing core `request_path` condition, so the enhancement is invisible and automatic for
every block.

## The swap

`block_exclude_pages.module` implements `hook_condition_info_alter()`:

```php
function block_exclude_pages_condition_info_alter(array &$definitions) {
  if (isset($definitions['request_path'])
      && $definitions['request_path']['class'] === 'Drupal\\system\\Plugin\\Condition\\RequestPath') {
    $definitions['request_path']['class'] =
      'Drupal\\block_exclude_pages\\Plugin\\Condition\\BlockExcludePagesRequestPath';
  }
}
```

So the condition **id stays `request_path`** (blocks still store
`visibility.request_path.pages`); only the implementing class changes to
`Drupal\block_exclude_pages\Plugin\Condition\BlockExcludePagesRequestPath`, which
`extends \Drupal\system\Plugin\Condition\RequestPath`. It is *not* a `@Condition`-annotated
new plugin — it is a class substitution guarded so it only fires if the definition is still
the unmodified core one.

## What the subclass changes

- **`buildConfigurationForm()`** — appends help text to the Pages field `#description`
  ("prefix the path with a `!`…", "The order of the lines matters!").
- **`validateConfigurationForm()`** — relaxes core validation so a line may start with `!/`
  (or be `!<front>`) in addition to `/` and `<front>`; anything else errors with "requires a
  leading forward slash or exclamation point".
- **`evaluate()`** — the core logic, extended for `!`:

```
pages = lowercased configuration['pages'], split on newlines
for each line p:
  if p does NOT start with '!':          # include pattern
    if matchPath(alias, p) || matchPath(path, p):
      path_match = TRUE;  is_exclude = FALSE
  else:                                  # exclude pattern (strip leading '!')
    if matchPath(alias, excl) || matchPath(path, excl):
      path_match = TRUE;  is_exclude = TRUE
return (path_match XOR is_exclude)
```

Because a single pair of flags is carried across the loop (not per-line), **the last matching
line wins**: the final line that matches sets whether the current path counts as included or
excluded. `path_match XOR is_exclude` then yields:

| last match | `path_match` | `is_exclude` | result (before core negate) |
|---|---|---|---|
| an include line | TRUE | FALSE | **TRUE** (show) |
| an exclude line | TRUE | TRUE | **FALSE** (hide) |
| nothing matched | FALSE | FALSE | FALSE |

An empty Pages value returns TRUE (no restriction), exactly like core. Core's **Hide for the
listed pages** radio (`negate: true`) is applied by the condition manager *after* `evaluate()`,
so it inverts the whole result — which is why, under negation, `!` lines *show* the block.

This "last match wins" is why order matters and why `!/order/*/*` **then** `/order/*/complete`
re-includes the complete page, but the reverse order leaves it hidden.

## Files

- `block_exclude_pages.module` — `hook_condition_info_alter()`, `hook_help()`, plus unused
  debug helpers (`block_exclude_pages_debug_*`, `$debug` is hard-coded `FALSE`).
- `src/Plugin/Condition/BlockExcludePagesRequestPath.php` — the subclass.
- `block_exclude_pages.services.yml` — one logger channel
  `logger.channel.block_exclude_pages` (used only by the disabled debug path).

No config schema and no new plugin manager are added; the stored config is the core
`request_path` schema.
