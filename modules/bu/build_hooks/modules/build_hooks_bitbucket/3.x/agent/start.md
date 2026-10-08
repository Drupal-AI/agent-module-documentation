<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# build_hooks_bitbucket — agent start

Submodule of **build_hooks**. Adds one `FrontendEnvironment` plugin, **`bitbucket`**, that triggers a
**Bitbucket Pipelines** run via the Bitbucket 2.0 REST API. Depends on `build_hooks`. Configure route =
`build_hooks_bitbucket.settings_form` (`/admin/config/system/build-hooks-bitbucket`).

Two-part setup: site-wide **username + app password** (HTTP Basic auth) on the settings form, then a
per-environment repo/ref/pipeline selector on the environment's plugin form.

- Credentials, environment fields, and the deploy request → [configure/build_hooks_bitbucket.md](configure/build_hooks_bitbucket.md)

Key names: plugin id `bitbucket`; plugin class
`Drupal\build_hooks_bitbucket\Plugin\FrontendEnvironment\BitbucketFrontendEnvironment`; service
`build_hooks_bitbucket.bitbucket_manager` (`BitbucketManager`); config `build_hooks_bitbucket.settings`
(`username`, `password`); env settings schema `frontend_environment.settings.bitbucket`
(`repo.workspace`, `repo.slug`, `ref.type`, `ref.name`, `selector.type`, `selector.name`). Success =
HTTP 201.
