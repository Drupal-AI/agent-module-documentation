<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Block List Override

Settings form `Drupal\block_list_override\Form\SettingsForm` at route
`block_list_override.settings` → **`/admin/config/block_list_override/settings`** (menu:
*Configuration → System → Block List Override Settings*). Permission:
**`access block list override`**. All state lives in **`block_list_override.settings`**.
Saving the form runs `drupal_flush_all_caches()`.

## Config keys

| Key | Type | Default | Purpose |
|---|---|---|---|
| `system_match` | string (newline list) | `''` | Exact block plugin ids to remove/allow. |
| `system_prefix` | string (newline list) | `''` | Colon-prefixes; matches ids starting `<prefix>:`. |
| `system_regex` | string (newline list) | `''` | `preg_match` patterns (include delimiters). |
| `system_negate` | boolean/int | `false` (0) | Action: **0 = Remove** matched, **1 = Allow only** matched. |
| `layout_match` | string | `''` | *(stored by form; NOT used by the alter hooks in 1.0.x)* |
| `layout_prefix` | string | `''` | *(stored by form; NOT used by the alter hooks in 1.0.x)* |
| `layout_regex` | string | `''` | *(stored by form; NOT used by the alter hooks in 1.0.x)* |
| `layout_negate` | boolean/int | `false` (0) | Action for the Layout Builder list only. |

Each list field is a textarea; put **one entry per line**.

## The two lists / two hooks
- `hook_block_alter()` → the **site-wide** block list (theme *Place block*, and everywhere).
  Uses `system_match`/`system_prefix`/`system_regex` + `system_negate`. Removing a block here
  makes it disappear from **all** block UIs.
- `hook_plugin_filter_block__layout_builder_alter()` → the **Layout Builder** "Add block"
  chooser. **Also reads `system_match`/`system_prefix`/`system_regex`**, but with
  `layout_negate` as its action. So the same patterns govern both lists; only the negate flag
  can differ between them in this version.

## Matching semantics (`BlockListOverride::blockIsAllowed`)
A block id is "listed" if ANY of:
- it starts with `"<prefix>:"` for a Prefix entry (e.g. `field_block:user` →
  `field_block:user:user:uid`), or
- it equals a Match entry exactly, or
- `preg_match(<regex>, $plugin_id)` succeeds (e.g. `/field_block:node:(.*):nid/`).

Then, per delta of `array_filter(... ARRAY_FILTER_USE_KEY)`:
- **negate = 0 (Remove):** keep the block if it is NOT listed (listed blocks are dropped).
- **negate = 1 (Allow only):** keep the block only if it IS listed (everything else dropped).
- **Always kept:** any block plugin already placed in a Layout Builder section (guards against
  breaking existing layouts). Regular *placed* blocks (block config entities) are NOT exempt —
  removing one yields "non-existent block" warnings, so verify with the preview pages first.
- If all three pattern fields are empty (`hasSettings()` false), nothing is filtered.

## Preview pages
- `/admin/config/block_list_override/system-list` — blocks remaining in the system list.
- `/admin/config/block_list_override/layout-list` — blocks remaining for Layout Builder.

## Drush / config example
```bash
# Remove the "Powered by Drupal" block everywhere:
drush config:set block_list_override.settings system_match 'system_powered_by_block' -y
drush config:set block_list_override.settings system_negate 0 -y
drush cr
```

## Legacy migration
On install, `hook_install` copies settings from `block_blacklist.settings` (the old Block
Blacklist module) into `block_list_override.settings` if present.
