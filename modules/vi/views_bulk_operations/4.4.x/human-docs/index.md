# Views Bulk Operations — manual setup guide

**Views Bulk Operations** (`views_bulk_operations`), usually shortened to **VBO**,
adds a checkbox column and an actions dropdown to any View, so that users can tick
individual rows — or select every result across every page — and then run a single
operation on all of them at once: delete, publish, update a field, cancel user
accounts, or any custom action you like. It turns an ordinary Views listing into an
administrative dashboard with mass‑action buttons.

You add VBO to a View by placing its special **Views bulk operations** field on a
display. That field renders the per‑row checkboxes plus a "select all" control and
an action selector above the results. When you configure it, you choose which
actions are offered, can preconfigure each action with fixed settings, and can
require a configuration step and/or a confirmation step before anything runs. On
submit, the selected rows are handed to the chosen action and processed either
immediately or through Drupal's Batch API in configurable chunks — so operations
scale to thousands of entities without hitting PHP timeouts. Selections are kept
in tempstore, so they survive the multi‑step flow and multi‑page AJAX selection.

Because everything is driven by Views, any entity type or query you can expose
through Views can be bulk‑processed. Actions are ordinary Drupal Action plugins,
extended by VBO's `ViewsBulkOperationsActionBase`, which gives each action access
to the whole view, the selected rows, and per‑execution context — so writing a
custom bulk action is straightforward. VBO ships delete and cancel‑user actions,
an event to alter the available action list, and a Drush command to run a view's
action from the command line.

The module requires Drupal 10.3+ or 11 and core's **Views** module. It has **no
central settings page** — you configure it per View. Two optional submodules ship
with it: **Actions Permissions** (`actions_permissions`) adds per‑role,
per‑action access control, and **VBO Example**
(`views_bulk_operations_example`) provides a worked example you can learn from.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — the action plugin API,
services, events, and Drush command — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose the submodules you need.
2. [Configuration](configuration/index.md) — add and configure the VBO field on
   a View, field by field.

## Where it lives in the admin menu

VBO has **no global admin page** (`configure` is null). You configure it inside
the Views UI at **Structure → Views** (`/admin/structure/views`): edit a View and
add the **Views bulk operations** field to a display. If you enable the Actions
Permissions submodule, the per‑action permissions it generates appear on
**People → Permissions** (`/admin/people/permissions`).
