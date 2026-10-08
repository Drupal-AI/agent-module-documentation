<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Translation Unified Form (ETUF) injects every enabled language's translatable field widgets into the standard entity add/edit form so all translations are created and saved in one submission.

---

Drupal's core Content Translation UI is one form per language, reached through a per-language "Translate" tab: to translate a page you open the source in one browser tab and the target in another and copy between them, and a field added later is easy to miss in some languages. ETUF alters the normal node/entity add and edit form (`hook_form_alter`) to append, next to each translatable field, the same widget for every *other* enabled language (field name suffixed `-etuf-{langcode}`), then adds its own submit handlers that write each of those values back onto the matching entity translation and save them all together. It works per bundle and is turned on from the content-language settings page; nodes get extra options (side-by-side two-column UI, tabbed accordion mode, a "Save only" button, moderation-sync toggle, and a "Replace node edit" mode that rewrites the edit route so all languages' fields are always reachable). Display layout is provided by pluggable "form mode" plugins — Inline (default) and Tabbed (A11Y accordion tabs) — and it carries workarounds for moderation state, revisions, menu-link titles, path aliases (pathauto), managed files and metatag fields.

It suits a small number of languages and a moderate field count; a content type with many translatable fields times several languages becomes a very large single form, so past a point the per-language forms it replaces are more manageable.

---

- Create a node in two or more languages in a single save.
- Edit all existing translations of a node on one screen.
- Translate with the source field and target field visible together.
- Avoid switching between two browser tabs while translating.
- Stop missing a newly-added field in some languages.
- Turn on unified editing per content type (bundle), not site-wide.
- Enable unified editing for non-node entity types (media, paragraphs, taxonomy) from the content-language page.
- Use inline mode where each language's field appears after the source, labelled with its language.
- Use side-by-side two-column mode for two-language editing (nodes, screens ≥ 992px).
- Use tabbed (accordion) mode to switch between languages per field group.
- Add a custom display layout via the `EntityTranslationUnifiedFormMode` plugin type.
- Choose how the language is shown in field labels (current name, native name, or language code).
- Translate field labels and descriptions themselves into each language ("Translate fields labels" option).
- Give editors a "Save only" button that saves and returns to the edit form.
- Keep moderation state synchronised across translated revisions on a combined save (or disable that sync per bundle).
- Replace the node edit route so all fields stay reachable when editing a non-default-language node.
- Automatically copy/translate the node's menu-link title into other languages.
- Keep pathauto URL aliases generated for every translation after save.
- Preview a multilingual node with all translations populated (with the referenced core preview patch).
- Handle managed file/image and metatag fields correctly across translations.
- Reduce translator training by keeping everything on the familiar edit form.
- Audit translation completeness by seeing every language at once.
- Evaluate whether a unified or per-language workflow fits a given content model.
