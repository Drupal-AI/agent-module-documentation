# Configuration

There are two independent ways to make tables responsive: **(1)** the per‑format **filter**
(the main use, for editor‑authored tables), and **(2)** an optional **settings form** that
auto‑applies Tablesaw to Views and theme tables.

## 1. Enable the filter on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and click **Configure** on a format your editors use
   (e.g. *Basic HTML* or *Full HTML*).
2. Under **Enabled filters**, tick **"Apply responsive behavior to HTML tables."**.
3. Scroll to **Filter settings** for that filter and choose:
   - **Default mode** — how tables behave on small screens:
     - **Stack** *(default)* — each row collapses into a stacked key/value list.
     - **Column toggle** — readers choose which columns are visible.
     - **Swipe** — readers swipe horizontally through columns.
   - **Persist first column** *(on by default)* — keeps the first column visible as a row
     label while the other columns collapse.
4. **Filter processing order matters.** If the format also uses **"Limit allowed HTML tags"**
   (or any tag‑stripping filter), make sure the responsive‑tables filter runs **after** it in
   the order, and that the allowed‑tags list permits `<table> <thead> <tbody> <tfoot> <tr>
   <th> <td>` **and** the `class` attribute — otherwise the Tablesaw classes get stripped out.
5. Click **Save configuration**.

### Editor overrides

Once the filter is on, content authors have per‑table control via CSS classes on the
`<table>` element:

- Override the mode on one table by adding `tablesaw-stack`, `tablesaw-columntoggle`, or
  `tablesaw-swipe`.
- Opt a table out of responsive behavior entirely with `no-tablesaw`.
- **A table must have a `<thead>`** for any of this to apply — tables without a header row are
  left untouched.

## 2. Auto‑apply to Views and theme tables (optional)

This is separate from the text‑format filter and needs no format at all — it applies globally.

1. Go to **Configuration → Content authoring → Responsive Tables Filter**
   (`/admin/config/content/responsive_tables_filter`). It needs the *Administer site
   configuration* permission.
2. Set the options:
   - **Enable for Views** *(off by default)* — when on, Tablesaw is added automatically to
     every Views‑generated table and every table rendered through Drupal's core `table`
     element, site‑wide.
   - **Mode for Views/theme tables** — **Stack** (default), **Column toggle**, or **Swipe**.
     This can differ from the mode you set on your text formats.
3. Click **Save configuration**.

Leave **Enable for Views** off if you'd rather control responsiveness per view.

## Verify it works

Create or edit content with a wide table in a format where you enabled the filter, save, and
view the page on a narrow screen (or shrink your browser window). The table should stack,
toggle, or let you swipe according to the mode you chose. If nothing happens, check that the
table has a `<thead>`, that the filter runs after any tag‑stripping filter, and that the
`class` attribute is allowed.
