<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Release Version reads a version string from a configurable environment variable and shows it in the Drupal admin toolbar (and as an optional block).

---

Release Version is a small operations utility: you point it at the name of an environment variable that your deployment pipeline sets (for example a Git tag, a build number, or a CI commit SHA), and the module surfaces that value at a glance in the admin toolbar. It ships one service (`ReleaseVersionProvider`), a `hook_toolbar()` implementation, a `release_version_version` block, and a settings form at `/admin/config/release_version/settings` where the environment-variable name is stored in the `release_version.settings` config object. The provider fires a `hook_release_version_alter` alter so other modules can transform the string before it is displayed. It depends only on core's Toolbar module and has no external services, no database tables, and no third-party libraries.

---

- Show which release/build is currently deployed, directly in the admin toolbar.
- Confirm a deploy actually landed by watching the toolbar value change after release.
- Give support and QA staff a one-glance answer to "which version is this environment on?".
- Surface a CI-provided build number (e.g. `$CI_PIPELINE_IID`) set during deployment.
- Display the Git tag or commit SHA exported by your pipeline into an environment variable.
- Distinguish staging, UAT, and production builds when they are configured with different values.
- Place the version as a block (`release_version_version`) in any region via Block layout.
- Add the version block to an admin theme sidebar or footer for operators.
- Read the version from an env var set in `.ddev/.env`, docker-compose, systemd, or the web-server config.
- Point the module at a variable your platform already exposes (Platform.sh, Pantheon, Acquia, etc.).
- Let a custom module rewrite the string via `hook_release_version_alter()` (e.g. prefix an environment name).
- Shorten a long commit SHA to 7 chars through the alter hook before display.
- Fall back gracefully: when the variable is unset the toolbar shows a translated "Version not found".
- Restrict who can change the configured variable name with the `access_release_version_settings` permission.
- Gate the settings page behind admin roles alongside core's "access administration pages".
- Enable the module only where a version indicator is useful and disable it elsewhere.
- Pair it with an environment-indicator module to label both the environment and its build.
- Automate the whole setup by exporting the env var in your deploy script and shipping the config in code.
- Translate the "Version not found" fallback and form labels via the standard interface translation.
- Cache correctly per user: the toolbar item varies by `user.permissions`.
- Keep configuration minimal — a single text field holding the environment-variable name.
