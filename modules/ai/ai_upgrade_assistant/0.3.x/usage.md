AI Upgrade Assistant is an experimental developer tool that layers OpenAI-powered code analysis on top of the Upgrade Status module to help identify and fix Drupal deprecations during upgrades.

---

AI Upgrade Assistant is a highly experimental module (its own project page warns "USE AT YOUR OWN RISK") that combines the Upgrade Status deprecation scanner with the OpenAI Chat Completions API to review module source code and suggest modernizations. It provides an admin report area under Reports, a settings form for the OpenAI API key and analysis options, and a set of services (project analyzer, batch analyzer, OpenAI client, patch generator, rollback manager) intended to scan module files, send their code to OpenAI, and propose or generate patches. It targets Drupal 9/10/11 and depends on core `system` and `update` plus the contributed `upgrade_status` module. In the 0.3.0 release much of the deeper automation (patch generation/apply, module updating, dashboard) is incomplete or not wired to routes, so the practical, working surface is the settings form, the static upgrade-command overview, and the Upgrade Status-backed report.

---

- Install alongside Upgrade Status to add AI commentary to a Drupal deprecation scan.
- Configure an OpenAI API key and model (GPT-4 / GPT-3.5 Turbo) for code analysis.
- View a report of scanned projects and their Upgrade Status error/warning counts.
- Get a static checklist of recommended composer/drush upgrade commands.
- Send a module's flagged source files to OpenAI for upgrade recommendations.
- Tune which file patterns (`*.php,*.module,*.inc,*.install`) are analyzed.
- Set excluded paths (vendor/, node_modules/, tests/) to skip during scans.
- Choose report formats (HTML, PDF, JSON) and a report output directory.
- Adjust API timeout, max retries, and batch size for analysis runs.
- Enable a mock-results mode for testing without real API calls.
- Drive analysis through Drupal's Batch API for long-running scans.
- Prioritize modules that Upgrade Status marks incompatible with newer core.
- Prototype an AI "self-healing" upgrade workflow in a throwaway dev environment.
- Explore how AI suggestions map to real deprecation fixes before applying them.
- Track per-module analysis results in Drupal state for later review.
- Review generated patch listings per module (where patch generation is available).
- Experiment with rollback/backup bookkeeping around code changes.
- Restrict access to the report area via the `access upgrade status` permission.
- Restrict settings to holders of `administer site configuration`.
- Use it as a reference implementation for integrating OpenAI with Upgrade Status.
- Estimate upgrade complexity across many contrib/custom modules at once.
