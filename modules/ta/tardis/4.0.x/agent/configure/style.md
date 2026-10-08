<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TARDIS — Views style options

## Use
On a view, set **Format → Style** to **TARDIS**. Give the view a date field/sort and enough rows to cover the range you want linked.

## Options
| Option | Default | Meaning |
|--------|---------|---------|
| `path` | `tardis` | Path prefix for each link, e.g. `example.com/tardis/1963/11`. |
| `month_date_format` | `m` | PHP `date()` format for the month label. |
| `nesting` | (bool) | Whether month links are nested inside their year link. |

## Wiring the targets
The style only emits links like `/{path}/{year}/{month}`. Build the destination — commonly a second view with contextual filters (arguments) on the content's created/date field resolving year then month — so clicking a month shows that month's content.

## Theming
Output goes through the `views_view_tardis` theme hook; override the template in `templates/` (`tardis.theme.inc` provides preprocessing) to change markup.
