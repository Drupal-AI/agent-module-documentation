# Toggle Editable Fields — manual setup guide

**Toggle Editable Fields** (`toggle_editable_fields`) adds a **Toggle Editable
Formatter** for Boolean fields that renders the value as a Bootstrap Toggle switch
you can flip **right in the display** — on an entity's page or in a Views listing —
to change the stored value over AJAX. No edit form, no page reload. It's the
fast way to give editors one‑click switches for things like Publish/Unpublish,
Featured, In stock / Out of stock, or Approved, straight from a content overview.

Instead of printing "On/Off", the formatter builds a small per‑item AJAX form
containing a checkbox styled as a
[Bootstrap Toggle](https://github.com/minhur/bootstrap-toggle/) switch. Flipping it
re‑saves the host entity with the new value. The formatter's settings let you tune
the switch: custom On/Off labels (for example Yes/No or Live/Draft), a size (large,
normal, small, or mini), on/off styles (default, primary, success, info, warning,
danger), and optional pixel height and width. Because it renders anywhere the field
is displayed, including Views fields, it's well suited to inline toggling across
many rows.

Every save is access‑checked: the switch is disabled, and the write is skipped,
unless the current user passes the field's **edit** access check (and, by default,
the entity's **update** access) — so a read‑only or anonymous user cannot change
values even if they forge the request. The module requires the external
`bootstrap-toggle` JavaScript/CSS library placed under `/libraries`, and depends on
core's **Field** and **Field UI** plus the contrib **Libraries** module. There is
no admin settings page and no submodules — you configure it per field on a display.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the inline save
path and its access model — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the required
   Bootstrap Toggle library, and enable the module.

## Where it lives in the admin menu

There is no dedicated settings page. You apply the formatter per field on an
entity's **Manage display** tab (for example **Structure → Content types → [your
type] → Manage display**), or on a field added to a **View**.

## How to use it

1. Make sure the entity bundle has a **Boolean** field (for example a node's
   *Published* status, or a custom "Featured" flag).
2. Go to **Manage display** for that bundle — or add the Boolean field to a **View**
   as a field.
3. Set the field's format to **Toggle Editable Formatter** and open its settings.
4. Configure the switch:
   - **On / Off labels** — the text shown in each state (default *On* / *Off*).
   - **Size** — large, normal, small (default), or mini for dense tables.
   - **On style / Off style** — the Bootstrap colour for each state (on defaults to
     *success*, off to *default*).
   - **Height / Width** — optional pixel overrides; leave blank for the library
     default.
5. Save. The field now renders as a switch that editors with edit access can flip
   in place; users without access see it disabled.
