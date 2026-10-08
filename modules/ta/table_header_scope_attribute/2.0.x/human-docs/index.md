# Table Header Scope Attribute — manual setup guide

**Table Header Scope Attribute** (`table_header_scope_attribute`) makes the tables
your editors create in the WYSIWYG more accessible — automatically, without anyone
hand‑editing HTML. Screen readers rely on the `scope` attribute on a table's header
cells (`<th>`) to announce which header goes with which data cell. Editors almost
never add `scope` themselves, so author‑entered tables are frequently inaccessible.
This module fixes that as the content is rendered.

It provides **two text‑format filters** that you switch on for whichever text formats
render your table content (Basic HTML, Full HTML, and so on):

- **Set scope attribute for table headers** looks at each real data table and adds
  the right `scope` to its header cells — `scope="col"` for a header row,
  `scope="row"` for headers in the first column, and `colgroup`/`rowgroup` for
  headers that span multiple columns or rows. It leaves alone any `<th>` that already
  has a `scope` (respecting an author's intent) and any empty header cells, and it
  ignores pure‑layout tables that contain no data cells.
- **Transform empty table header to table data** turns empty `<th>` cells — like the
  blank corner cell at the top‑left of a grid — into ordinary `<td>` cells, since an
  empty header carries no meaning and would otherwise confuse assistive technology.

Because the work happens in a filter at render time, editors keep using the normal
table tool in CKEditor and the output simply comes out accessible — helping you meet
WCAG expectations and pass audits from tools like axe or WAVE.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no dedicated settings page. You turn the module on by enabling its two
filters on a text format, described below.

## Where it lives in the admin menu

The module has no settings page of its own. Its two filters appear inside each text
format's configuration at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`).

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and click to configure the format your table
   content uses — for example **Basic HTML**.
2. In the **Enabled filters** list, tick **both** *Set scope attribute for table
   headers* and *Transform empty table header to table data*.
3. Scroll to **Filter processing order**. The order matters:
   - **Set scope attribute for table headers** must come **before** **Transform empty
     table header to table data**. (If empty headers were converted to data cells
     first, the scope filter would then mis‑read the table.)
   - Keep both **below** core's **Limit allowed HTML tags and correct faulty HTML**
     filter.
4. Click **Save configuration**.

The module protects you here: if you enable both filters but leave them in the wrong
order, the form refuses to save and shows an error explaining the required order — so
you cannot accidentally break the accessibility logic.

Neither filter has any options of its own — enabling them and getting the order right
is all there is to it. Repeat for any other text format whose content includes tables.
