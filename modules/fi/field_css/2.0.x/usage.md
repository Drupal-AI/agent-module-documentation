<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field CSS adds a Field API field type for entering CSS, which it renders into the entity's display as a `<style>` element, optionally scoping every selector to that entity so an editor can style a specific node, block, or other entity without touching the theme.

---

Sometimes one piece of content needs a little bespoke styling and editing the theme is disproportionate. Field CSS turns CSS into a field: add a field of type CSS to any bundle and the editor gets a textarea (or, with the optional CodeMirror Editor module, a syntax-highlighting editor) in which to write rules. On display, the `css` formatter parses the CSS through the sabberworm/php-css-parser library and emits a `<style>` element. Three prefix modes decide the scope: `none` outputs the CSS as-is (pretty-printed); `entity-item` prepends a per-entity class such as `.scoped-css--node-42` to every selector and adds that class to the entity wrapper so the rules only match this entity; `fixed-value` prepends a fixed class you choose. The style can be placed in the page `<head>` or inline in the body, and the module cooperates with Layout Builder so scoped classes survive component rendering and live preview reflects edits. A dedicated `access css fields` permission governs who may edit CSS fields. Because it is built on the Field API, it works anywhere fields do — nodes, blocks, media, paragraphs, users — and inherits translation and workflow support.

---

- Style a single node with custom CSS without a theme change.
- Add bespoke styling to one block or media item.
- Scope CSS to one entity with a `scoped-css--<type>-<id>` prefix.
- Prefix all selectors with a fixed class of your choice.
- Output raw, unscoped CSS for a page-level style.
- Add a CSS field to any bundle via Manage fields.
- Render the `<style>` element in the page `<head>`.
- Render the `<style>` element inline in the body instead.
- Give editors a CodeMirror syntax-highlighted CSS editor.
- Configure which CodeMirror toolbar buttons appear.
- Restrict CSS editing to a role via the `access css fields` permission.
- Style content that lives in a Layout Builder layout.
- See CSS changes update in Layout Builder's live preview.
- Attach one-off design tweaks directly to the content they affect.
- Keep per-entity styling versioned with the entity's revisions.
- Translate CSS per language on translatable entities.
- Add a CSS field to a paragraph type for reusable styled components.
- Style a user profile or taxonomy term.
- Normalize/pretty-print entered CSS automatically on output.
- Prevent selectors from escaping their scope by blocking `:root`.
- Add a landing-page style scoped to that landing page node.
- Override default styling for a single featured item.
- Provide editors a controlled way to add CSS without theme access.
- Attach multiple CSS values (deltas) to one multi-value field.
- Use the reusable `CssTrait` to prefix or format CSS in custom code.
