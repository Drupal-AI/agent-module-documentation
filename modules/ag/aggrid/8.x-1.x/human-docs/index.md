# ag-Grid — manual setup guide

**ag-Grid** (`aggrid`) brings the popular
[ag-Grid](https://www.ag-grid.com/) JavaScript data-grid library into Drupal as a
field type. It lets you store and edit tabular, spreadsheet-style data inside a
single field on any content — rows and columns, edited in a familiar grid — rather
than modelling every table as its own content type or paragraph.

The structure of a grid (its columns and default rows) is defined once as an
**ag-Grid config entity**, and any number of fields can reference that structure,
so grids stay consistent across your content. The field itself stores the grid's
data as JSON. The module ships several widgets and formatters so editors can edit a
grid visually or as raw JSON, and so the grid can be displayed on the front end as
an interactive grid or as plain HTML.

**A note on security.** A grid's configuration influences the markup and
client-side behaviour that gets rendered, so both of the module's permissions —
*administer aggrid config entities* and *administer aggrid general settings* — are
flagged as security-sensitive. Grant them only to trusted roles.

**The library is not bundled.** ag-Grid's JavaScript (both the free Community
build and the paid Enterprise build) is downloaded separately, either with the
module's Drush helper or manually. See the
[Configuration](configuration/index.md) page.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — download the ag-Grid library, choose
   the edition, define grid structures, and add a grid field to your content.

## Where it lives in the admin menu

- **General settings** (edition, library version/source, Enterprise license key)
  live at **Configuration → Content authoring → ag-Grid → General**
  (`/admin/config/content/aggrid/general`).
- **Grid structures** (the reusable config entities) are managed at
  **Structure → ag-Grid** (`/admin/structure/aggrid`).

Both areas require the corresponding permission and are administrative only —
there are no public or anonymous endpoints.
