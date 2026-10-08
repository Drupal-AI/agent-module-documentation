# Chosen Order — manual setup guide

**Chosen Order** (`chosen_order`) fixes an ordering gap in the
[Chosen](https://www.drupal.org/project/chosen) widget. When a multiple-value
select field uses Chosen, editors can pick several values but can't control the
**order** they end up in — Chosen doesn't let you drag the selected chips around.
Chosen Order adds that missing drag-to-reorder behavior: editors rearrange the
selected items, and the module saves that order back into the field so it's
preserved on display.

It leans on jQuery UI's sortable interaction (via the `jquery_ui_sortable`
module) to make the selected values draggable. Because it extends the Chosen
experience, it depends on the **Chosen** module, the **Chosen Field**
(`chosen_field`) module, and **jQuery UI Sortable** (`jquery_ui_sortable`) — all of
which Composer/Drush pull in as dependencies. There's no site-wide settings page;
the behavior applies to multiple-value select fields that already use the Chosen
widget.

> **Note:** this project is **not covered by Drupal's security advisory policy**.
> Weigh that against your site's risk tolerance before using it on a production
> site, and keep it and its dependencies updated.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Chosen dependencies.

There is **no configuration page** for this module. It works on multiple-value
select fields already using the Chosen widget, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. The reordering happens on the entity's
add/edit form. Chosen itself is configured at its own settings page, and field
widgets are set on **Structure → *(bundle)* → Manage form display**.

## How to use it

1. Make sure the **Chosen** module is installed and enabled site-wide (or for the
   relevant fields), so multiple-value select fields render with the Chosen widget.
2. On a **multiple-value** select / list field that uses Chosen, open the entity's
   add/edit form.
3. Select several values, then **drag the selected chips** into the order you want.
4. Save. The chosen order is stored in the field and preserved when the content is
   displayed.
