<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Build Hooks that connects frontend environments to **CircleCI**, so deploying an environment triggers a CircleCI build/pipeline. It ships two plugins: `circleci` (API v1.1) and `circleciv2` (API v2, with custom pipeline parameters).

---

Enabling `build_hooks_circleci` registers two `FrontendEnvironment` plugins. **`circleci` (V1)** uses a **site-wide API key** set on the settings form (`/admin/config/build_hooks_circleci/buildhookscircleciconfig`, route `build_hooks_circleci.build_hooks_circle_ci_config_form`, permission `administer site configuration`) and, per environment, a `project` (`org/repo`) and `branch`; on deploy `CircleCiManager` POSTs to CircleCI API v1.1 (`project/github/{project}/build`) with the key passed as the `?circle-token=` URL query parameter. **`circleciv2` (V2)** stores its **token per environment** (not site-wide), plus `project` (`organisation/repository`), a `branch`/`tag` reference, and a table of arbitrary typed **parameters** (string/boolean/integer) sent to the pipeline; on deploy it POSTs to API v2 (`project/gh/{project}/pipeline`) using the token as HTTP Basic auth, and the deploy form lists the last 5 workflow runs with status and links. The V1 API key and V2 token are stored in config.

---

- Trigger a CircleCI build to rebuild/deploy a static frontend when Drupal content changes.
- Use CircleCI API **v2** pipelines with the `circleciv2` plugin (recommended for new setups).
- Use legacy CircleCI API **v1.1** builds with the `circleci` plugin.
- Build a specific **branch** on CircleCI.
- Build a specific **tag** (v2 reference type `tag`).
- Pass custom **string** pipeline parameters to a CircleCI pipeline (v2).
- Pass **boolean** pipeline parameters (enter `0` for false) (v2).
- Pass **integer** pipeline parameters (v2).
- Add/remove parameter rows dynamically in the environment form (AJAX) (v2).
- Target any CircleCI project by `org/repo` slug.
- Store the V2 token per environment so different environments use different CircleCI tokens.
- Share one site-wide API key across all V1 CircleCI environments.
- Show editors the last recent CircleCI workflow runs (status + link) on the deploy form (v2).
- Refresh that recent-runs table without reloading (AJAX) (v2).
- Combine with the `manual` strategy for on-demand releases.
- Combine with the `cron` strategy for scheduled CircleCI rebuilds.
- Combine with the `entitysave` strategy to rebuild on every content edit.
- Run separate production/staging CircleCI environments (different branches/projects).
- Read the V1 key from an environment variable via a `settings.php` config override (recommended).
- Drive a Gatsby/Next/Hugo pipeline hosted on CircleCI from Drupal editors.
