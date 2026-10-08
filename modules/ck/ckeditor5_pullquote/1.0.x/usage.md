A CKEditor 5 toolbar button that turns selected text into a floated pull-quote or inserts a standalone custom quote, with optional citation and per-format style variants.

---

CKEditor 5 Pullquote registers a configurable CKEditor 5 plugin (no new entities, routes, services, or permissions) that adds a "Pullquote" dropdown to the toolbar of any text format you add it to. In "Pull from text" mode it wraps the current selection in a `<pullquote>` element; a lightweight frontend `Drupal.behaviors.pullquote` behavior then clones that element into a floated `<pulledquote>` aside next to its parent `<p>`, leaving the original text in the reading flow (the clone is marked `aria-hidden="true"`). In "Custom quote" mode it inserts a standalone `<pulledquote role="doc-pullquote">`. A balloon lets the author add a `cite` value, downcast as a `<cite>` child (visually hidden in the editor). Style variants are configured per text format in the plugin settings as `class|Label` lines and apply a single CSS class to the element. The module ships minimal CSS and attaches its frontend library on every page via `hook_page_attachments()`; theming the actual look of `pulledquote` (float width, typography, variant classes) is left to your theme. Everything is driven through the text format's filter allowlist, which is why enabling the button auto-registers the `<pullquote>`, `<pulledquote class role>`, and `<cite>` tags.

---

- Add a magazine-style pull-quote to an article by selecting a sentence and choosing "Pull from text".
- Keep the pulled sentence in the body copy while a floated visual duplicate draws the reader's eye.
- Insert a standalone highlighted quote that is not part of the surrounding paragraph via "Custom quote".
- Attribute a quote to a source using the inline cite field in the balloon.
- Alternate pull-quotes left and right down a long article using the automatic odd/even classes and theme CSS.
- Offer editors a fixed set of visual styles (e.g. `box|Box with background`, `line|Thick line on top`) through the variant dropdown.
- Enforce a house style by defining only the approved variant classes per text format.
- Add pull-quotes to a "Full HTML" format for privileged editors while omitting the button from restricted formats.
- Provide different variant sets on different text formats (e.g. news vs. blog) because config is per-format.
- Let authors edit or clear a citation after insertion by reopening the balloon on an existing pull-quote.
- Remove a pull-quote wrapper simply by deleting its text (an editing post-fixer unwraps empty pull-quotes).
- Ship accessible pull-quotes: the floated clone is `aria-hidden`, and standalone quotes carry `role="doc-pullquote"`.
- Retrofit `role="doc-pullquote"` onto older standalone quotes by re-saving the content through CKEditor.
- Style the pull-quote appearance entirely from your theme by overriding `css/pullquote.css` rules for `pulledquote`.
- Add responsive or print-specific pull-quote layouts in theme CSS without touching module code.
- Build a design system where each variant class maps to a component style your theme already defines.
- Migrate away from the legacy Drupal 7 Pullquote (text-pattern) module to an editor-native button.
- Give content authors pull-quotes without any block placement or extra page configuration.
- Preview pull-quotes inline inside CKEditor (rendered as inline markers) while they display as floated asides on the public page.
- Use the module on Drupal 10.5+ or 11 with only core's CKEditor 5 enabled, no contrib dependencies.
- Rebuild the compiled CKEditor plugin (`js/build/pullquote.js`) from `js/ckeditor5_plugins/` source with `npm run build` when customizing behavior.
