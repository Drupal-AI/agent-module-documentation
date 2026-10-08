# View Mode Switch Field — manual setup guide

**View Mode Switch Field** (`view_mode_switch`) provides a field type that lets
content editors choose, per entity, which view mode an entity is rendered as.
Normally a content type's display is fixed — every Article renders with the same
configured display for a given view mode. With this module you add a special
field to the bundle, and then an editor can decide that *this particular* node
should be shown using the "Teaser" display, or "Full", or a custom view mode,
without you having to create a whole new content type or write theme code. It is
a clean way to give marketing or editorial staff control over "display variants"
they can pick on the edit form.

You configure two things when you add the field. On the field **storage**
settings you set the **origin view modes** — the view mode(s) this field takes
over. On the field **instance** settings you set the **allowed view modes** — the
list of view modes an editor is permitted to switch to. When the entity is later
displayed in one of its origin view modes, the module quietly swaps the active
view mode to the editor's chosen one, so the same node can render with different
display configurations depending on the per-entity selection. The choice is
stored as ordinary field data, so it is exportable, revisionable, and
translation-aware.

The module ships a widget and two formatters (one showing the human-readable
chosen view mode, one showing its machine name), plus optional integrations: with
the **Diff** module to show view-mode-switch changes in revision comparisons, and
with **Paragraphs** so a paragraph can switch its own view mode. It requires
Drupal **11.3+** and core's **Field** module, and has no admin settings page, no
permissions, and no Drush commands of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

(There is no separate configuration page — the module has no settings form. You
set it up by adding a field, described below.)

## Where it lives in the admin menu

There is no admin page. You add and configure the field under **Structure →
Content types → [your type] → Manage fields**
(`/admin/structure/types/manage/<type>/fields`), and place its widget on **Manage
form display**.

## How to use it

1. Go to the *Manage fields* screen of the content type (or other fieldable
   entity) you want to give editors display control over, and click **Add
   field**.
2. Choose the **View Mode Switch** field type and give it a label (for example
   "Display as").
3. On the **field storage** settings, set the **origin view modes** — the view
   mode(s) this field should take over. For example, choose *Full content* if you
   want the field to control how the node renders in its full-page view.
4. On the **field instance** settings, set the **allowed view modes** — the list
   of view modes an editor may switch to (for example *Teaser* and *Full
   content*). This is required. The chosen view modes become configuration
   dependencies of the field.
5. Save the field. On **Manage form display**, make sure the field's widget is
   placed so editors see the choice on the edit form. Optionally, on **Manage
   display**, add one of the field's formatters if you want to surface the chosen
   value.

From then on, when an editor sets the field on a given entity, displaying that
entity in one of the origin view modes renders it using the editor's chosen view
mode instead. If a referenced view mode is later deleted, the module cleans the
field's options and warns on the status report.
