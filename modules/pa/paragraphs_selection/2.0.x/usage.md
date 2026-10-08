<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Selection inverts where the allowed-paragraph-types list lives: instead of each entity-reference-revisions field naming the bundles it accepts, each paragraph bundle records which fields it may be placed on. It is configured by choosing the "Paragraphs Selection" reference handler on a paragraph field.

---

Core Paragraphs stores its allowed-types list field-side: every entity_reference_revisions field carries a drag-and-drop list of the paragraph bundles it accepts, with per-bundle weight. On a site with thirty paragraph types and fifteen referencing fields that model does not scale — adding a type means editing every field that should accept it, and it is easy to leave the new type available in four places and missing from the fifth. Paragraphs Selection moves the decision to the bundle. Set a paragraph field's reference handler to **Paragraphs Selection** (`paragraph_reverse`, an EntityReferenceSelection plugin extending Paragraphs' own `ParagraphSelection`) and enable/weight bundles in the same drag-drop UI. On save, `paragraphs_selection_field_config_presave()` translates that choice into a third-party setting **on each paragraph type** (`paragraphs_selection.fields`, a list of `{id, weight}` referencing the field's config id), then strips `target_bundles`/`target_bundles_drag_drop` from the field and stores only `self_field_id`. At widget-build time `getSortedAllowedTypes()` reads the allowed list **back from the bundles**, weight-sorted. So the field keeps no allowed-types list of its own — the reverse mapping fully **replaces** it, and a `negate` option (from the parent handler's allow/exclude behaviour) flips enabled to a blocklist. Version **2.0.6** on `^9 || ^10 || ^11`, requiring `paragraphs`. The submodule **Paragraphs Selection Paragraphs Sets Support** does the same for `paragraphs_sets`: a YAML "Availability" textarea on the Paragraphs Set form stores a `selection` third-party setting, and an event subscriber makes a set usable on a field only when its config lists that field. Note two things: this shapes only what the widget offers — it is content modelling, **not access control**, so it does not stop a migration, a JSON:API write, or existing content from placing a paragraph the rule now forbids; and because the source of truth is bundle-side, the parent field config no longer holds an independent bundle list to reconcile against.

---

- Declare, per paragraph type, which fields it may be used on.
- Add a new paragraph type and set its placements in one edit instead of touching every field.
- Restrict a "Full-width hero" to page bodies only.
- Keep a large content model (many types × many fields) maintainable.
- Move the allowed-types decision from the field to the component it describes.
- Retire a paragraph type cleanly by clearing its bundle-side placements.
- Control which paragraph types may nest inside which paragraph fields.
- Weight-order the types a field offers from the bundle side.
- Use `negate` to turn a bundle's placement list into an exclusion (blocklist) instead of an allowlist.
- Keep placement rules discoverable on the bundle rather than scattered across fields.
- Roll out a design-system component to a defined set of fields consistently.
- Switch an existing paragraph field to the `paragraph_reverse` handler to adopt the model.
- Restrict a paragraph type to a single content type's field.
- Reduce the number of field-configuration edits when the type inventory changes.
- Add Paragraphs Sets availability rules with the `paragraphs_selection_paragraphs_sets_support` submodule.
- Limit which paragraph sets appear on a given field via a YAML "Availability" rule.
- Manage placement config through configuration export as bundle third-party settings.
- Keep the editor's add-paragraph options relevant to each field.
- Prevent a paragraph type from appearing on fields where it was never intended.
- Model component placement centrally when the same field pattern repeats across bundles.
