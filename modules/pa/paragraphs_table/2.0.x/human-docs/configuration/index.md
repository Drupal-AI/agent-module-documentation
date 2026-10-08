# Configuration

Paragraphs table has **no central settings page**. You switch it on per field, on
the host entity's display settings. The field must be a **Paragraphs reference
field** (technically an `entity_reference_revisions` field).

## Show paragraphs as a table (the formatter)

1. Go to the host entity's **Manage display** (for example **Structure → Content
   types → (type) → Manage display**).
2. For your Paragraphs field, set the **Format** to **Paragraphs table**.
3. Click the settings cog to configure it. The main options are:
   - **View mode** — which view mode is used to render each paragraph
     (default *default*).
   - **Vertical** — off shows a row per paragraph (columns = fields); on flips it
     so fields run down the side. Off by default.
   - **Caption** — an optional table caption (also good for accessibility).
   - **Mode** — the table library to layer on: leave empty for a plain table, or
     choose **DataTables** (sortable/searchable), **Bootstrap Table**
     (responsive), or **Google Charts** (visualise the data). With Google Charts
     you also pick a **chart type** and **width/height**.
   - **Number column** — add a leading numbered column (with a configurable
     header, default `N°`).
   - **Hide empty columns** — keep sparse data compact by dropping columns that
     are entirely empty.
   - **AJAX** — load a large table via AJAX for better performance.
   - **Custom class** — an extra CSS class on the table for theming.
   - **Hide row operations** / **Hide add button**, plus options for import,
     footer text, and column sums.
4. Save.

### JSON output instead of a table

If you want the paragraphs as JSON (for a decoupled front end), choose the
**Paragraphs table (JSON)** formatter instead. Its one setting, **recursion
level** (default `2`), controls how deep nested references are serialised.

## Let editors fill a table (the widget)

1. Go to the host entity's **Manage form display**.
2. For your Paragraphs field, set the **Widget** to **Paragraphs table**.
3. Configure its settings:
   - **Vertical** — vertical editing grid instead of a row per paragraph.
   - **Paste from clipboard** — let editors paste rows straight from a
     spreadsheet.
   - **Field reference** — the field used by the reference-search helper (shown
     when paste is enabled).
   - **Show all** — show every row at once instead of an "add more" flow.
   - **Features** — enabled per-row features, such as **duplicate**.
4. Save.

Because the widget extends the core Paragraphs widget, all the standard
Paragraphs widget settings still apply on top of these.

## Managing individual paragraph rows

The table's per-row **edit / duplicate / delete** buttons use dedicated
paragraph-item pages the module provides (under `/paragraphs_item/…`), along with
AJAX and JSON endpoints used to load and update the table. You don't configure
these — they back the row operations automatically.

## Permission

- **Administer paragraphs_item fields** (`administer paragraphs_item fields`) —
  "Create, duplicate and delete fields on paragraphs". It is marked
  security-sensitive; grant it only to trusted roles at **People → Permissions**.
  Access to the paragraph-item routes is enforced by the module's access checks.
