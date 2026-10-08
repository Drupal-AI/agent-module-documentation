# Configuration

ReadRemaining has one settings form that controls where the gauge appears and how
it looks and behaves. The gauge attaches only on **node** pages whose content type
you enable here; everywhere else, nothing loads.

## Open the settings form

1. Log in as a user who has the **Administer ReadRemaining** permission.
2. Go to **Configuration → System → ReadRemaining**, or navigate directly to
   `/admin/config/system/readremaining`.

## The settings, field by field

**Where it appears**

- **Content types** — check the content types the gauge should be active on. This
  is the essential setting: with none selected, the gauge never loads.
- **Selector** — the DOM element whose text the reading time is calculated from
  (default `body`; for example `#content` or a theme wrapper like `.my-wrapper`).
  Point it at the element holding your article body for the most accurate estimate.

**Look**

- **Look & feel** — choose **dark** (default) or **light** to match your theme;
  this selects the matching CSS from the library.

**When and where the gauge shows**

- **Show gauge delay** — how long to wait, in milliseconds, before showing the
  indicator (default `1000`).
- **Show gauge on start** — show the gauge immediately on page load instead of
  waiting for the reader to scroll (default off).
- **Insert position** — whether the gauge is **prepend**ed (default) or
  **append**ed into its container.
- **Gauge container** — the element the gauge is inserted into; leave empty to use
  the scrolling element.
- **Gauge wrapper** — an element that defines where the gauge is visible; leave
  empty to keep it always visible.
- **Top offset** — distance from the wrapper's top to where the gauge starts
  appearing (default `0`).
- **Bottom offset** — distance between where the gauge appears and the element's
  bottom (default `0`).

**Reading‑time display**

- **Time format** — the label template; `%m` and `%s` are replaced with minutes
  and seconds (default `%mm %ss left`).
- **Min time to show** — only show the indicator when the remaining time is above
  this many seconds (default `10`), so it doesn't appear on very short pages.
- **Max time to show** — only show it when the remaining time is below this many
  seconds (default `1200`).

**Debugging**

- **Verbose mode** — enable console logging while testing; leave off in
  production.

## Save

Click **Save**, then view a node of one of the selected content types to confirm
the gauge behaves as expected.
