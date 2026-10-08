<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Days ago" formatter

## Install & enable

```bash
composer require drupal/days_ago
drush en days_ago -y
```

No dependencies beyond Drupal core, no sub-modules, no permissions of its own, no config, no Drush.

## Enable it on a field

The formatter (plugin id **`days_ago_field_formatter`**, label *"Days ago"*) applies to core
**`datetime`** and **`timestamp`** fields (`field_types = { "datetime", "timestamp" }`). It does
**not** apply to `daterange`, `created`/`changed` base fields exposed only as computed, or any
other type.

UI path: *Structure → (entity type / bundle) → Manage display* → set the date/time field's format
to **Days ago**. There are no options — the settings form, default settings and settings summary
are empty stub methods, so no gear/config appears.

Config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_event_date.type days_ago_field_formatter -y
drush cr
```

## What it outputs

From `viewValue()` in `DaysAgoFieldFormatter.php`:

1. `$to` = a `\DateTime` set to `\Drupal::time()->getCurrentTime()` (current request time).
2. Build `$from`:
   - **Timestamp field** (`$item instanceof TimestampItem`): if `$item->value > 0`, `$from` is a
     `\DateTime` at that Unix timestamp. If `$item->value <= 0`, the method returns the literal
     string **`"0"`** immediately.
   - **Datetime field** (any other item): `$from = new \DateTime($item->value)` on the stored
     value string (ISO-8601 for datetime fields).
3. Result = `$to->diff($from)->format("%a")` — the `DateInterval` **total whole days** (`%a`),
   which is **always non-negative**.
4. Returned as `nl2br(Html::escape($daysAgo))`.

So the rendered value is a plain integer (e.g. `7`) meaning "7 whole days between the field value
and now", with no unit label and no direction.

## Edge cases & gotchas

- **Future dates are not distinguished.** `%a` is an absolute count, so a date 3 days in the future
  and 3 days in the past both render `3`. The plugin's label says "Days ago" but the output is
  direction-less.
- **Only whole days.** Sub-day differences render `0`; there is no hours/months breakdown.
- **Timestamp `0` / negative** → the string `"0"` (special-cased before the diff).
- **Datetime value is not null/empty-guarded.** `new \DateTime('')` evaluates to "now" (→ `0`),
  and a non-parseable stored string would raise an exception from `\DateTime`. In normal use the
  stored datetime value is a valid ISO string, so this only matters for corrupt/imported data.
- The output is HTML-escaped, but since the payload is only a number this is defensive; there is
  no unescaped user- or remote-supplied content in the markup.
- No config schema exists (the formatter has no settings), so nothing is written to a config
  object beyond the standard view-display entry naming the formatter type.
