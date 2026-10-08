<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Seeds Performance is a code-free starter module that enables a curated set of performance modules (webp, ultimate_cron) in one step as part of the Seeds distribution.

---

Seeds Performance is a metapackage: it ships no PHP, no routes, no services, and no configuration of its own — its `.module` file is an empty stub. Its `seeds_performance.info.yml` simply declares dependencies on the modules that make up a performance baseline — WebP (which generates and serves WebP image derivatives) and Ultimate Cron (which gives each cron job its own schedule and controls) — so that enabling the single Seeds Performance module turns both on together. Its `composer.json` goes further and requires an additional project into the codebase, MinifyHTML (which collapses and minifies rendered HTML output), which you can then enable individually as needed. Because it is purely an aggregator, all actual behaviour, configuration, and any security surface belong to the modules it pulls in; after enabling Seeds Performance you configure each of those modules through their own admin pages. It is intended for the Seeds distribution but works on any Drupal 9, 10, or 11 site as a convenient performance starting point, provided you review the bundle and its per-module configuration for your needs.

---

- Enable a performance baseline for a Drupal 9/10/11 site in a single step.
- Pull the curated Seeds Performance module stack in via Composer with `drupal/seeds_performance`.
- Turn on WebP image conversion together with Ultimate Cron scheduling by enabling one module.
- Add WebP derivative generation so image styles serve smaller next-gen images.
- Add per-job cron scheduling and manual control via Ultimate Cron.
- Make MinifyHTML available in the codebase to enable selectively for HTML minification.
- Bootstrap the Seeds distribution's performance feature set without hand-picking each module.
- Standardise the performance module set across multiple Seeds-based sites.
- Use as an opinionated performance starter kit on a non-Seeds site.
- Ensure a consistent baseline of image optimization and cron control across environments.
- Reduce image payload sizes by adopting the WebP pipeline out of the box.
- Give operators fine-grained cron job scheduling instead of a single global cron run.
- Onboard a new project team onto a known-good performance module selection.
- Reduce setup time when scaffolding a site that needs performance tuning from day one.
- Review which performance modules are bundled before committing to the stack.
- Configure each pulled-in module through its own settings page after enabling.
- Enable MinifyHTML separately with `drush en minifyhtml` once its dependency is downloaded.
- Disable Seeds Performance after enabling the stack if you prefer not to keep the aggregator installed.
- Audit dependency versions and constraints declared in `composer.json` when planning upgrades.
- Apply the bundled WebP patch (issue #3450918) automatically via composer-patches during install.
- Keep the performance stack aligned by upgrading Seeds Performance and its dependencies together.
- Serve as documentation of the recommended performance module set for the distribution.
- Combine with other Seeds starter modules (e.g. Seeds SEO) to compose a full site profile.
- Pin the `@RC`/`@alpha` dependency constraints to stable releases for production use.
