<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# build_hooks_github — agent start

Submodule of **build_hooks**. Adds one `FrontendEnvironment` plugin, **`github`**, that triggers a
**GitHub** workflow by POSTing to a per-environment build-hook/dispatch URL with an
`Authorization: token <PAT>` header and body `{"ref":"<branch>"}`. Depends on `build_hooks`. Configure
route = `build_hooks_github.build_hooks_github_ci_config_form`
(`/admin/config/build_hooks_github/buildhooksGithubconfig`).

Setup: site-wide personal access token on the settings form; per-environment `build_hook_url` + `branch`.

- Token, environment fields, and the deploy request → [configure/build_hooks_github.md](configure/build_hooks_github.md)

Key names: plugin id `github`; class
`Drupal\build_hooks_github\Plugin\FrontendEnvironment\GithubFrontendEnvironment`; config
`build_hooks_github.settings` (`github_access_token`); env schema `frontend_environment.settings.github`
(`build_hook_url`, `branch`). No manager service, no recent-builds table. Success = base default
(HTTP 200/201).
