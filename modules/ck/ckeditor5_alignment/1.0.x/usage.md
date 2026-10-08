Exposes CKEditor 5 text alignment as four separate toolbar buttons (Align Left, Align Center, Align Right, Justify) instead of core's single alignment dropdown.

---

CKEditor5 Alignment Buttons is a tiny, code-free contrib module: it ships nothing but a single CKEditor 5 plugin definition (`ckeditor5_alignment.ckeditor5.yml`) plus an `.info.yml`. It reuses CKEditor 5's own built-in `alignment.Alignment` plugin and core's `core/ckeditor5.alignment` library, so it introduces no new JavaScript, PHP, services, routes, permissions, or configuration schema of its own. Where Drupal core exposes text alignment as one split/dropdown toolbar button, this module registers four independent toolbar items — `alignment:left`, `alignment:center`, `alignment:right`, `alignment:justify` — that a site builder can place individually on any CKEditor 5 toolbar. The buttons write the standard core `text-align-left` / `text-align-center` / `text-align-right` / `text-align-justify` CSS classes onto block ("text container") elements, matching `core/modules/system/css/components/align.module.css`. Configuration is done entirely per text format at `/admin/config/content/formats`, where you enable the module's buttons in the CKEditor 5 toolbar builder; there is no separate settings page.

---

- Show discrete Align Left / Center / Right / Justify buttons in the CKEditor 5 toolbar instead of the collapsed core dropdown.
- Reduce clicks for content editors who align text frequently (one click per alignment vs. open-dropdown-then-pick).
- Add only the alignment options you want — e.g. expose just Left and Center and omit Justify.
- Build a "distraction-free" editor profile where common formatting actions are all top-level buttons.
- Standardize alignment output on core's `text-align-*` classes so existing theme CSS keeps working.
- Keep alignment markup class-based (no inline `style` attributes) for cleaner, filterable HTML.
- Configure per text format: enable the buttons for Full HTML but leave a restricted format without them.
- Combine with core's list, link, and heading buttons to assemble a full-featured WYSIWYG toolbar.
- Provide a more discoverable alignment UI for occasional/non-technical authors who miss the dropdown.
- Use as a drop-in replacement for the D7/CKEditor 4 muscle-memory of separate alignment buttons.
- Support RTL/LTR content workflows where editors switch alignment often.
- Give designers/editors quick center-alignment for callouts, quotes, or captions.
- Right-align numeric or metadata blocks within body content.
- Justify long-form article paragraphs where house style requires it.
- Teach or demo CKEditor 5 plugin definitions: a minimal, readable example of surfacing a core plugin as separate toolbar items.
- Roll out consistent alignment tooling across many text formats/editors via config export.
- Avoid maintaining a custom in-house CKEditor plugin just to un-collapse the alignment dropdown.
- Pair with an accessible theme so alignment classes map to visible, screen-reader-friendly layout.
- Migrate editorial teams from other CMSes that expose alignment as individual buttons.
