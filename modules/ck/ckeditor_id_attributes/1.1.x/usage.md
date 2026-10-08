CKEditor5 ID Attributes adds a toolbar button that lets editors set the HTML `id` attribute on elements in the CKEditor 5 rich-text editor, enabling in-page anchors and stable element IDs from the WYSIWYG.

---

The module wires the third-party **idAttributes** CKEditor 5 JS plugin (plus an
`idAttributesLabels` companion) into Drupal's CKEditor 5. It ships a
`CKEditor5PluginDefault`-based Drupal plugin (`IdAttributes`) declared in
`ckeditor_id_attributes.ckeditor5.yml`, exposing a single toolbar item **`idAttributes`** and
declaring the editing capability `elements: <$any-html5-element id>` — i.e. it registers the
`id` attribute as allowed on any element already permitted by the text format. There is no
global settings page; you configure it per **text format / editor** (*Administration →
Configuration → Content authoring → Text formats and editors*): drag the "ID Attributes"
button onto the CKEditor 5 toolbar and, in its plugin settings, optionally enable
**"Show element IDs in the editor"** (`show_id_labels`, default off) which renders each
element's id as a small label above it in the editing view only (an authoring aid; it does not
change the saved markup). That flag is passed to the JS via `getDynamicPluginConfig()` as
`editor.config.get('idAttributes.showLabels')`. Because it grants the `id` attribute, make sure
the format's HTML filtering allows `id` where you expect it. Config schema key:
`ckeditor5.plugin.ckeditor_id_attributes_idAttributes`. Depends only on core `ckeditor5`.

---

- Let content editors add an `id` to a heading or paragraph for in-page anchor links.
- Create a table of contents that jumps to sections by their element IDs.
- Give a specific element a stable `id` for CSS/JS targeting from the WYSIWYG.
- Add anchor targets for "skip to section" / deep links in long articles.
- Set IDs used by front-end scripts (accordions, scrollspy) without editing raw HTML.
- Provide named anchors editors can link to across pages.
- Show element IDs inline in the editor to check/verify anchors while authoring.
- Toggle the ID-label overlay per text format for editor convenience.
- Add the ID Attributes button to a restricted "Basic HTML"-style format for trusted authors.
- Support accessibility patterns needing referenced IDs (e.g. `aria-labelledby` targets).
- Let marketers set IDs for analytics/scroll-tracking hooks in body content.
- Assign IDs to images/figures for caption or lightbox targeting.
- Build glossary/footnote anchor targets inside rich text.
- Keep IDs on elements across edits without dropping to source view.
- Enable IDs only on formats where the HTML filter permits the `id` attribute.
- Give editors anchor capability comparable to the old CKEditor 4 anchor plugin.
