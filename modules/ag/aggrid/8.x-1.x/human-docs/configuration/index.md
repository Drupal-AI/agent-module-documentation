# Configuration

Getting ag-Grid working involves three steps: download the JavaScript library,
set the general options, define at least one grid structure, and then add a grid
field to your content.

## 1. Download the ag-Grid library

The ag-Grid JavaScript is not bundled with the module, so grids will not render
until you provide it. Download both the **Community** and **Enterprise** builds,
using either the module's Drush helper:

```bash
drush aggrid:download
```

or manually, following the instructions on the module's drupal.org project page.
Then tell the module which version/source you installed on the general settings
form (below).

## 2. General settings

Go to **Configuration → Content authoring → ag-Grid → General**
(`/admin/config/content/aggrid/general`). This form requires the **administer
aggrid general settings** permission.

- **Edition** — choose whether the site uses the free **Community** (open) edition
  or the paid **Enterprise** edition of ag-Grid.
- **Library version / source** — record which version of the library you
  downloaded and where it lives, so the module loads the correct files.
- **Enterprise license key** — if you chose the Enterprise edition, paste your
  license key here. It is stored in the module's configuration, so treat any
  configuration export as sensitive.

## 3. Define grid structures

Grid structures are reusable **config entities** managed at
**Structure → ag-Grid** (`/admin/structure/aggrid`). This area requires the
**administer aggrid config entities** permission.

- **Add** a grid to define its columns/structure (as JSON) and its default rows.
- **Edit** or **Delete** existing grid structures from the collection list.

Because a single structure can be referenced by many fields, defining it once
keeps every grid of that type consistent.

> **Security:** both permissions above are explicitly flagged as
> security-sensitive, because a grid's configuration drives rendered markup and
> client-side behaviour. Grant them only to trusted roles.

## 4. Add a grid field to your content

1. On a content type (or other entity bundle), go to **Manage fields** and add a
   field of the **ag-Grid** type.
2. Under **Manage form display**, choose how editors enter data:
   - the **ag-Grid** widget for visual, spreadsheet-style editing, or
   - the **JSON** widget for editing the raw JSON directly.
3. Under **Manage display**, choose how the grid appears on the front end:
   - the **ag-Grid** formatter for an interactive grid,
   - the **HTML** formatter to render it as a plain HTML table, or
   - the **preview / warning-list** formatter.

The field's stored value is the grid's JSON data, while the referenced config
entity supplies its structure and defaults. Grid field revisions can also be
compared with the module's bundled Diff plugin.
