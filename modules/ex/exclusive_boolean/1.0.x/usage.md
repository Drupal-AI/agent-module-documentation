<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a per-field "exclusive" option to boolean fields on node content types so that checking the field on one node automatically unchecks it on every other node of the same type.

---

Exclusive Boolean is a lightweight helper for the common "only one can be TRUE" pattern (a single featured article, one default landing page, one active alert). Instead of writing custom code, an administrator edits any boolean field on a node bundle, opens the field's Third-party settings, and ticks "Make this field exclusive". From then on, whenever a node of that bundle is saved with the field checked, the module's `entity_presave` implementation finds all other nodes of the same content type that still have that field set to TRUE and re-saves them with it set to FALSE, so at most one node ever holds the flag. It also injects an inline notice under the field on node edit forms explaining the behaviour and, when the current node is unchecked, naming which node currently holds the flag. The feature is scoped strictly to node bundles and boolean field types; it adds no routes, permissions, services beyond one hook object, config schema, or external dependencies, and the setting is stored as a third-party setting on the field config entity.

---

- Ensure only one article can be marked "featured" at a time.
- Keep a single page flagged as the site's default landing page.
- Maintain one "primary" item across all nodes of a content type.
- Highlight exactly one announcement or alert node at once.
- Mark a single "current" event and auto-clear the previous one.
- Designate one node as the active/reference configuration node.
- Let editors promote a new hero item without manually unchecking the old one.
- Enforce single-selection semantics on a boolean field without custom code.
- Guarantee a "sticky"/"pinned" flag is unique per content type.
- Replace a manual "unset the previous default" editorial step.
- Provide a one-of-many toggle for landing/spotlight content.
- Keep a single node flagged as the homepage banner source.
- Ensure only one "coming soon" node is live at a time.
- Auto-rotate a "post of the week" flag as new posts are saved.
- Give editors an on-form notice showing which node currently owns the flag.
- Prevent accidental multiple "featured" selections that break a view's expectations.
- Enforce a single "primary contact" or "main office" node per type.
- Keep one "active promotion" node exclusive across the catalogue.
- Model a radio-button-style choice across separate nodes rather than within one field.
- Avoid duplicate hero content appearing when a query expects a single flagged node.
