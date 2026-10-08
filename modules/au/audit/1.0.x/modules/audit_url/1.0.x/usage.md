Audit analyzer that detects URL-routing problems: redirect loops, broken targets, alias collisions and route shadowing.

---

audit_url registers the `url` AuditAnalyzer plugin (UrlAnalyzer). It detects the core Path Alias and contrib Redirect modules at runtime and only runs the applicable check groups. It analyzes redirect chains/loops, broken or non-resolving redirect targets, alias collisions (two aliases resolving to conflicting system paths), and aliases that shadow real routes. Findings are grouped into scored sections plus an informational overview. Ships no config of its own; warns if neither Redirect nor Path Alias is enabled.

---

- Detect redirect loops that would trap visitors and crawlers.
- Find redirects pointing at broken or non-existent targets.
- Identify URL-alias collisions that resolve ambiguously.
- Catch aliases that shadow real Drupal routes (masking pages).
- Only run applicable checks based on whether redirect/path_alias are enabled.
- Audit a migrated site for inherited redirect/alias problems.
- Score URL-routing health as part of the overall Project Score.
- Run headless via `drush audit:run url --format=json`.
- Include URL hygiene in a takeover audit of an unfamiliar site.
- Surface remediation guidance per detected routing issue.
- Verify a large redirect table has no chains exceeding a safe depth.
- Track URL-routing quality across a portfolio via DruScan.
- Fail a launch check when redirect loops exist.
- Provide an overview of aliases and redirects at a glance.
- Skip gracefully when neither redirect nor path_alias is installed.
