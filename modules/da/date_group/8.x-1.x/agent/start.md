<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date Group (date_group) — agent index

One **field formatter** for core Date range (`daterange`) fields that **collapses the shared parts**
of a start and end date into a single string — "May 01-03, 2016" instead of
"May 01, 2016 - May 03, 2016". Display only; no permissions, routes, services, or config schema.

- **Type:** `@FieldFormatter` plugin, id `date_group`, `field_types = { daterange }`.
- **Extends:** `Drupal\datetime_range\Plugin\Field\FieldFormatter\DateRangeDefaultFormatter`.
- **Depends on:** core `datetime_range` and `system (>=8.2.0)`.
- **Version:** `8.x-1.0-beta4` (**beta**). Core `^8 || ^9 || ^10 || ^11`.
- **Configure:** Manage Display, per field. No admin route of its own.

## Mechanism
`viewElements()` puts both dates in the request's current default timezone, then:
1. **start timestamp == end timestamp** → renders the single date via the parent `buildDate()`.
2. **years differ** → full start `+ separator +` full end ("August 27, 2016-May 14, 2017").
3. **same month** → merges the day into a range, month and year printed once ("May 01-03, 2016").
4. **same year, different month** → year printed once at the end ("May 05-June 06, 2016").

The merge is done by splitting the chosen date-format **pattern** character-by-character
(`str_split`) and reassembling it, then formatting via `dateFormatter->format(..., 'custom', ...)`.
Output is emitted as plain `#markup` with a `timezone` cache context.

## Settings
Inherited from the core range formatter: **format_type**, **separator** (default `-`),
**timezone_override**, **from_to**. Added by this module: **time_separator** (default `:`).

## Caveats (behavioral, not bugs)
- Use a **date-only format** (maintainer's recommendation). Time is only partially handled in the
  same-month branch and not in the year/different-month branches.
- The grouped path uses the **request default timezone**, not the formatter's `timezone_override`.
- The inherited **`from_to`** setting is ignored once grouping applies.

## Files
- `src/Plugin/Field/FieldFormatter/DateGroupFormatter.php` — the whole module (one class).
- `date_group.info.yml`, `composer.json`, `README.md`, `LICENSE.txt`.

See [`field-formatter/date_group.md`](field-formatter/date_group.md) for the render walkthrough.
