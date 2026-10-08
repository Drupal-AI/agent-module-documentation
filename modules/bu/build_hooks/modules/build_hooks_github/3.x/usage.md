<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Build Hooks that adds a **GitHub** frontend-environment type: deploying the environment POSTs to a GitHub build-hook/dispatch URL (authenticated with a personal access token) to trigger a workflow that rebuilds/deploys the frontend.

---

Enabling `build_hooks_github` registers one `FrontendEnvironment` plugin, **`github`**. You set a site-wide GitHub **personal access token** on the settings form (`/admin/config/build_hooks_github/buildhooksGithubconfig`, route `build_hooks_github.build_hooks_github_ci_config_form`, permission `administer site configuration`). Each GitHub environment stores a **build hook URL** and a **branch**. On deploy the plugin POSTs to that URL with `Content-Type: application/json`, an `Authorization: token <PAT>` header, and body `{"ref":"<branch>"}` — matching GitHub's REST dispatch pattern. Unlike the Bitbucket/CircleCI/Netlify submodules there is no manager service and no recent-builds table; it is a thin authenticated POST. Success uses the base class default (HTTP 200/201). The PAT is stored in `build_hooks_github.settings`.

---

- Trigger a GitHub Actions workflow to rebuild/deploy a static frontend on content change.
- Fire a `repository_dispatch`/workflow-dispatch endpoint from Drupal editors.
- Pass the target **branch** as the `ref` in the request body.
- Authenticate to the GitHub API with a **personal access token**.
- Point each environment at its own GitHub build-hook/dispatch **URL**.
- Reuse one site-wide PAT across all GitHub environments.
- Combine with the `manual` strategy for on-demand releases.
- Combine with the `cron` strategy for scheduled GitHub rebuilds.
- Combine with the `entitysave` strategy to rebuild on every content edit.
- Run separate production/staging GitHub environments (different branches/URLs).
- Drive a Gatsby/Next/Hugo build hosted on GitHub Actions from Drupal.
- Give editors a one-click deploy instead of manually dispatching a workflow.
- Trigger a Pages or artifact-publishing workflow after editorial changes.
- Read the PAT from an environment variable via a `settings.php` config override (recommended).
- Use a fine-grained/scoped GitHub token limited to the target repository.
- Show the queued content changelog (from the parent module) before dispatching the workflow.
