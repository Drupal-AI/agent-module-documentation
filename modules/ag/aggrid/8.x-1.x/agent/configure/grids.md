<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring ag-Grid

## Install the library
The JS library is not bundled. Download both the ag-Grid **Community** and **Enterprise** builds using the module's Drush download tool (`drush aggrid:download`) or manually per the drupal.org docs, then set the version/source under general settings.

## General settings — `/admin/config/content/aggrid/general`
Permission: **administer aggrid general settings**.
- Choose the edition (Community open edition or Enterprise).
- Set the library version / source path.
- For Enterprise, paste the license key (stored in module config).

## Grid config entities — `/admin/structure/aggrid`
Permission: **administer aggrid config entities**.
- **Add** a grid: define its column/structure JSON and default rows.
- **Edit / Delete** existing grid entities from the collection list.
- These entities are referenced by the aggrid field so multiple fields can share a structure.

## Using the field
1. Add a field of type **ag-Grid** to a bundle.
2. Manage form display: choose the **ag-Grid** widget (grid editing) or the **JSON** widget (raw JSON).
3. Manage display: choose the **ag-Grid**, **HTML**, or preview-warning-list formatter.

## Notes
- The field value is the grid's JSON; the referenced config entity supplies structure/defaults.
- Grant both permissions only to trusted roles — a grid config influences rendered markup and client-side behaviour.
