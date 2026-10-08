# Configure the Active Filters area

## Adding it

In the Views UI, on the display: **Add** to *Header* or *Footer* → choose **Global: Active Filters**.
Only useful on a display that has **exposed filters**. There is no global settings form — every option
lives on this area handler (`Plugin/views/area/ActiveFilters.php`).

## Per-area options

| Option | Key | Default | Effect |
|---|---|---|---|
| Heading Text | `title` | `Active Filters` | Text shown before the chips. Required. |
| Visually hide heading | `hide_title` | `false` | Adds `visually-hidden` class to the heading. |
| Group active filters by exposed filter | `grouped` | `false` | Renders chips grouped under each exposed filter's label (uses the `active_filters_grouped` theme). |
| Clear All Button Text | `clear_text` | `Clear All Filters` | Text of the clear-all button. **Leave empty to omit the button.** |
| (inherited) Display even if view has no results | `empty` | `true` | Standard Views area option; the plugin defaults it to on. |

## Per-exposed-filter options

For each exposed filter on the display, an "Advanced configuration for exposed filter '<id>'" details
group appears with:

| Option | Key | Default | Effect |
|---|---|---|---|
| Generate active filters | `enable` | `true` | Turn active-filter output on/off for this filter. |
| Active filters can be removed individually | `removable` | `true` | Whether chips for this filter are clickable-to-remove. |
| Rewrite active filter values | `rewrite` | `''` | `Current|Replacement` lines (one per line). |

### Rewrite syntax

```
On|Yes
Off|No
Disable|
```

- Each line is `CURRENT|REPLACEMENT`, split on the first `|`.
- Blank replacement → that value is **not** displayed as a chip (useful to show only one side of a
  boolean, e.g. keep `On|Yes`, drop `Off|`).
- Rewrites affect the **active filter display only**, not the exposed form values.
- Lines are split on `\r\n`; enter them via the textarea in the UI.

## Removability rules (automatic)

Even with `removable` on, a chip is non-removable when: the value is `All`; or the exposed filter is
required + multiple with only one value left; or (grouped boolean radios) the group is not optional.
Non-removable chips render with `disabled` / `aria-disabled`.

## Where settings live

In the display config of the view, e.g.
`views.view.<id>` → `display.<display>.display_options.header.active_filters` with keys `title`,
`hide_title`, `grouped`, `clear_text`, and `filters` (a sequence keyed by exposed filter id, schema
`views.area.active_filters`). On submit, `filters` entries for filters no longer on the display are
pruned.
