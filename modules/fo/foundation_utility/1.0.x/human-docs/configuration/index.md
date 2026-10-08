# Configuration

Foundation Utility is configured entirely within Drupal's normal text‑format
settings — there's no separate admin page. You enable its table filter on the
formats you want and tick the transforms that should run.

## Enable the filter on a text format

1. Log in as a user with the **Administer filters** permission (an administrator by
   default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Click **Configure** next to the format your editors use (for example *Full HTML*
   or a custom rich‑text format).
4. In the **Enabled filters** list, tick the Foundation table filter to switch it on
   for this format.

## Order the filter correctly

In the **Filter processing order** section, drag the Foundation table filter so it
runs **after** any filters that produce or clean HTML (for example after
*Limit allowed HTML tags*). It needs to see the finished table markup in order to
rewrite it, so placing it too early can mean it has nothing to work on.

## The per‑format options

Each option is an independent transform — tick only the ones you want for this
format:

- **Add `.hover`** — applies Foundation's row‑highlight styling, so rows highlight as
  the reader moves their cursor over the table.
- **Add `.unstriped`** — removes Foundation's default zebra striping for a plainer,
  unstriped table.
- **Add `.stack` (stacked table)** — makes the table collapse into a stacked,
  single‑column layout on small screens, which is far more readable on mobile than a
  wide table squeezed sideways.
- **Add `.scroll` (scrolling table)** — wraps the table so it scrolls horizontally on
  narrow screens instead of overflowing the page. A good default for data‑heavy
  tables.
- **Remove `width` and `height` attributes** — strips inline sizing from the table
  and its cells, which is what lets the table become genuinely responsive rather than
  locked to pixel dimensions pasted in from another program.
- **Remove `style` attributes** — strips inline `style` attributes from the table and
  its cells, clearing out stray formatting (again, common in content pasted from Word
  or Excel).

The filter processes each `<table>` and recurses into its cells, so cell‑level
attributes are cleaned too. Existing table classes are preserved — the Foundation
classes are appended, not swapped in — and any non‑table markup is left untouched.
When the content contains no tables, the filter is a harmless pass‑through.

## Save

Click **Save configuration** at the bottom of the format's form. From then on, any
content saved through that format has its tables normalised and styled according to
the options you chose.

> **Tip:** A common, sensible combination is **Remove `width`/`height`** together with
> **Add `.scroll`** (or **`.stack`**), which turns rigid pasted tables into clean,
> responsive ones in one step.
