# Diff layout plugins

Diff Plus provides two `diff` layout-builder plugins (attribute `#[DiffLayoutBuilder(...)]`, extending
`Drupal\diff\DiffLayoutBase`). They are **not** selected on a Diff Plus form — enable/order them in the
Diff module's settings at `admin/config/content/diff/settings` under the layout plugins section. Once
enabled they appear as comparison-format links on an entity's revision-diff page.

| Plugin id | Label | Source |
|---|---|---|
| `raw_html` | Raw HTML | `src/Plugin/diff/Layout/RawHtmlDiffLayout.php` |
| `visual_inline_html5` | Visual Inline (HTML5) | `src/Plugin/diff/Layout/VisualInlineHtml5DiffLayout.php` |

Both read effective settings via `getDiffSettings()` (site config + per-user `user.data` overrides when
the user has `personalize diff plus settings`).

## `raw_html`

Renders each revision, normalizes the markup, then hands both sides to client-side `diff2html`:

- `renderRevision()` calls `Html::resetSeenIds()`, optionally switches to an `AnonymousUserSession`
  (`raw_html_render_anonymously`), renders the revision via its entity view builder, then uses
  `DOMXPath` to strip `js-view-dom-id-*` classes, `data-contextual-id` elements and comments per the
  settings, and switches back.
- Emits both rendered revisions plus beautify/UI options to
  `drupalSettings.diff_plus`; JS (`js/raw-html.js`) beautifies (js-beautify), diffs (jsdiff) and
  renders side-by-side (diff2html) with highlight.js syntax coloring.
- Adds cacheable dependencies on `diff_plus.settings` and the current user.

**External assets:** the `diff_plus/raw-html` library depends on `highlightjs`, `jsbeautify`, `diffjs`
and `diff2html`, all declared in `diff_plus.libraries.yml` as **external CDN URLs** (cloudflare cdnjs
and jsdelivr). Self-hosting requires overriding those library definitions.

## `visual_inline_html5`

Produces an inline visual diff of the **rendered** revisions using `caxy/php-htmldiff`
(`diff.html_diff` service, purifier disabled):

- Renders both revisions in the chosen view mode (`?view_mode=…`, toolbar switches between all bundle
  view modes), with `in_preview = TRUE` to exclude interactive elements.
- `preprocessMarkup()` strips comments and `<script>` tags, and (when
  `visual_html5_preserve_inline_styles`) stashes each element's `style` into `data-diff-plus-style`.
- Runs `caxy` html-diff, then `Xss::filter` with an expanded allowlist (`HTML5_TAGS` + `SVG_HTML5_TAGS`
  — includes `style`, `svg`, `use`, `iframe`, `form`, `input`, `object`, `embed`, etc.), then restores
  the stashed inline styles. Output is emitted with `Markup::create()`.

Note the module author's own inline `@todo` in `build()` ("Ask the security team about whether this is
100% safe") around the `Markup::create($markup)` step. In practice the input is the entity's already
text-format-filtered rendered output, and the diff routes are gated by the Diff module's
revision-view access (editor/reviewer level), so this is by-design raw-ish HTML rendering of
editor-authored content rather than an untrusted-input sink. Sites that render low-trust user HTML
into fields and expose revision diffs to those same low-trust users should keep that trust boundary in
mind when enabling this layout.

## Access

Neither plugin adds a route. They render inside the Diff module's revision-comparison controller, so
whoever can view an entity's revision diff (per Diff + entity revision access) can view these layouts.
