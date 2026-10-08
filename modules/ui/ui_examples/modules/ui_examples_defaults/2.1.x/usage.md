UI Examples Defaults ships a baseline set of example pages for standard Drupal elements, so the UI Examples library has useful content out of the box for theme developers.

---

This submodule of UI Examples contains no PHP beyond a marker services file; it provides two YAML example plugins under `ui_examples/`. `normalize.ui_examples.yml` (id `normalize`, category "Core") renders a long catalog of standard HTML elements — headings h1–h6, paragraphs, bold/italic/strikethrough/underline/superscript/subscript, internal/external/mailto links, ordered and nested unordered lists, blockquotes, preformatted text, text alignment variants, and a full table with caption/thead/tbody. `status_messages.ui_examples.yml` (id `status_messages`, category "Core") renders the standard Drupal `status_messages` theme with error, warning, and status messages (each including a link). Both appear automatically in the Examples library at `/admin/appearance/ui/examples` once enabled. It depends on `ui_examples` and adds no routes, permissions, config, or Drush commands of its own.

---

- Populate the UI Examples library with standard-element previews immediately after install.
- Preview how a theme styles headings h1 through h6.
- Preview inline text formatting (bold, italic, strikethrough, underline, sub/superscript).
- Preview ordered, unordered, and nested lists.
- Preview blockquotes and preformatted (`pre`) text.
- Preview a full data table with caption, header, and body cells.
- Preview text-alignment utility classes (left/center/right/justify).
- Preview internal, external, and mailto link styling.
- Preview Drupal status, warning, and error messages together.
- Give themers a ready-made "Normalize" reference page to QA against.
- Use as a copy-paste starting point for authoring your own `ui_examples` YAML.
- Verify base typography and element resets in a new theme.
- Check message component styling without triggering real site messages.
- Compare element rendering across light/dark or responsive breakpoints.
- Serve as a smoke test that the UI Examples library renders correctly.
