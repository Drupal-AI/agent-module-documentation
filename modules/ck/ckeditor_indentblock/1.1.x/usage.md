CKEditor IndentBlock lets CKEditor 5 indent and outdent whole paragraphs (block-level indentation) in Drupal, reusing the core Indent/Outdent toolbar buttons and applying CSS classes (`Indent1`–`Indent10`) instead of inline styles.

---

The module registers a single CKEditor 5 plugin, `ckeditor_indentblock_indent`, that turns on the CKEditor 5 `IndentBlock` feature. It ships **no toolbar button of its own** — it piggybacks on the core `ckeditor5_indent` plugin, so block indentation only works once the built-in **Indent** and **Outdent** buttons are in a text format's toolbar. When active it indents whole `<p>` paragraphs by adding class-based indent levels (`class="Indent1"` … `class="Indent10"`) rather than inline `margin` styles, which keeps markup clean and themeable; a bundled CSS library (`ckeditor_indentblock/indentblock`) is attached to every page so the indent classes render on the front end. Each text format gets an **Indent block** vertical-tab setting with a single **Enable indentation on paragraphs** checkbox (default on); when disabled the plugin zeroes out its classes and offset so paragraph indentation is suppressed while list indentation still works. To actually indent paragraphs you must also allow the `<p class="Indent*">` markup in the format (via the plugin's element subset or Source Editing's allowed tags). Configuration is entirely per text format at `/admin/config/content/formats`; there is no global settings page. Settings persist on the `editor.editor.<format>` config entity under `settings.plugins.ckeditor_indentblock_indent`.

---

- Indent and outdent full paragraphs (not just list items) in a CKEditor 5 rich-text field.
- Add class-based paragraph indentation (`Indent1`–`Indent10`) that is easy to style and override in a theme.
- Give editors a familiar "increase / decrease indent" workflow using the standard Indent/Outdent toolbar buttons.
- Create tiered visual hierarchy in body copy (e.g. nested explanatory paragraphs, sub-points).
- Format legal, policy, or contract text that relies on indented clauses and sub-clauses.
- Produce blockquote-like offset paragraphs without using a real `<blockquote>`.
- Indent paragraphs inside long-form articles for readability and emphasis.
- Enable paragraph indentation on one text format (e.g. Full HTML) while leaving Basic HTML plain.
- Keep editor markup clean by using CSS classes instead of inline `margin-left` styles.
- Apply up to ten distinct indentation depths on a single paragraph via successive Indent clicks.
- Let content teams reproduce Word-style paragraph indentation in the web editor.
- Theme indentation responsively (adjust the indent width per breakpoint in the theme's CSS).
- Support outline-style content where sub-paragraphs are visually stepped in.
- Combine paragraph indentation with list indentation using the same toolbar buttons.
- Disable block indentation per format (Enable checkbox off) while retaining list indentation.
- Standardize indentation markup across a multisite so all editors output the same `Indent*` classes.
- Restrict indentation to trusted formats/roles by only adding Indent/Outdent to those formats' toolbars.
- Migrate from inline-style indentation to class-based indentation for cleaner, filterable HTML.
- Author documentation-style content (definitions, notes) with indented explanatory blocks.
- Build FAQ or Q&A layouts where answers are indented under questions.
- Emphasize pull-out remarks or asides by offsetting them from the main text column.

