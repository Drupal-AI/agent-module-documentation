# Configuration

Active Filters has no global settings page — every option lives on the Views area
handler you add to a display. This page walks through adding it and each option.

## Add the area to a View

1. Edit a View (**Structure → Views**) and open a **display that has exposed
   filters** — the chips only make sense there.
2. In the display, click **Add** next to *Header* (or *Footer*).
3. Choose **Global: Active Filters** and add it.
4. Configure the options below, then **Apply** and **Save** the View.

## Per-area options

These apply to the whole chip list:

- **Heading Text** (default *"Active Filters"*) — the text shown before the chips.
  Required.
- **Visually hide heading** (default off) — keeps the heading for screen readers
  but hides it visually (adds a `visually-hidden` class).
- **Group active filters by exposed filter** (default off) — when on, chips are
  grouped under each exposed filter's label, e.g. *"Category: News, Events"*, using
  a dedicated grouped template.
- **Clear All Button Text** (default *"Clear All Filters"*) — the label of the
  clear-all button. **Leave it empty to omit the button entirely.**
- **Display even if view has no results** — a standard Views area option; Active
  Filters turns it on by default so the chips still show on an empty result set.

## Per-exposed-filter options

Below the area options, each exposed filter on the display gets its own **"Advanced
configuration for exposed filter '&lt;name&gt;'"** section with three settings:

- **Generate active filters** (default on) — turn chip output on or off for this
  particular filter. Handy to suppress a noisy filter while keeping the others.
- **Active filters can be removed individually** (default on) — whether this
  filter's chips are clickable-to-remove.
- **Rewrite active filter values** (default empty) — remap how values are displayed
  (see below).

## Rewriting displayed values

The **Rewrite active filter values** box takes one `Current|Replacement` mapping
per line:

```
On|Yes
Off|No
Disable|
```

- Each line is split on the first `|` — the raw value on the left, what to display
  on the right.
- **A blank replacement hides that value's chip.** This is how you show only one
  side of a boolean — e.g. keep `On|Yes` but drop `Off|` so only the "on" state
  produces a chip.
- Rewrites affect the **chip display only** — they don't change the exposed form or
  the underlying query.

## Automatic removability rules

Even with "can be removed individually" on, some chips are intentionally
**non-removable** — for example when the value is *All*, or when a required
multiple-value filter has only one value left. Those chips render in a disabled
state so visitors can't remove the last required selection.

## Where the settings are stored

All of this is saved inside the View's own configuration
(`views.view.<id>` → the display's header/footer `active_filters` area), so it
travels with the View through configuration export/import like any other Views
setting. Per-filter settings for filters no longer on the display are pruned
automatically when you save.

## Theming (optional)

The chips ship with minimal CSS and are fully themeable. There are four theme hooks
(`active_filters`, `active_filters_grouped`, `active_filter`, `active_filter_group`)
with granular template suggestions per view, display, filter and value, and each
chip carries `data-active-filter-*` attributes that the removal JavaScript relies on
— keep those if you override a template. The full theming reference, plus the
`activeFilterRemove` hook for custom JS widgets and the `hook_active_filters_alter()`
API, is in the sibling [`agent/`](../agent/start.md) docs.
