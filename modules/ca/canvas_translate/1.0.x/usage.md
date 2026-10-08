Canvas Translate translates Drupal Canvas (Experience Builder) pages, content templates, and page regions from inside the Canvas editor, using a draft → review → publish workflow instead of a third-party translation service.

---

Canvas Translate ships a Canvas *page extension* (registered via `canvas_translate.canvas_extension.yml`) that opens a translation workspace at `/canvas/app/canvas_translate`. It reuses Canvas's translatable-string extractor to pull the translatable strings out of a page's component tree and shows them side-by-side with the source, grouped by component. The translator's target text is kept as a per-language draft in the module's OWN key/value store — deliberately not in Canvas's auto-save store — so Canvas's "publish all" workflow can never publish a half-finished translation. Publishing writes the draft onto the target translation as a new revision (content pages) or into a language config override (content templates / page regions), leaving the source and every other translation untouched. Core's `content_translation_outdated` flag is auto-set when translatable source content changes, so translations that have drifted are flagged and the editor walks the translator through exactly what changed. An optional submodule, `canvas_translate_ai`, adds AI machine translation (via the contrib `ai` module) that pre-fills drafts for human review. Every route is gated by the `translate canvas content` permission plus per-entity update access, and every mutating endpoint requires a CSRF request-header token.

---

- Translate a Canvas page into another language side-by-side with the source, component by component.
- Open the translation workspace from the "Translate" entry in the Canvas sidebar or the Translate local task on a page.
- See a dashboard of every Canvas page × language with a status badge (not translated / draft / up to date / outdated) and a completeness percentage.
- Filter the dashboard by language or by status, or search pages by label.
- Save translation work incrementally as autosaved drafts without touching the published page.
- Copy the source value into the target field as a starting point for a translation.
- Edit rich-text (CKEditor 5) fields with the same toolbar the site's text format defines.
- Preview a page translation with the in-progress draft applied, in a themed iframe, before publishing.
- Run a draft → review → publish review pipeline: approve a reviewed draft, then batch-publish approved drafts together.
- Publish multiple languages of one page in a single new revision (all-or-nothing batch publish).
- Discard a pending draft and revert to the last published translation.
- Translate Canvas content templates and page regions as language config overrides through the same flow.
- Mark an outdated translation "reviewed" (still valid for the changed source) without rewriting its values.
- See per-field "Source was…" diffs showing what changed in the source since the translation was last published.
- Let translations fall back to the source for any prop you haven't translated, so a published page always renders fully.
- Keep required props valid: untranslated props keep their source value rather than publishing empty.
- Automatically flag translations as outdated when the source's translatable content changes in the Canvas editor.
- Detect a concurrent source edit while a translation is open (source-hash fingerprint) and prompt a refetch.
- Automatically clean up orphaned drafts when a page or config layout is deleted.
- Get a status-report warning/error when Canvas page translation is not enabled (which would otherwise overwrite the source).
- Pre-fill a translation draft with AI machine translation for human review (with the `canvas_translate_ai` submodule and a configured AI provider).
- Keep translation drafts out of Canvas's "publish all" so translators and content editors don't step on each other.
