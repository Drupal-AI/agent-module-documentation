<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Automator: Pandoc converts an uploaded Word/PDF/ODT/RTF file into HTML with the pandoc CLI and writes the result into a text field when the entity is saved.

---

AI Automator: Pandoc adds one AI Automators plugin, "Pandoc: Word to HTML" (`pandoc_word_to_html`). Configured on a content type, it reads a document from a file field, runs the server's pandoc binary against it, and stores the produced HTML in a `text_long` target field automatically on entity save — no custom code. Input format is auto-detected from the file's MIME type and extension (docx/doc, pdf, odt, rtf, html, txt) and the pandoc output is shaped by per-automator options: HTML5/HTML4, line wrapping, standalone wrapper, embedded resources, numbered sections, a table of contents, and a free-text extra-arguments field. An admin sets the absolute path to the pandoc binary on a settings form (`/admin/config/content/pandoc`); the form validates it and shows the detected pandoc version, and the module reports its status on the site status report. A Drush command (`ai-automator-pandoc:test` / `pandoc-test`) runs the same conversion from the command line for diagnosis. Requires pandoc installed on the server. Depends on core `system` and the AI module's `ai_automators` sub-module; supports Drupal 10.4, 11, and 12.

---

- Convert an uploaded `.docx`/`.doc` Word file to HTML on entity save.
- Convert an uploaded PDF to HTML.
- Convert ODT and RTF documents to HTML.
- Convert HTML and plain-text file inputs through pandoc as well.
- Populate a `text_long` rich-text field from a document automatically.
- Auto-detect the input format from MIME type and file extension.
- Choose HTML5 or HTML4 output per automator.
- Control pandoc line wrapping (none / auto / preserve).
- Emit a standalone document (full `<html>` wrapper) when needed.
- Embed referenced resources as data URIs (optional).
- Number sections automatically in the output.
- Prepend a generated table of contents.
- Pass additional pandoc CLI flags via the extra-arguments field.
- Set the pandoc binary path on `/admin/config/content/pandoc` and see the live version.
- Get a status-report entry (OK / Warning / Error) reflecting pandoc availability.
- Receive a post-install banner reminding you to configure the pandoc path.
- Run `drush ai-automator-pandoc:test` to verify conversion from the CLI.
- Save the conversion output next to the source file with the Drush `--save` option.
- Build a document-import pipeline that feeds converted HTML into further AI Automators steps.
- Advance an `ai_doc_proofread` workflow by setting a status field after conversion.
- Keep document conversion inside Drupal instead of a separate service.
- Support Drupal 10.4, 11, and 12 sites running the AI Automators module.
