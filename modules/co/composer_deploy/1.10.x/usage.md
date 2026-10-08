Composer Deploy restores version numbers to Composer-managed Drupal sites so the Available Updates report and Update Status show the correct release for each module and theme.

---

When a site installs contrib via Composer instead of the Drupal.org tarball, extension `.info.yml` files often ship without the `version`, `datestamp`, and `project` lines the Drupal.org packaging script normally adds — so core's Update module reports "Unknown" or no version at all. Composer Deploy fixes this by implementing `hook_system_info_alter()`: for any extension whose `version` is still empty, it looks the package up in `vendor/composer/installed.json` (via `webflo/drupal-finder`), matching first by install path and then by package name, and injects `version` (from `extra.drupal.version`, or a `-dev` string for dev branches), `datestamp`, `project`, and a `composer_deploy_git_hash` taken from the package's `source.reference`. It also enhances the Available Updates report by adding a "Diff" link to each listed release (comparing your installed git reference against the upstream tag on git.drupalcode.org) through a `preprocess_update_project_status` hook, a `theme_registry_alter`, and a small Twig extension that overrides core's `update-version` template. The only configuration is `composer_deploy.settings:prefixes`, a list of Composer vendor prefixes (default `['drupal']`, with `drupal` always forced in) used when matching a package by name. Packages of Composer type `metapackage` are skipped, since submodule metapackages carry no real version. It is essentially read-only: it never writes to the packages or the filesystem, it only alters the in-memory extension info Drupal already computed.

---

- Show correct module/theme versions on `admin/reports/updates` for a Composer-managed site
- Fix "Unknown" or blank versions in the Update Status report when `.info.yml` has no `version` line
- Report a readable `x.y.z-dev` version for modules installed from a Composer `dev-` branch
- Surface the exact deployed git commit of each extension via the injected `composer_deploy_git_hash`
- Let core's update checker compare installed vs. available releases so security update warnings work
- Add a "Diff" link on the updates report to review upstream changes between your commit and a new tag
- Populate the `project` info key so core groups a project's modules/themes correctly on the updates report
- Provide a `datestamp` for extensions so "last updated" info renders on the update report
- Support monorepo/custom forks by adding your own vendor prefix (e.g. `mycompany`) to `prefixes`
- Keep the update report accurate on CI/CD pipelines that deploy from `composer install` artifacts
- Avoid manually editing `.info.yml` files to hard-code versions after every deployment
- Recognize dev snapshots pinned to a specific commit and show the commit hash as the current version
- Detect the deployed version of a module installed with `composer require drupal/foo:dev-2.x`
- Feed accurate version data to other modules/tools that read extension info (e.g. reporting dashboards)
- Skip metapackage submodules (like split LDAP submodules) that legitimately have no version
- Match a package by its install path first, so renamed/relocated packages still resolve to the right version
- Restore version reporting for themes as well as modules on Composer sites
- Confirm a production deploy shipped the intended commit by reading the hash off the extension info
- Give site owners confidence that "no updates available" reflects the true installed versions
- Work across Composer 1 and Composer 2 `installed.json` layouts automatically
- Run with zero configuration out of the box on the common `drupal/*` vendor layout
