Diff Plus adds opinionated extensions to the contrib Diff module: two extra revision-comparison layout plugins ("Raw HTML" and "Visual Inline (HTML5)"), a refreshed diff UI header, and — unusually — per-user personalization of most settings so each editor can tune their own diff experience.

---

The module requires `drupal/diff` (^2.0) and the `caxy/php-htmldiff` library plus `ext-dom`. It ships two `diff` Layout Builder plugins: **`raw_html`** renders each revision's HTML, normalizes it (optionally rendering as an anonymous user, stripping `js-view-dom-id-*` classes, contextual links and comments), beautifies it and shows a side-by-side source diff powered by CDN-loaded `diff2html`, `jsdiff`, `js-beautify` and `highlight.js`; **`visual_inline_html5`** produces an inline visual diff via `caxy/php-htmldiff` with an HTML5/SVG-aware `Xss::filter` allowlist and view-mode switching. A KernelEvents::VIEW subscriber (`DiffControllerAlterSubscriber`) detects diff routes and, when `enhance_diff_ui` is on, replaces the stock diff header with a themed `diff_plus_ui` block (revision authors, moderation/publish status, prev/next revision links, version-history link). Settings default in `config/install/diff_plus.settings.yml`; two forms edit them — `DiffPlusDefaultSettingsForm` (site defaults, permission `administer site configuration`) and `DiffPlusUserSettingsForm` (personal overrides, permission `personalize diff plus settings`), the latter stored in `user.data` and merged over the defaults at render time. Two theme negotiators force the site default theme for `raw_html` and `visual_inline_html5` diff routes. Highlight themes are chosen from a very large bundled list of highlight.js stylesheet names. All access is inherited from the Diff module's revision routes; Diff Plus adds no new front-end route.

---

- Compare two content revisions as a beautified, side-by-side raw-HTML source diff.
- Compare two revisions as an inline visual diff that shows the rendered content with changes highlighted.
- Switch the visual diff between the entity's view modes (default, teaser, etc.) from the diff toolbar.
- Give editors a modernized diff header with revision authors, statuses and navigation links.
- Show each revision's moderation state (via Content Moderation) or published/unpublished status in the diff header.
- Step to the previous/next consecutive revision pair directly from the diff view.
- Let individual users personalize their own diff experience without changing site defaults.
- Set site-wide default Diff Plus behavior on the default-settings admin form.
- Render revisions as an anonymous user during raw-HTML diffing to avoid false positives from per-user markup.
- Strip contextual links from rendered content before diffing to reduce noise.
- Strip `js-view-dom-id-*` Views classes that otherwise cause spurious diffs.
- Strip HTML comments from content before comparison.
- Control raw-HTML beautifier indentation size, line-wrap length and newline preservation.
- Pick a syntax-highlighting theme for the raw-HTML diff from a large highlight.js style list.
- Preserve inline CSS styles through the HTML5 visual diff's XSS filtering.
- Provide a consistent diff theme by forcing the site default theme on diff routes.
- Offer a cleaner revision-review workflow for editorial teams using core/contrib Diff.
- Diff Layout Builder-driven pages using the raw-HTML or visual layouts.
- Reduce false-positive diffs caused by dynamic markup (view DOM ids, contextual links, comments).
- Let reviewers jump straight to a specific revision or the full version history from the diff page.
- Tune the diff comparison per editor role by granting or withholding the personalization permission.
