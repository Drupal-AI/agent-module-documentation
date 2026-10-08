<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pipewrench lets base fields — the built-in ones like a node's Title — carry help text, which Field UI does not otherwise allow, and improves the help text on Linkit link widgets.

---

Pipewrench is a small "shared utility" module (maintained by Lullabot for internal reuse) that makes two editorial-quality improvements. First, it adds a **Title field help text** textfield to the node type add/edit form (`node_type_form`); on save it writes the text into a `base_field_override` for `node.{bundle}.title`, so the node edit form's Title field finally shows a description. This closes a real gap in Drupal: base fields are defined in code by the entity type, so Field UI gives you nowhere to add help text to Title, and the usual fix is a hand-written form alter per project. Second, when the contrib **Linkit** module is present, it swaps the `linkit` field widget class for its own `PipewrenchLinkitWidget`, which rewrites the URI element's description to a clearer "Start typing to find content or paste a URL…". All of this is done through hook attributes (`src/Hook/PipewrenchHooks.php`) and one widget plugin (`src/Plugin/Field/FieldWidget/PipewrenchLinkitWidget.php`); there are no routes, permissions, config schema or settings pages of its own. It depends on core `node` and `field` only — Linkit is an optional runtime enhancement, not a declared dependency — and targets core `^10 || ^11`. The release is **1.0.0-alpha1** (alpha; not security-advisory-covered). It is complementary to `fieldhelptext`, which bulk-edits descriptions on *configurable* fields, whereas Pipewrench addresses *base* fields.

---

- Add help text below a node's Title field on the edit form.
- Tell editors how long a title should be (e.g. "keep under 60 characters").
- Give guidance on title naming conventions at the point of entry.
- Document a base field's purpose without writing a custom form alter.
- Set per-content-type Title guidance from the content type edit form.
- Add SEO guidance to the Title field.
- Give base fields parity with configurable fields for help text.
- Reduce inconsistent or malformed titles across a content type.
- Support editors working on an unfamiliar content type.
- Improve onboarding for new content editors.
- Reduce editorial-review back-and-forth about title format.
- Surface a style-guide rule directly in the authoring UI.
- Explain a required title format (prefix, casing) inline.
- Clarify what to type into a Linkit URI autocomplete field.
- Make Linkit link widgets more self-explanatory to editors.
- Standardise Linkit help text across every link field on a site.
- Replace a bespoke `hook_form_node_type_form_alter` with a shared module.
- Complement bulk help-text tooling (`fieldhelptext`) on the same site.
- Store Title help text as exportable config (`base_field_override`) that travels with the content type.
- Provide editorial guidance without granting any new permission or route.
