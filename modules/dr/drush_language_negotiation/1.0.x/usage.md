<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds one language-negotiation method that forces the site's default language whenever code runs under the command line (Drush/CLI), so Drush operations stop resolving to English on non-English sites.

---

On multilingual sites Drush can resolve the wrong interface/content language during CLI runs (the classic symptom: `drush config:import` treating a Dutch-default site as English). This module ships a single core language-negotiation plugin, `LanguageNegotiationDrush` (id `language-drush`), whose `getLangcode()` returns the site default language id when `PHP_SAPI === 'cli'` and `NULL` otherwise. Because it returns `NULL` for every non-CLI request, ordinary web/browser traffic is completely unaffected and keeps its normal negotiation. The plugin is defined with a very high priority (`weight = -99`), and you activate and order it on Drupal core's existing detection page at `/admin/config/regional/language/detection` — the module has no settings form, routes, permissions, services, config, hooks, or Drush commands of its own. It targets the `@LanguageNegotiation` plugin type provided by core's Language module (so that module must be enabled for the method to appear), and supports Drupal 8, 9, 10, and 11.

---

- Fix `drush config:import` importing config in the wrong language on a non-English-default site.
- Ensure `drush config:export` writes config against the intended default language.
- Make Webform (or other config-heavy) config imports respect the site default language under Drush.
- Force the correct language for content generated via `drush` (e.g. Devel Generate, custom generation scripts).
- Keep cron-triggered work run through `drush cron` using the site default language.
- Correct language context for custom Drush commands that create or update translatable entities.
- Stabilise language for migration runs (`drush migrate:import`) that would otherwise default to English.
- Ensure scripted content updates (`drush php:eval`, `drush php:script`) resolve to the default language.
- Guarantee CLI batch/queue processing uses the default language rather than English fallback.
- Prevent translation tasks executed via Drush from being attributed to the wrong source language.
- Provide deterministic language selection in CI pipelines that run Drush commands.
- Avoid mismatched language during automated deployment steps that import configuration.
- Make `drush locale:*` and string-import workflows operate under the intended default language.
- Ensure entity CRUD performed in CLI hooks/scripts stores values against the correct langcode.
- Normalise language for scheduled maintenance scripts executed on the command line.
- Keep default-language behavior consistent across `ddev drush` invocations on local/dev sites.
- Serve as a lightweight alternative to hard-coding a language switch in custom Drush command code.
- Leave front-end language negotiation untouched while only correcting the CLI context.
- Give agents/tooling a predictable language when driving the site through Drush.
- Support long-lived Drupal 8/9/10/11 sites that need the same CLI-language fix across upgrades.
