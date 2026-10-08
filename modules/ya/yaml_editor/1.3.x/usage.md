<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
YAML Editor loads an [Ace](https://ace.c9.io) code editor over any textarea that carries a `data-yaml-editor` attribute, giving YAML config fields syntax highlighting, 2-space indentation, and a YAML mode.

---

The module has two moving parts. First, a `hook_page_attachments()` implementation attaches the `yaml_editor/yaml_editor` JavaScript library on **admin routes only**; the behavior finds every `textarea[data-yaml-editor]`, hides it, and mounts an Ace editor in its place that mirrors edits back into the original textarea so normal form submission still works. Second, it ships a `yaml_editor` field widget (extends core's `StringTextareaWidget`) for `string_long` fields, so you can turn on the editor for any *Text (plain, long)* field from **Manage form display** without writing code. Ace itself is loaded from a configurable source — by default the CDN URL `//cdnjs.cloudflare.com/ajax/libs/ace/1.2.0/ace.min.js` — and the Ace theme is configurable too (default `ace/theme/chrome`), both set at `/admin/config/development/yaml_editor` (config object `yaml_editor.config`, keys `editor_source` and `editor_theme`). The editor script is loaded lazily in the browser: if the global `ace` object is already present it is reused, otherwise the configured source URL is injected as a `<script>` tag. There is no server-side YAML validation — it is purely an editing/highlighting aid. Other contrib modules (Linked Field, Menu Link Attributes, Responsive SVG, Block Attributes) opt in by adding the `data-yaml-editor` attribute to their own textareas.

---

- Give the core *Configuration synchronization* single-import/export YAML textareas a real code editor with highlighting.
- Add syntax highlighting to a Webform's YAML source (elements) textarea when editing on an admin route.
- Enhance the Views UI YAML/config areas that appear in admin forms with an Ace editor.
- Turn a custom *Text (plain, long)* field into a YAML editor via Manage form display, no code needed.
- Provide editors for module settings forms that store YAML (e.g. mapping or options fields).
- Attach the editor to a textarea in your own admin form by adding `data-yaml-editor="true"` to its `#attributes`.
- Reduce YAML indentation mistakes by enforcing 2-space tabs in the editor.
- Give site builders a friendlier surface for hand-editing structured YAML config in the UI.
- Swap the editor color theme (e.g. to a dark Ace theme like `ace/theme/monokai`) site-wide.
- Pin Ace to a specific version or self-hosted copy by changing the `editor_source` URL.
- Serve Ace from a local library path instead of the cdnjs CDN for offline / air-gapped sites.
- Let Linked Field's per-link YAML attribute textareas render with highlighting automatically.
- Improve the editing experience for Menu Link Attributes YAML fields.
- Improve editing of Block Attributes / Responsive SVG YAML configuration textareas.
- Standardize a consistent YAML editing widget across several contrib modules on one site.
- Give editors line-based editing (Ace) instead of a plain wrapping textarea for long YAML blobs.
- Restrict who can change the editor source/theme via the `configure yaml_editor` permission.
- Keep the editor scoped to admin pages so front-end forms are unaffected.
- Prototype a YAML-driven configuration field on a content type and edit it comfortably.
- Provide a highlighted editor for paragraph or block config fields that hold YAML.
- Ensure copy-pasted YAML keeps its structure by editing it in a monospace, mode-aware editor.
- Offer a lightweight alternative to a full CodeMirror integration when you only need YAML.
- Let developers eyeball structural errors (bad nesting) faster thanks to highlighting.
- Use the field widget on migration or mapping fields that store YAML definitions.
- Attach the editor to a settings textarea in a distribution's install profile admin form.
