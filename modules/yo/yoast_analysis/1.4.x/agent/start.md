# Yoast Analysis — agent index

Adds a per-entity "SEO Analysis" local task that runs the client-side YoastSEO.js library on an
entity rendered in the `yoast_analysis` view mode. No settings page (`configure` null), no
permission, no config schema, no Drush. Metatag is an optional soft dependency (title/description).

- **Setup: enabling analysis on a bundle via the `yoast_analysis` view mode, the route/access
  rules, the tab** → [configure/setup.md](configure/setup.md)
- **Internals for custom code: `AnalysisData`, `TextExtractor`, the `yoast_analysis` render
  element, `drupalSettings`, `Locale` mapping** → [api/internals.md](api/internals.md)

Key facts:
- Route `entity.<type>.yoast_analysis_analyse` at `/yoast_analysis/{entity_type}/{id}`, built by
  `src/Routing/RouteSubscriber.php`; requirements `_entity_access: <type>.update` +
  `_yoast_analysis_access: TRUE`.
- Access check `src/Access/AnalysisAccessCheck.php`: allowed only if a `yoast_analysis` view mode
  exists for the entity's bundle.
- Link template / tab / operation added by `src/EntityTypeInfo.php` (to every entity with a
  `canonical` link) + `Plugin/Derivative/YoastAnalysisLocalTask.php`.
- Client library `yoast_analysis/analysis` = `dist/drupal.js` (compiled YoastSEO.js) +
  `dist/drupal.css`; data passed via `drupalSettings.yoast_analysis`.
