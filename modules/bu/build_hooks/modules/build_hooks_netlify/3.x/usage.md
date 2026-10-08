<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Build Hooks that adds a **Netlify** frontend-environment type: deploying the environment POSTs to a Netlify build-hook URL to start a site build, and (using a Netlify API token) shows recent Netlify deploys on the deploy form.

---

Enabling `build_hooks_netlify` registers one `FrontendEnvironment` plugin, **`netlify`**. Each Netlify environment stores a **build hook URL**, the Netlify **API ID** (site id), and a **branch**. Triggering a deploy simply POSTs (no auth) to the build-hook URL — that URL is the shared secret Netlify issues per build hook. Separately, a site-wide Netlify **personal access token** set on the settings form (`/admin/config/build_hooks_netlify/buildhooksNetlifyconfig`, route `build_hooks_netlify.build_hooks_netlify_ci_config_form`, permission `administer site configuration`) plus the environment's API ID are used only to fetch the **recent deploys** table shown on the deploy form (via `GET /sites/{api_id}/deploys?access_token=…`, filtered to the branch). `NetlifyManager` handles that fetch and date formatting. Success detection uses the base class default (HTTP 200/201). The token is stored in `build_hooks_netlify.settings`.

---

- Trigger a Netlify site build to deploy a static frontend when Drupal content changes.
- Fire a Netlify **build hook** URL with a simple unauthenticated POST.
- Associate each environment with a Netlify **site (API ID)**.
- Filter the recent-deploys view to a specific **branch**.
- Show editors the latest Netlify deploys (state, started, finished, error message) on the deploy form.
- Refresh that recent-deploys table without reloading (AJAX).
- Reuse one site-wide Netlify API token across all Netlify environments.
- Combine with the `manual` strategy for on-demand releases.
- Combine with the `cron` strategy for scheduled Netlify rebuilds.
- Combine with the `entitysave` strategy to rebuild on every content edit.
- Run separate production/staging Netlify environments (different sites/branches).
- Drive a Gatsby/Next/Hugo/Eleventy site hosted on Netlify from Drupal editors.
- Give editors a one-click deploy instead of sharing the raw Netlify build-hook URL.
- Read the Netlify API token from an environment variable via a `settings.php` override (recommended).
- Surface Netlify build **error messages** to editors right in Drupal.
- Support a content-preview branch that rebuilds independently of production.
