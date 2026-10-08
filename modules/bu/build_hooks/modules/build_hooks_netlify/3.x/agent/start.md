<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# build_hooks_netlify — agent start

Submodule of **build_hooks**. Adds one `FrontendEnvironment` plugin, **`netlify`**. Deploy = a plain
(no-auth) POST to the environment's Netlify **build-hook URL**; a site-wide Netlify API token is used
only to list recent deploys on the deploy form. Depends on `build_hooks`. Configure route =
`build_hooks_netlify.build_hooks_netlify_ci_config_form`
(`/admin/config/build_hooks_netlify/buildhooksNetlifyconfig`).

- Token, environment fields, deploy request, recent-deploys fetch → [configure/build_hooks_netlify.md](configure/build_hooks_netlify.md)

Key names: plugin id `netlify`; class
`Drupal\build_hooks_netlify\Plugin\FrontendEnvironment\NetlifyFrontendEnvironment`; service
`build_hooks_netlify.netlify_manager` (`NetlifyManager`); config `build_hooks_netlify.settings`
(`netlify_api_key`); env schema `frontend_environment.settings.netlify`
(`build_hook_url`, `api_id`, `branch`). Success = base default (HTTP 200/201).
