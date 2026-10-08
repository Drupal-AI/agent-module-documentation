<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ab_test` paragraph bundle, its fields, rendering, and session-selection JS

There is **no plugin class** here — the "A/B test" is a Paragraphs bundle plus module hooks.
Files: `ab_paragraphs.install`, `ab_paragraphs.module`, `templates/paragraph--ab-test.html.twig`,
`js/ab_test.js`, `css/ab_test.css`.

## Bundle + fields (created in `ab_paragraphs_install()`)

`ParagraphsType::create(['id' => 'ab_test', 'label' => 'A/B Test'])`, then for each field a
`FieldStorageConfig` (if absent) and a `FieldConfig` on `paragraph.ab_test`:

| Field | Type | Notes |
|---|---|---|
| `field_variant_a` | entity_reference_revisions | target_type paragraph, handler `default:paragraph` — nested paragraphs = Variant A |
| `field_variant_b` | entity_reference_revisions | same — Variant B |
| `field_tracking_code_a` | text_long | tracking snippet for A (README: use Plain-text multi-line widget) |
| `field_tracking_code_b` | text_long | tracking snippet for B |
| `field_unique_id` | string (max 128) | experiment id, used as analytics label + sessionStorage key |
| `field_distribution` | list_string | allowed: `50/50`, `90/10`, `10/90`, `70/30`, `30/70` (default logic falls back to 50/50) |

Fields are **not added to any display** by install — you must enable them on the ab_test
form/view displays manually (README + `hook_requirements`). `hook_requirements($phase==='runtime')`
loads each `paragraph.ab_test.<field>` `FieldConfig` and emits `REQUIREMENT_WARNING` listing any
missing field.

## Rendering (`ab_paragraphs_preprocess_paragraph`)

Runs only for `Paragraph` entities of bundle `ab_test`. It:
1. Reads `field_tracking_code_a/b` and applies **`strip_tags()`**; reads `field_unique_id` and
   `field_distribution` (default `'50/50'`).
2. Uses the `paragraph` view builder to render each referenced entity of variant A and B into
   **render arrays** (not HTML strings — keeps lazy-loading/responsive images/behaviors).
3. Builds `content.ab_test_output`: a `container` with `data-uuid`, `data-distribution`,
   `data-paragraph-id`; nested `a`/`b` containers each classed `ab-variant ab-variant-{a,b}
   hidden-ab-variant` with a `data-tracking-code` attribute holding the stripped snippet.
4. Attaches library `ab_paragraphs/ab_test`, adds cache tag `paragraph:<id>` (no `max-age=0` —
   selection is client-side so the markup is cacheable), and `unset()`s the six raw fields from
   `$variables['content']` so only the wrapper shows.

`hook_theme` registers `paragraph__ab_test` → `templates/paragraph--ab-test.html.twig` (prints
`content.ab_test_output`), and `hook_theme_suggestions_paragraph_alter` adds that suggestion for
the bundle.

## Front-end selection (`js/ab_test.js`, `Drupal.behaviors.abTest`)

Per `.ab-test-wrapper` (guarded by `once('ab-test', …)`):
- `sessionKey = 'ab_variant_' + uuid`. If `sessionStorage` has no value, split
  `distribution` on `/`, take the first number as `threshold`, roll `Math.random()*100`, pick
  `'a'` if `rand < threshold` else `'b'`, and persist it. Otherwise reuse the stored variant.
- Add `hidden-ab-variant` to both variants, remove it from the chosen one (CSS in
  `css/ab_test.css` hides `.hidden-ab-variant`).
- If `hasAnalyticsConsent()` **and** `hasAnalyticsTracker()`, call `trackEvent('A/B Test', 'Show',
  '<uuid> - Variant X', 1)`.
- If the chosen variant's `data-tracking-code` is non-empty, delegate `click` on its `a` elements
  to fire `trackEvent('A/B Test', 'Click', '<href> - <uuid> - Variant X', 1)`.

Note: the tracking-code field value is used **only as a boolean flag** to decide whether to attach
the click handler — its contents are never `eval`'d or injected as a `<script>`. `trackEvent`
dispatches to Matomo/Piwik `_paq`, Piwik Pro `ppms.cm.api`, GA `gtag`, or GTM `dataLayer`,
whichever exists. `hasAnalyticsConsent()` checks Cookiebot / Klaro / `window.CookieConsent`
(Osano) / a custom `window.myCookieConsent.analyticsAllowed`, defaulting to `true` when none is
present. A `debugMode` flag (`drupalSettings.abParagraphsSettings.debug`) gates console logging.

## Uninstall (`ab_paragraphs_uninstall`)

Warns the admin, then loads every `paragraph` of type `ab_test`, recursively deletes nested
`entity_reference_revisions`→paragraph children via `ab_paragraphs_delete_nested_paragraphs()`,
deletes the paragraphs, deletes the six FieldConfig+FieldStorageConfig, and deletes the ab_test
ParagraphsType.
