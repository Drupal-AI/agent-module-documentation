# Module Instructions — manual setup guide

**Module Instructions** (`module_instructions`) adds links on the module list page
(**Extend**, `/admin/modules`) that open a module's documentation files — its README,
CHANGELOG, and LICENSE — rendered right inside the Drupal admin UI. Instead of
hunting through your filesystem for a module's `README.txt` or `INSTALL.txt`, you
click a link in the module's *Operations* column and read it in the browser.

The links appear next to each enabled module's default links, and the rendered
content is displayed through Drupal's markup filter. It is a small quality‑of‑life
tool for site builders and developers who want a module's setup notes close at hand.

You control who can see the links with the **Access module instruction files**
permission, and you can enable or disable individual link types on the module's own
settings page. Module Instructions also ships a Drush command. It has no
dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The module's small settings page (to toggle which links show) is described below,
folded into this overview.

## Where it lives in the admin menu

- The **links themselves** appear in the *Operations* column of each module on the
  **Extend** page (`/admin/modules`).
- The **settings page** is at **Configuration → System → Module Instructions**
  (`/admin/config/system/module-instructions`), where you can enable or disable the
  individual links. Access to it is gated by the **Manage module instruction
  settings** permission.

## How to use it

1. After enabling (see [Installation](installation/index.md)), go to
   **`/admin/modules`**. Each enabled module now shows README/CHANGELOG/LICENSE links
   in its *Operations* column; click one to read the file rendered in the admin UI.
2. To control who may view these files, grant the **Access module instruction files**
   permission to the appropriate roles at **People → Permissions**.
3. To turn specific link types on or off, visit
   **`/admin/config/system/module-instructions`**.

Both the file‑viewing and settings routes are permission‑gated, and the module
resolves each file inside the requested module's own directory, so there is no
path‑traversal exposure.
