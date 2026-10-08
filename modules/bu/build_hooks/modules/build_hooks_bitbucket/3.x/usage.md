<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Build Hooks that adds a **Bitbucket Pipelines** frontend-environment type: deploying the environment triggers a Bitbucket pipeline for a given repository, branch/tag, and pipeline selector via the Bitbucket 2.0 REST API.

---

Enabling `build_hooks_bitbucket` registers one `FrontendEnvironment` plugin, **`bitbucket`** ("Bitbucket Pipelines Build"). You first set a site-wide Bitbucket **username + app password** on its settings form (`/admin/config/system/build-hooks-bitbucket`, route `build_hooks_bitbucket.settings_form`, permission `administer site configuration`); these are used as HTTP Basic auth for all Bitbucket environments. Then you add a frontend environment of type *Bitbucket Pipelines Build* and fill in the repo **workspace** and **slug**, a **ref** (branch or tag) **type + name**, and a pipeline **selector** (custom or pull-request) **type + name**. On deploy, `BitbucketManager` POSTs to `https://api.bitbucket.org/2.0/repositories/{workspace}/{slug}/pipelines/` with a `pipeline_ref_target` JSON body and the stored Basic auth; only HTTP 201 counts as a successful trigger. The deploy form additionally shows a "Recent deployments" table (with an AJAX refresh button) listing the latest pipeline runs pulled from the API. The username/app-password live in `build_hooks_bitbucket.settings` config.

---

- Trigger a Bitbucket Pipelines build to rebuild/deploy a static frontend when content changes.
- Run a specific **custom** pipeline defined in `bitbucket-pipelines.yml` on deploy.
- Run a **pull-request** pipeline selector instead of a custom one.
- Build a specific **branch** (ref type `branch`).
- Build a specific **tag** (ref type `tag`).
- Point at any Bitbucket **workspace/repo** by slug.
- Reuse one set of Bitbucket credentials across several Bitbucket environments on the site.
- Show editors the latest Bitbucket pipeline runs (status/started/finished) on the deploy form.
- Refresh that recent-runs table without reloading the page (AJAX).
- Deep-link each listed run to its Bitbucket Pipelines results page.
- Combine with the `manual` strategy so releases are pushed only on demand.
- Combine with the `cron` strategy for scheduled Bitbucket rebuilds.
- Combine with the `entitysave` strategy to rebuild on every content edit.
- Run separate production vs. staging Bitbucket environments (different branches/pipelines).
- Authenticate with a scoped Bitbucket **app password** rather than an account password.
- Drive a Gatsby/Next/Hugo build hosted on Bitbucket Pipelines from Drupal editors.
- Migrate an existing Bitbucket-based frontend deploy to a one-click editor action.
