<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Renders Adnuntius.com ad units in Drupal as a block or an entity field, driven by an admin-defined catalog of ad units.

---

Adnuntius integrates the Adnuntius.com ad server. An administrator defines a catalog of ad units at `/admin/config/services/adnuntius` — each with a human label, the Adnuntius ad-unit id (`auId`), a default width and height, and a sort weight. Those ad units can then be placed on the site in two ways: through the `Adnuntius Block` block plugin, or through an `Adnuntius` field attached to any fieldable entity (node, taxonomy term, user, etc.). Each placement renders a small themed snippet that loads Adnuntius' client-side `adn.js` script from `cdn.adnuntius.com` and requests the selected ad unit, using one of two delivery ("invocation") methods — `div` or `iframe`. All ad delivery happens in the visitor's browser; the module itself makes no server-side HTTP call to Adnuntius and stores no API key. It depends only on Drupal core Block and Field.

---

- Serve Adnuntius.com display ads on a Drupal site.
- Maintain a central catalog of ad units (label, `auId`, width, height, weight) in one config form.
- Place an ad unit in any theme region with the `Adnuntius Block` block plugin.
- Pick which ad unit a block shows from a select of configured units.
- Choose the delivery method (`div` or `iframe`) per block.
- Attach an `Adnuntius` field to nodes, terms, users, or any fieldable entity.
- Let an ad unit be selected per entity via the field widget.
- Restrict which ad units are selectable on a given field (per-field whitelist).
- Let content editors choose the invocation method per entity (optional field setting).
- Restrict which invocation methods are offered per field.
- Set a default/fallback invocation method on the field formatter.
- Reorder ad units with drag-and-drop weights in the settings form.
- Reuse the same ad unit across many blocks and fields.
- Gate ad-unit administration behind the `administer adnuntius` permission.
- Gate use of the field behind the `use adnuntius field` permission.
- Theme individual ad units with template suggestions per invocation method or per `auId`.
- Render ads client-side without any server-to-server API integration.
- Programmatically render an ad via the `adnuntius.manager` service.
- Deliver responsive/fixed-size banners using the unit's configured width and height.
- Monetize content pages with ad placements managed entirely from Drupal config.
