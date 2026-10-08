<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dominican Catalogus is a packaged content solution for maintaining a Dominican community catalogue, with PDF export wired through Entity Print.

---
It bundles configuration, a `format-tables` library and a settings form at `/admin/config/content/catalogus` (`administer site configuration`) where you record the Provincial community ID. It declares `entity_print` mappings so nodes and views can be exported at `catalogus/pdf`, and ships an `AddressHideUSAFormatter` field formatter plus a `/community/{cid}/back-on/{date}` route (currently a placeholder controller gated by `access content`). It has a large dependency set (address, node, taxonomy, entity_print_views, computed_field, field_group, auto_entitylabel and more).

Setup: install all dependencies, enable the module, then set your community ID on the settings form and build/print catalogue pages as PDF. Because the `back_on` route uses `access content`, it is effectively public; it only returns placeholder markup today.
---
- Configure the Provincial community ID at `/admin/config/content/catalogus`.
- Export catalogue nodes to PDF at `catalogus/pdf`.
- Export a catalogue view to PDF.
- Hide the USA from address formatting with the custom formatter.
- Attach the `catalogus/format-tables` library to catalogue pages.
- Model communities as nodes with grouped fields.
- Auto-generate community entity labels.
- Use computed fields for derived catalogue data.
- Build a timeline of community events (views_timelinejs).
- Present telephone numbers with validation/formatting.
- Run bulk operations over catalogue content.
- Restrict catalogue settings to administrators.
- Provide a `/community/{cid}/back-on/{date}` link.
- Print a province directory as a booklet.
- Combine with media_library for community imagery.
- Order catalogue items with the weight module.
