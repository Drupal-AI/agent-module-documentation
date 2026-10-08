<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Boolean adds a core Condition plugin that evaluates a node's boolean (checkbox) field values, so block visibility (or any condition context) can depend on a per-node flag.

---

Drupal's Condition plugin type powers block visibility and other context-driven decisions. Site builders often want a block to appear only when a node carries a particular flag — a "Featured", "Promote in sidebar", or "Show call-to-action" checkbox on that content. Node Boolean supplies a single condition plugin (`node_boolean`) that lists every boolean field defined on any node bundle and lets you pick one or more; at render time it reads the field value on the node in context and returns TRUE/FALSE. It can evaluate multiple fields in either an "any" (OR) or "all" (AND) combination, and the standard core "Negate the condition" checkbox inverts the outcome. It has no settings page, no routes, no permissions, and no config schema of its own — configuration is stored inside the host block/condition config. It is a site-building convenience that governs display only: a block hidden by the condition is simply not rendered, not access-protected, so it must not be relied on as a security boundary.

---

- Show a block on a node page only when that node's "Featured" checkbox is ticked.
- Hide a promotional block unless the content is flagged for promotion.
- Combine several boolean flags with "any" (OR) so a block shows if at least one is checked.
- Combine several boolean flags with "all" (AND) so a block shows only when every flag is checked.
- Negate the condition to show a block only when a flag is NOT checked (e.g. "hide upsell when already-purchased is set").
- Drive a sidebar call-to-action block from a per-node "Show CTA" boolean.
- Toggle a legal/disclaimer block per node via a "Requires disclaimer" checkbox.
- Vary which navigation or related-content block appears based on a content flag.
- Reuse one boolean field (e.g. `field_featured`) across several bundles and evaluate it uniformly.
- Gate a "subscribe" or "newsletter" block by an editor-set boolean on the node.
- Show a beta/preview banner block only on nodes marked with a "beta" boolean.
- Let editors control block placement without touching Block Layout, using a checkbox on the content form.
- Condition any plugin context that consumes core conditions (not just blocks) on a node boolean.
- Evaluate multiple bundles at once, since options come from the site-wide boolean field map.
- Build simple editorial "feature this" workflows without a contrib flag/queue module.
- Pair with core Block Layout visibility to layer node-boolean logic on top of path/role rules.
- Prototype conditional layouts quickly with existing checkbox fields, no code required.
- Keep the module enabled only where such conditions are used, and restrict block administration to trusted roles.
- Test evaluation on each target bundle, since a selected field absent from a bundle causes "all" mode to fail for that node.
- Treat it strictly as display logic — never as access control for protected content.
