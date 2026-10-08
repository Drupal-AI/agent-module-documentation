# Configuration

Paragraph Group is driven from a single settings page. This is where you apply its
features — the accordion editing widget, the administrative title, and automatic
field grouping — across the components on your site, so you don't have to configure
each paragraph field's display by hand.

## Open the settings page

1. Log in as a user who can administer the site.
2. Go to the **Paragraph Group** settings page under **Configuration** (route
   `paragraph_group.form`).

## What you configure here

The settings page is deliberately checkbox‑driven: because the Paragraph Details
Widget could apply to a great many entities across a site, Paragraph Group lets you
switch its features on for the relevant components in one place rather than editing
each field's *Manage form display* individually. From this page you control:

- **The Paragraph Details (accordion) widget** — turn on the improved `<details>`
  based widget for your paragraph fields, so nested paragraphs are edited inside
  expandable/collapsible accordion sections with drill‑down navigation. This is the
  "vertical drilldown" half of the module.
- **The Administrative Title field** — add a lightweight admin‑only title to
  paragraphs. It appears as the **summary line** of each collapsed accordion
  section, so editors can see at a glance which paragraph they are working on
  without repurposing a real content field.
- **Automatic Field Groups** — let Paragraph Group organise a content type's fields
  into tabbed **Field Groups** automatically, the "horizontal grouping" half of the
  module, so long forms become a tidy set of tabs.

Tick the components and features you want, and leave the rest alone — anything you
do not enable is unaffected.

## A note on what it does and does not change

Everything on this page changes the **editing experience only**. Paragraph Group
reorganises how the edit form is presented; it does not modify your stored content,
and it has no effect on who can view or edit that content. You can safely enable and
disable its features to find the layout that suits your editors.

## Save

Save the settings page, then rebuild the cache if prompted (`drush cr`). Reopen a
content edit form to see the accordion widget and grouped fields take effect.
