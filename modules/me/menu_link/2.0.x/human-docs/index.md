# Menu Link (Field) — manual setup guide

**Menu Link (Field)** (`menu_link`) provides a `menu_link` field type, so any
fieldable entity — not just nodes — can place a link to itself into a menu, right
from its own edit form. Because it is a real Field API field, it works on taxonomy
terms, media, custom content entities, and more; it can differ per bundle; it is
exposed to Views; and — crucially — it is **revisionable**. Unlike core's Menu UI,
the menu placement (title and position) is versioned along with the entity, so
reverting a revision also reverts its menu link.

Once you add the field to a bundle, editors get a familiar "Menu settings"-style
sub-form on the entity edit page: a title, an optional description (shown on hover),
and a menu parent selector limited to the menus you allow. Saving the entity
creates or updates the corresponding menu link; deleting the field value removes it.
On node types, this field replaces core's own "Menu settings" section with a
field-based equivalent that plays nicely with the Fields UI, view modes, and field
groups.

The module ships one widget and two display formatters: one that renders the stored
link (optionally as a hyperlink to the target), and one that renders the menu
ancestry as a breadcrumb. All configuration is done per field through the standard
Field UI — there is no separate settings page. The module depends only on core's
**Field** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the field to a bundle, set which
   menus it may use, and place its widget and formatters.

## Where it lives in the admin menu

There is no central settings page. Everything is configured per field through the
**Field UI** — on a bundle's **Manage fields**, **Manage form display**, and
**Manage display** tabs (for a content type, under **Structure → Content types →
*(your type)***). See [Configuration](configuration/index.md).
