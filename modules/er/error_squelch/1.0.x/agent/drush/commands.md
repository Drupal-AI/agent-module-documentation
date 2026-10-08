<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

`Drupal\error_squelch\Drush\Commands\ErrorSquelchCommands` (`src/Drush/Commands/`),
autodiscovered (Drush 11+). Constructed with `config.factory` via `create()`. Optional —
suggested composer dependency `drush/drush`. All three commands operate on the
`squelch_patterns` array in the `error_squelch.settings` config object.

| Command | Aliases | Argument | Behavior |
|---------|---------|----------|----------|
| `error-squelch:list` | `esl` | — | Prints each configured pattern as `N: <pattern>` (1-based), or "No squelch patterns configured." |
| `error-squelch:add` | `esa` | `pattern` | Trims; errors if empty; skips if already present (strict `in_array`); else appends and saves. |
| `error-squelch:remove` | `esrm` | `pattern` | Trims; removes exact matches (`array_filter`); errors "Pattern not found" if nothing changed; else saves. |

Examples:

```bash
drush error-squelch:list
drush error-squelch:add "Stripe API is running in test mode"
drush error-squelch:add "/menu_icons\/icon-\w+\.png/i"   # regex only matches if use_regex is on
drush error-squelch:remove "Stripe API is running in test mode"
```

Notes:
- `:add` matches the whole trimmed string exactly for the duplicate check; `:remove` matches
  the whole trimmed string exactly for removal.
- Adding a regex-style pattern only takes effect at render time when the `use_regex` setting
  is enabled (see [../config/settings.md](../config/settings.md)); otherwise it is treated as
  a literal substring.
