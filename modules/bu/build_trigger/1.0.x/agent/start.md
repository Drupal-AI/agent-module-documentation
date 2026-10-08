<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Build trigger (build_trigger) — agent index

**Front-end to an external build/deploy system** for decoupled sites: trigger a build of a *build_environment* and track a *build_job*'s status.

**Version:** 1.0.x (1.0.0-alpha1). Core: `^10 || ^11`. Submodule: `build_trigger_gitlab_pipeline`.

Config entities: `build_environment` (plugin-backed) and `build_job`. Plugins (`@BuildEnvironment`): `build_hook` (HTTP request to a deploy URL) and `gitlab_pipeline` (GitLab API v4). Routes: environments admin at `/admin/config/services/build-trigger/environments` (`administer build_environment`); build jobs at `/admin/builds` and trigger/update controllers (`build trigger build`); update API at `/api/build-job/update/{build_job}` (`build trigger build`). Permissions: `administer build_environment`, `build trigger build`, `administer build_job` (restricted). GitLab creds in `build_trigger_gitlab_pipeline.settings` (`gitlab_api_token`, `gitlab_url`).

**Security:** every route including the `/api/...` update endpoint is permission-gated (`build trigger build`); no anonymous trigger. GitLab requests send the token via `PRIVATE-TOKEN` header over the configured URL; no TLS verification is disabled. Token stored in plain config (standard for the pattern).

See [configure/environments.md](configure/environments.md).