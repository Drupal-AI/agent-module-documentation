[DEV ONLY] Detects copy-paste code clones across PHP/Twig/JS/CSS in custom code via jscpd.

---

Experimental, dev-only analyzer `duplication` (`DuplicationAnalyzer`, weight 3). It shells out to the `jscpd` npm binary (Symfony Process, array argv) over the configured `scan_directories`, reads jscpd's JSON report, and reports duplicated code clones, a per-language duplication breakdown, and an overview. Clone detection thresholds (`min_lines` 5, `min_tokens` 50), the languages scanned (`format_php/twig/javascript/css`), and the display cap (`max_clones_display` 50) are configurable. `checkRequirements()` warns when jscpd is not installed.

---

- Find copy-paste clone pairs across custom modules and themes.
- Break duplication down by language (PHP, Twig, JS, CSS).
- Tune sensitivity via `min_lines` (5) and `min_tokens` (50).
- Enable/disable languages with `format_php` / `format_twig` / `format_javascript` / `format_css`.
- Cap the report with `max_clones_display` (50).
- Install jscpd globally (`npm install -g jscpd`); a requirements warning shows otherwise.
- Filter clones to one module: `drush audit:run duplication --filter="module:mymodule"`.
- Dev/staging only — not for production.
