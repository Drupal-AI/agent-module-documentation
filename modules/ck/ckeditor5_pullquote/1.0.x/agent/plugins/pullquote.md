<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pullquote CKEditor 5 plugin internals

Declared in `ckeditor5_pullquote.ckeditor5.yml` as `ckeditor5_pullquote_pullquote`:
- CKEditor plugin id `pullquote.Pullquote`, toolbar item `pullquote`.
- Drupal side: `library: ckeditor5_pullquote/pullquote`, `admin_library: .../admin`, `class: ...\CKEditor5Plugin\Pullquote`.
- Compiled build shipped at `js/build/pullquote.js`; ES source under `js/ckeditor5_plugins/pullquote/src/`.

## Model schema (`pullquoteediting.js`)
Two model elements, both `allowWhere: '$text'`, `allowChildren: '$text'`, `allowAttributes: ['cite', 'variant']`:
- `pullquoteAuto` → serialized as `<pullquote>` (auto mode).
- `pullquoteManual` → serialized as `<pulledquote>` (manual/standalone mode).
A child check forbids nesting pull-quotes inside pull-quotes. A post-fixer (`_registerPostFixer`) unwraps a pull-quote element once it becomes empty (author deleted the text).

## Converters (`pullquoteediting.js` `_defineConverters`)
- **Upcast** `<pullquote>`→`pullquoteAuto`, `<pulledquote>`→`pullquoteManual`. `upcastCite()` reads a `<cite>` child, consumes it + its text node, and stores the text as the model `cite` attribute (prevents a duplicate cite). `upcastVariant()` reads the element's first CSS class as the `variant` attribute.
- **dataDowncast** (saved HTML): `downcastWithCite('pullquote')` and `downcastWithCite('pulledquote', {role: 'doc-pullquote'})`. It sets `class` to the variant (single class) and, if `cite` is set, appends a `<cite>` container holding the cite **text node** (so cite is stored as escaped text, never raw markup). Manual quotes always get `role="doc-pullquote"`.
- **editingDowncast** (in-editor view): plain `<pullquote>` / `<pulledquote>` containers; dedicated `attribute:cite:*` and `attribute:variant:*` dispatchers (`_rerenderCite`, `rerenderVariant`) keep the `<cite>` child and `class` in sync as attributes change.

## Commands
- `insertPullquote` (`pullquotecommand.js`) — toggles/inserts a pull-quote in `auto` or `manual` mode.
- `setCite` (`setcitecommand.js`) — sets/clears the `cite` model attribute from the balloon input.
- `setVariant` (`setvariantcommand.js`) — sets the `variant` (CSS class) model attribute.

## UI (`pullquoteui.js`)
Registers a toolbar **dropdown** with "Pull from text" (auto) and "Custom quote" (manual); if `editor.config.get('pullquote.variants')` is non-empty it appends a separator plus one button per `{class,label}` variant (skipping entries missing class or label). A `ContextualBalloon` (`pullquoteballoonview.js`) hosts the cite input and a remove action; clicking the `<cite>` label redirects the model selection to the end of the pull-quote's text.

## Frontend behavior (`js/behavior/pullquote.js`, library `frontend`)
`Drupal.behaviors.pullquote` (uses `core/once`):
- For each rendered `<pullquote>`: finds the closest `<p>`, adds `pullquote-parent`, creates a `<pulledquote>` whose `innerHTML` is copied from the (already filter-sanitized) `<pullquote>`, marks it `aria-hidden="true"`, and prepends it to the paragraph; any `<cite>` inside the original is given `visually-hidden`.
- For every `<pulledquote>` on the page, assigns alternating `odd`/`even` classes so `css/pullquote.css` can flip float direction.

## Display CSS (`css/pullquote.css`)
Styles `pulledquote` (block, ~66% width, floated via odd/even margins) and hides the inline `<pullquote>` marker's cite in the `.ck-content` editor preview. Intended to be overridden by the theme.

## Notes for agents
- No PHP renders editor content; output safety is entirely the text format's `filter_html` allowlist (class/role only — no style/event attributes).
- Variant classes are author-supplied strings applied verbatim as a CSS `class`; add matching CSS in the theme.
