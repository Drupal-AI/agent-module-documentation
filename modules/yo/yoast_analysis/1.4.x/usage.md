Yoast Analysis adds a per-entity "SEO Analysis" tab that runs the client-side YoastSEO.js text-analysis and assessment library against an entity's rendered content, showing a live SEO/readability score, a Google-style snippet preview, and a focus-keyword field.

---

The module hooks every entity type that has a `canonical` link (`hook_entity_type_alter` → `EntityTypeInfo`), giving it a `yoast-analysis-analyse` link template at `/yoast_analysis/{entity_type}/{id}` and adding the analysis as a local task tab and an entity operation. The route is registered dynamically by `RouteSubscriber` and guarded by two requirements: core `_entity_access: <type>.update` (so only users who can edit the entity see it) **and** a custom `_yoast_analysis_access` check that only allows the route when a view mode named `yoast_analysis` exists for that entity's bundle. On the tab, `AnalysisController` renders a `yoast_analysis` render element seeded with `AnalysisData::fromEntity()`: `TextExtractor` renders the entity in the `yoast_analysis` view mode to HTML and pulls title/description from Metatag (if installed), and `Url`/`Locale` derive the base URL, path, and a YoastSEO locale. That data is attached as `drupalSettings.yoast_analysis.container_settings[...]` and the `yoast_analysis/analysis` library (bundled `dist/drupal.js`, the compiled YoastSEO.js) performs the analysis entirely in the browser, updating output and the snippet preview as the editor types a keyword. Setup is just: enable the module and enable/configure the `yoast_analysis` view mode on the bundles you want analysed (which fields feed the analysis is controlled by that view-mode display). No settings page, permission, config schema, or Drush command; Metatag is an optional soft dependency for the title/description.

---

- Give content editors a live Yoast-style SEO score while reviewing a node.
- Show a Google-style snippet preview (title, URL, meta description) for an entity.
- Let editors enter a focus keyword and see keyword-based SEO assessments update live.
- Run readability analysis (sentence length, passive voice, etc.) on article body content.
- Add an "SEO Analysis" tab to nodes, taxonomy terms, or any entity with a canonical URL.
- Control exactly which fields are analysed by configuring the `yoast_analysis` view mode display.
- Restrict SEO analysis to editors by relying on the entity `update` access requirement.
- Enable analysis only on chosen bundles by enabling the `yoast_analysis` view mode per bundle.
- Pull the analysed title and meta description from Metatag-configured values.
- Localize the YoastSEO assessments to the entity's language via the built-in locale mapping.
- Provide SEO feedback without sending content to any external service (analysis is client-side).
- Surface an "SEO Analysis" entity operation link in admin content lists.
- Audit an existing page's content against SEO best practices before publishing.
- Preview how a page's title/description will look in search results.
- Help non-SEO-expert authors improve content structure and keyword usage.
- Use a dedicated view mode to strip out non-content fields (blocks, admin fields) from analysis.
- Give a multilingual site per-language SEO analysis on each translation.
- Add SEO coaching to custom entity types by adding a canonical link + `yoast_analysis` view mode.
- Integrate SEO scoring into an editorial workflow as a manual review step.
- Extend or reuse `AnalysisData`/`TextExtractor` to feed custom text into the Yoast library.
