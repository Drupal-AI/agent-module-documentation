<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Automatically adds a themed "Maintainers" block (avatars, names, drupal.org profile links) to any module's core Help page, sourced from the module's .info.yml and/or its drupal.org project page via pluggable fetchers.

---

Extend Help Maintainers hooks into core's `hook_help()` for the `help.page.<module>` route and injects a render array produced by `extend_help_maintainers.maintainers_service`. That service runs the enabled `MaintainersFetcher` plugins in priority order, merges their `Maintainer` DTOs (deduplicated by drupal.org username or name, higher-priority and non-empty values winning), and hands the result to `MaintainersHelpBuilder`, which returns a `#theme => extend_help_maintainers` block with a 1-day cache. Two fetchers ship out of the box: `info_maintainers` (priority 100) reads `extra.extend_help_maintainers.maintainers` (or a top-level `maintainers` list) from the target module's `.info.yml` and can scrape a missing avatar from the maintainer's drupal.org profile; `drupal_org` (priority 10) scrapes the maintainers block from `https://www.drupal.org/project/<module>` and caches it for 24 hours. Administrators control which fetchers run and their merge priorities from a settings form at `/admin/config/system/extend-help-maintainers` (permission `administer site configuration`); selections are stored in `extend_help_maintainers.settings`. The module has no other modules as dependencies and runs on Drupal 10 and 11. Third parties can add their own data source by implementing `MaintainersFetcherInterface` and annotating it with `@MaintainersFetcher`.

---

- Show who maintains a module directly on its admin Help page without leaving the site.
- Display maintainer avatars, names and drupal.org profile links in a styled, responsive block.
- Declare maintainers for your own custom or contrib module in its `.info.yml` under `extra.extend_help_maintainers.maintainers`.
- Fall back to a top-level `maintainers:` list in a module's `.info.yml` when the `extra` key is absent.
- Auto-fetch a maintainer's avatar from their drupal.org profile when only a `drupal_org` username is given.
- Pull maintainers automatically from a module's drupal.org project page when its `.info.yml` has none.
- Merge maintainers from multiple sources into one deduplicated list keyed by drupal.org username or name.
- Give `.info.yml`-declared maintainers precedence over drupal.org-scraped ones via the default priorities (100 vs 10).
- Re-prioritise sources per plugin from the admin settings form when you prefer drupal.org data over local `.info.yml`.
- Enable or disable individual fetcher plugins (info.yml, drupal.org) from `/admin/config/system/extend-help-maintainers`.
- Help site builders and support staff quickly identify who to contact about a module.
- Provide a consistent maintainers panel across all installed modules for organisations managing many contrib modules.
- Extend the system with a custom `MaintainersFetcher` plugin that reads maintainers from an internal directory, CSV, or private API.
- Assign a custom priority to a bespoke fetcher so it outranks or defers to the built-in sources during merge.
- Cache scraped drupal.org maintainer data for 24 hours to avoid repeated outbound requests on each Help page view.
- Show a placeholder avatar automatically when a maintainer has no picture.
- Let contrib maintainers showcase their team on their module's Help page with no code changes to the target module.
- Keep the maintainers block out of a module's Help page simply by not declaring maintainers and disabling the drupal.org fetcher.
- Invalidate a module's cached maintainers block automatically when that module is updated (cache tag `module:<name>`).
- Reset all maintainers display to defaults by uninstalling the module, which removes only its own settings config.
