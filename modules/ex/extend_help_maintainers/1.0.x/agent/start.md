<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extend Help Maintainers (extend_help_maintainers) — agent index

Adds a themed **"Maintainers"** block to any module's core Help page (`help.page.<module>`), sourced from the module's `.info.yml` and/or its drupal.org project page. Version 1.0.4. Core `^10 || ^11`. No module dependencies. Package: Developer Tools. License GPL-2.0-or-later.

## How it works (one line each)
- `extend_help_maintainers.module` — `hook_help()` intercepts the `help.page` route, validates the module name (`/^[a-z0-9_]+$/`), and returns the block from `MaintainersService::buildMaintainersBlock()`. Also `hook_theme()` registers the `extend_help_maintainers` theme hook.
- `MaintainersService` (`src/Service/MaintainersService.php`) — facade: runs selected fetchers in priority order, merges DTOs, passes arrays to the builder.
- Plugin type `MaintainersFetcher` — pluggable data sources (see plugins doc).
- `MaintainersHelpBuilder` (`src/MaintainersHelpBuilder.php`) — turns maintainer arrays into a `#theme => extend_help_maintainers` render array with placeholder avatar + 1-day cache.
- `MaintainersMerger` (`src/Merge/MaintainersMerger.php`) — dedupes/merges by `Maintainer::getIdentifier()` (drupal.org username, else name) respecting priority + non-empty preference.
- `Maintainer` DTO (`src/DTO/Maintainer.php`) — value object: name, drupal_org, avatar.
- Template `templates/extend-help-maintainers.html.twig` + `css/maintainers.css` (library `extend_help_maintainers/extend_help_maintainers.maintainers`), placeholder `images/user-placeholder.svg`.

## Provides
- **Plugin type:** `MaintainersFetcher` (manager `extend_help_maintainers.maintainers_fetcher_manager`, dir `Plugin/MaintainersFetcher/`, interface `MaintainersFetcherInterface`, annotation `@MaintainersFetcher`). Ships `info_maintainers` (priority 100) and `drupal_org` (priority 10).
- **Services:** `extend_help_maintainers.maintainers_service`, `.help_builder`, `.merger`, `.maintainers_fetcher_manager`, `logger.channel.extend_help_maintainers`.
- **Route:** `extend_help_maintainers.settings` → `/admin/config/system/extend-help-maintainers` (permission `administer site configuration`).
- **Config:** `extend_help_maintainers.settings` (`selected_plugins`, `plugin_priorities`).
- **Theme hook:** `extend_help_maintainers`.
- No permissions.yml, no update hooks, no entities, no Drush commands, no composer.json.

## Solution docs
- [Configuration & settings form](config/settings.md)
- [MaintainersFetcher plugins & the fetch/merge/render pipeline](plugins/fetchers.md)
- [Declaring maintainers & extending with a custom fetcher](api/extending.md)
