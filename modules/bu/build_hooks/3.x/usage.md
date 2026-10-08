<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Build Hooks lets editors trigger a rebuild ("build hook") of one or more externally-hosted frontends from inside Drupal, when Drupal is used as the content source for a decoupled/static site (Gatsby, Next, Netlify, etc.). It tracks which content changed since the last deploy per environment and can fire the deploy manually, on cron, or automatically on every content save.

---

You model each deploy target as a **frontend_environment** config entity. That entity names a **FrontendEnvironment plugin** — the base module ships only `generic`, which simply POSTs to a build-hook URL you paste in; provider submodules (`build_hooks_bitbucket`, `build_hooks_circleci`, `build_hooks_github`, `build_hooks_netlify`) each add a plugin that talks to that provider's CI/deploy API. Each environment also has a **deployment_strategy**: `manual` (only via the deploy button), `cron` (fired from `hook_cron`), or `entitysave` (fired on every insert/update/delete of a loggable entity). On the **settings form** (`/admin/config/build_hooks/settings`, route `build_hooks.hook_form`) you pick which entity types are "loggable"; whenever one of those changes, a per-environment **build_hooks_deployment** content entity records it (a revisionable changelog of created/updated/deleted items) and the admin **toolbar** shows a per-environment change counter. Clicking the toolbar item opens the **deployment form** (`/admin/build_hooks/deployments/{frontend_environment}`, permission `trigger deployments`) where a privileged user reviews the changelog and presses deploy. The `build_hooks.trigger` service then asks the plugin for a `BuildHookDetails` (url + HTTP method + Guzzle options) and makes the request; a `BuildTrigger` event fires first (a subscriber may cancel) and a `ResponseEvent` fires with the provider's response. Two permissions gate the module: `manage frontend environments` and `trigger deployments`. Provider credentials are stored in each submodule's own `*.settings` config.

---

- Trigger a Netlify/Gatsby/Next static-site rebuild from Drupal after editors publish content.
- Give editors a one-click "Deploy" button in the admin toolbar instead of sharing a raw build-hook URL.
- Show editors exactly which nodes/media changed since the last production deploy, per environment.
- Auto-deploy the frontend on cron (e.g. batch nightly rebuilds) via the `cron` deployment strategy.
- Auto-deploy on every content save via the `entitysave` deployment strategy for near-real-time sites.
- Restrict logging to only the entity types that actually appear on the frontend (e.g. `node`, `media`).
- Run several frontend environments (production, staging, preview) each with its own build hook and strategy.
- Use the `generic` plugin to fire any provider that exposes a simple POST build-hook URL.
- Fire a Bitbucket Pipelines custom or pull-request pipeline for a given branch/tag (submodule).
- Fire a CircleCI v2 pipeline with custom string/boolean/integer parameters (submodule).
- Trigger a GitHub Actions `repository_dispatch`/workflow via a build-hook URL + token (submodule).
- Kick a Netlify build hook and list recent Netlify deploys inline on the deploy form (submodule).
- Review recent provider builds (status/started/finished) right on the deployment form before deploying again.
- Gate deploy rights with the `trigger deployments` permission so only release managers can push.
- Gate environment configuration with the `manage frontend environments` permission separate from deploying.
- Cancel or short-circuit a build programmatically by subscribing to the `BuildTrigger` event.
- Observe/log provider responses by subscribing to the `ResponseEvent`.
- Add support for a new CI/host by implementing your own `FrontendEnvironment` plugin.
- Alter or remove existing environment plugin definitions via `hook_build_hooks_frontend_environment_info_alter()`.
- Add per-environment extra fields to the deploy form (e.g. a build parameter) from a plugin's `getAdditionalDeployFormElements()`.
- Track a full revision history of deployments (who deployed, when, and what content was included).
- Drive deployments entirely from config by exporting `frontend_environment.*` config entities between sites.
- Keep the toolbar change-counter accurate via the module's `build_hooks_toolbar` cache tag invalidation.
- Trigger builds programmatically from custom code by calling `build_hooks.trigger`'s `triggerBuildHookForEnvironment()`.
- Support content-preview workflows where a preview environment rebuilds on draft save while production stays manual.
