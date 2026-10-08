<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# build_hooks_circleci — agent start

Submodule of **build_hooks**. Adds two `FrontendEnvironment` plugins for **CircleCI**: `circleci` (API
v1.1, site-wide key) and `circleciv2` (API v2, per-environment token + custom pipeline parameters).
Depends on `build_hooks`. Configure route = `build_hooks_circleci.build_hooks_circle_ci_config_form`
(`/admin/config/build_hooks_circleci/buildhookscircleciconfig`) — sets the V1 key only.

- Both plugins' fields, the two API paths, and the deploy request → [configure/build_hooks_circleci.md](configure/build_hooks_circleci.md)

Key names: plugin ids `circleci` / `circleciv2`; classes `…\Plugin\FrontendEnvironment\CircleCiFrontendEnvironment`
and `…\CircleV2`; service `build_hooks_circleci.circleci_manager` (`CircleCiManager`); config
`build_hooks_circleci.settings` (`circleci_api_key`); env schemas `frontend_environment.settings.circleci`
(`project`, `branch`) and `frontend_environment.settings.circleciv2` (`project`, `reference`, `type`,
`token`, `parameters[]`).
