<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Dashboard turns Drupal's **Admin → Configuration → AI** page (`/admin/config/ai`) into a single landing dashboard for the [drupal/ai](https://www.drupal.org/project/ai) ecosystem: from one screen a site builder can add an AI provider + API key, see operational status, browse recommended AI recipes, jump to AI config links, and open documentation.

---

The module ships no route of its own. Instead a `RouteSubscriber` hijacks AI Core's existing `ai.settings.menu` route (path `/admin/config/ai`, permission `administer ai`) and swaps its controller for `AiDashboard::index`, which renders a **Dashboard config entity** (`ai_dashboard`) built with Layout Builder — so the page you already reach at Admin → Configuration → AI becomes the dashboard. That dashboard entity (config `dashboard.dashboard.ai_dashboard`, provided by the `dashboard` module) lays out six blocks the module defines or reuses: **Setup** (`ai_setup_ai_provider`, a form to pick an AI provider and save its API key via the `config_action` plugin), **Features** (a `project_browser` block backed by this module's `ai_dashboard_recommended` source — a curated remote YAML list of recommended AI recipes/modules), **Status** (`ai_operations_status`, which capability-checks configured providers), **Extensions** (`module_list_packages`, a filtered core module-list form limited to the AI-related packages), **Configuration** (`admin_menu_links`, the AI admin menu), and **Documentation** (`ai_documentation`, links gathered from every module's `*.ai_documentation.yml` file). It also defines a lightweight `ai_documentation` YAML **plugin type** (any module can drop an `{module}.ai_documentation.yml` to add a labelled doc link) and an `AiSetupStatus` service that reports whether a given AI provider already has its key configured. On install it registers the `ai_dashboard_recommended` project-browser source (pointing at a Drupal.org-hosted recipes list). It depends on `ai`, `dashboard`, and `project_browser`, defines no permissions of its own (gated by AI Core's `administer ai`), and adds no Drush commands.

---

- Give site builders a single "AI control panel" at `/admin/config/ai` instead of a bare menu of links.
- Let a non-developer add an OpenAI/Anthropic/etc. provider and paste an API key from one Setup form, without visiting each provider's own config page.
- Show at a glance whether each installed AI provider already has its API key configured (the Setup block greys out already-configured providers).
- Surface a curated, remotely-updated list of **recommended AI recipes** (e.g. AI Assistant, Image Classification, LLM-optimized content) via Project Browser so admins can one-click install them.
- Present AI operational **status** — which model capabilities (chat, vision, JSON output, tools, embeddings…) are actually available from the configured providers.
- Give a focused **Extensions** view of only the AI-related module packages (AI, AI Experimental, AI Providers, AI Tools) rather than the whole `/admin/modules` list.
- Collect documentation links for AI from across all enabled modules into one Documentation block.
- Let any contrib/custom AI module contribute its own doc link to the dashboard by shipping a `{module}.ai_documentation.yml` file (no code required).
- Add a curated documentation link programmatically by defining an `ai_documentation` plugin in your module.
- Onboard a new AI site quickly: install ai_dashboard, land on `/admin/config/ai`, configure a provider, install a recommended recipe — all in one place.
- Rebrand or re-order the AI landing page by editing the `ai_dashboard` Dashboard config entity in Layout Builder (add/remove/re-weight blocks).
- Change which module packages the Extensions block lists by editing the block's `packages` setting.
- Tune how many documentation links show before "show more" via the Documentation block's `soft_limit` / `hard_limit`.
- Point the recommended-recipes source at your own curated YAML feed (or adjust its cache TTL) by editing the `ai_dashboard_recommended` project-browser source config.
- Build a status dashboard for editors/ops that checks provider readiness before an AI feature is rolled out.
- Reuse the `AiSetupStatus` service in custom code to check `getProviderSetupStatus('openai')` before invoking an AI operation.
- Provide a guided "getting started with AI" experience for agencies handing a site to a client.
- Consolidate provider setup, extension discovery, and docs so support teams have one URL to send users to.
- Detect drift — spot providers that were enabled but never given a key, from the Status/Setup blocks.
- Serve as the anchor page linked from an "AI" admin toolbar item for a Drupal CMS AI install.
- Extend the dashboard with your own block plugin (category "AI Dashboard") and place it on the `ai_dashboard` dashboard.
- Offer editors a Project Browser experience scoped to vetted AI recipes only, instead of the full Drupal.org catalog.
