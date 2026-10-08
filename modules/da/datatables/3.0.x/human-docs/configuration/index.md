# Configuration

There are two layers to configuring DataTables: one **site-wide setting** that chooses
where the JavaScript library comes from, and the **per-view options** you set each time
you apply the DataTables format.

## Site setting: Use CDN

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → DataTables**, or navigate directly to
   `/admin/config/services/datatables`.

The form has a single **Use CDN** checkbox:

- **Unchecked** *(default)* — the DataTables library is loaded from your local
  `/libraries` folder. Make sure you've installed it there (see
  [Installation](../installation/index.md)).
- **Checked** — the library is loaded from `cdn.datatables.net` instead, so you don't
  need any local files.

Saving the form clears the library discovery cache automatically so the new source
takes effect immediately. From the command line the value lives in
`datatables.settings`:

```bash
drush cget datatables.settings use_cdn
drush cset datatables.settings use_cdn 1 -y   # switch to CDN
```

The **Status report** (`/admin/reports/status`) reflects your choice: it reports
"Loaded via CDN" when the CDN is enabled, otherwise it checks that the local library
files exist and are a compatible version.

## Applying DataTables to a view

Build a view with **Fields** (**Configuration → Views**), then in the display's
**Format** choose **DataTables** and click its settings link. The options are grouped
as follows.

### Widgets / elements

- **Search box** — a client-side filter box above the table.
- **Table info** — the "Displaying 1–10 of 57" summary line.
- **Save state** — remembers each visitor's search, sort and page length between
  reloads.
- **Table tools** — adds a copy/print/export toolbar.

### Layout

- **Auto width** — let DataTables size columns automatically.
- **ThemeRoller** — apply jQuery UI ThemeRoller styling.
- **Custom sDom** — a custom DataTables DOM (`sDom`) string for advanced layout
  control.

### Pagination

- **Pagination style** — for example full-numbers paging, or disable DataTables' own
  pager.
- **Length change** — show the page-length selector so users pick how many rows to
  display.
- **Display length** — the default number of rows per page.

### Per-column settings

For each field/column you can set: whether it is **sortable**, its **default sort
order**, **alignment** (left/right/centre), a **separator** (when several Views fields
are combined into one column), whether to **hide empty** values, and **responsive**
behaviour. You can also set a **default sort column and direction** for the table.

### Hidden and expandable columns

Mark a column **hidden** (kept in the data but not displayed) or **expandable** — a
"child row" control column that reveals extra detail per row on click.

### Per-column search / filters

Add a search input to individual columns and choose its filter type, mark specific
columns non-searchable, and set the placeholder text shown in an empty filter.

> **Tip:** DataTables paginates client-side, so set the view's own pager to display
> all items — otherwise DataTables only sees one page of data.
