<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Dev (drutopia_dev) — agent index

Helper module for developers and feature builders of the **Drutopia** distribution. It has no `src/` classes; its behavior comes from a dependency chain, a Features bundle, an installed Search API index, and a standalone dev script.

- **Version:** 2.0.x (documented from a **dev checkout** — `drutopia_dev.info.yml` has no packaged `version:`) · **Core:** `^10.2 || ^11 || ^12` · **Package:** Drutopia · **License:** GPL-2.0-or-later
- **Not covered by the security advisory policy** (`security_advisory_coverage: not-covered`); part of the Drutopia distribution, meant for dev/staging.

## What it actually ships

- **No routes, permissions, services, hooks, plugins, or Drush commands.** No `*.module`, `*.routing.yml`, `*.permissions.yml`, `*.services.yml`, `src/`, or `config/schema/`.
- **Dependencies** (`drutopia_dev.info.yml`): `devel`, `entity_clone`, `node`, `user`, `search_api`, and the full Drutopia set — `drutopia_core`, `drutopia_search`, `drutopia_article`, `drutopia_blog`, `drutopia_campaign`, `drutopia_comment`, `drutopia_event`, `drutopia_group`, `drutopia_home_page`, `drutopia_landing_page`, `drutopia_page`, `drutopia_people`, `drutopia_related_content`, `drutopia_resource`, `drutopia_seo`, `drutopia_site`, `drutopia_social`, `drutopia_storyline`, `drutopia_user`. Composer `require` (from `composer.json`): `drupal/drutopia_core ^2`, `drupal/devel ^5`, `drupal/drutopia_search ^2`, `drupal/entity_clone ^2`.
- **Config it installs** (`config/install/`): the `drutopia` Features bundle (`features.bundle.drutopia.yml`) and a template Search API index **`dev_node`** (`search_api.index.dev_node.yml`, server `database`) → see [config/bundle-and-index.md](config/bundle-and-index.md).
- **Features marker** (`drutopia_dev.features.yml`): `bundle: drutopia`, `required: true`.
- **Standalone dev script**: `scripts/git-clone-origin-for-drutopia-projects.php`, a manually-run CLI helper that rewrites git remotes of cloned `drutopia*` modules → see [scripts/git-clone-origin.md](scripts/git-clone-origin.md).
- **Submodule:** `drutopia_dev_findit` (documented at `../modules/drutopia_dev_findit/2.0.x/`).

## Operate it

Enable on a development or staging environment to bring in the toolkit and the bundle/index; it has no configuration form of its own (`configure: null`). Each dependency (Devel, Entity Clone, the Drutopia features) is configured through its own admin pages. Uninstall the single module to remove the dev toolkit before deploying. See [config/bundle-and-index.md](config/bundle-and-index.md) for install details.
