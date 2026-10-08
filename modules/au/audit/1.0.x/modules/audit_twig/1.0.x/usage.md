Audit analyzer that scans custom Twig templates (and related preprocess/library code) for cache-bubbling and best-practice issues.

---

audit_twig registers the `twig` AuditAnalyzer plugin (TwigAnalyzer). It reads Twig templates from the scan directories and flags cache-metadata bubbling problems (raw entity/field access that breaks cache tags), Twig anti-patterns (DB queries in templates, business logic in markup), field-rendering optimization opportunities, and unmanaged external-library references in `*.libraries.yml`; informational sections cover theme suggestions and preprocess anti-patterns discovered in `.theme`/`.php`. Each check can be suppressed with an `ignore_*` flag. Detected code appears via the escaped `audit_code` component, and remediation guidance is rendered inline.

---

- Scan custom themes' Twig templates for cache-bubbling issues that break cache invalidation.
- Detect database queries or business logic embedded in templates.
- Find field-rendering patterns that bypass render caching / drupal_static optimization.
- Flag external JS/CSS libraries referenced outside Drupal's library system.
- Review theme-suggestion hooks (informational) for maintainability.
- Surface preprocess anti-patterns in `.theme`/`.module` files.
- Suppress a whole check category with `ignore_cache_analysis`, `ignore_anti_patterns`, etc.
- Use as a quality gate for AI-generated Twig that ignores cache metadata.
- Score theme-layer health as part of the overall Project Score.
- Run headless via `drush audit:run twig --filter="module:mytheme"`.
- Identify templates coupling presentation to data retrieval before a refactor.
- Get inline fix guidance (move query to preprocess) per finding.
- Audit a newly-inherited custom theme for standards violations.
- Detect unused/legacy field references in templates.
- Track theming quality across a portfolio via DruScan.
