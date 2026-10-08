# Configuration — choosing the default diff layout

The **Diff General Settings** form controls how revision comparisons behave and
look site-wide: which comparison layouts editors can use, in what order, and how
much unchanged text surrounds each highlighted change. You can usually leave the
defaults in place, but it is worth understanding each option before editors start
comparing revisions.

## Open the General Settings form

1. Go to **Configuration → Content authoring → Diff**
   (`/admin/config/content/diff`).
2. You land on the **Settings** tab — the *Diff General Settings* form
   (`/admin/config/content/diff/general`). The **Fields** tab next to it is for
   per-field-type comparison options and is not covered here.

![The Diff General Settings page](../images/settings.png)

## Diff radio behavior

The first option, **Diff radio behavior**, controls how the two-revision picker
on the Revisions tab behaves when an editor selects revisions to compare:

- **Simple exclusion** — editors cannot select the same revision on both sides
  (you cannot compare a revision against itself).
- **Linear restrictions** — editors can only select older or newer revisions
  relative to their current selection, keeping comparisons in chronological order.

## Choose which layouts are available

Below the radio behavior is a **Layout** table listing the comparison layouts
Diff ships with. Tick the checkbox next to each layout you want editors to be able
to use, and drag the rows (or click **Show row weights** to set a numeric weight)
to control the order they appear in. The three layouts are:

- **Visual Inline** — a visual layout that renders the whole entity using its view
  mode and highlights the changes inline, so the comparison looks like the page
  itself.
- **Split fields** — a field-based layout that shows the two revisions **side by
  side** in two columns.
- **Unified fields** — a field-based layout that shows the changes **line by
  line** in a single column.

The text below the table — *"The layout plugins that are enabled to display the
revision comparison"* — confirms that only the ticked layouts are offered to
editors.

## Field based layout settings

The **Field based layout settings** section applies to the Split fields and
Unified fields layouts. It controls how much unchanged text is shown around each
change so the difference has context:

- **Leading** — the number of unchanged context "lines" to keep *before* each
  change (default `1`).
- **Trailing** — the number of unchanged context "lines" to keep *after* each
  change (default `1`).

## Visual layout settings

The **Visual layout settings** section (further down the page) applies to the
Visual Inline layout — it governs the view mode used to render that visual
comparison.

## Save

Click **Save configuration** at the bottom of the form. Your choices take effect
immediately for every revision comparison on the site.

## How editors compare two revisions

Once a layout is enabled, comparing revisions happens on the content item itself,
not on an admin page. For this to work, the content type must have **revisions
enabled** (edit the content type under *Structure → Content types* and tick
*Create new revision*, or ensure revisions are otherwise being saved).

To compare two revisions of a node:

1. Open the node and click its **Revisions** tab. This lists every saved revision
   of that content.
2. Each revision row has a **radio button** on the left and right. Select one
   revision in the left column and another in the right column to mark the *from*
   and *to* revisions.
3. Click **Compare selected revisions** (the **Compare** button).
4. Diff renders the comparison in your chosen default layout, breaking each field
   down and highlighting exactly what was added and removed between the two
   revisions. If more than one layout is enabled, links let you switch between
   them (for example, from Split fields to Visual Inline).

This is what editors use to review edits before reverting to an older revision,
or to audit who changed what across a content item's history.
