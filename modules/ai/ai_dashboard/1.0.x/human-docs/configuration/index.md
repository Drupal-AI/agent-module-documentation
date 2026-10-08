# Configuration

AI Dashboard has no settings form of its own. You "configure" it by **using the
dashboard** (especially the Setup block), and, if you want, by **editing the dashboard
layout** in Layout Builder or pointing the recommended‑recipes source at a different
feed.

## Open the dashboard

Log in as a user with the **Administer AI** permission and go to **Configuration → AI**
(`/admin/config/ai`). You will see six blocks.

## The six blocks

- **Setup** — a form to pick an AI provider (OpenAI, Anthropic, and so on) and paste
  its API key. Submitting it stores the key and wires the provider up for you. Providers
  that already have a key configured are greyed out with an "already configured" note.
- **Features** — a Project Browser view scoped to a curated list of **recommended AI
  recipes** (AI Assistant, image classification, and similar). You can one‑click install
  them from here.
- **Status** — reports which model capabilities (chat, vision, JSON output, tools,
  embeddings…) the configured providers actually offer, so you can spot a provider that
  was enabled but never given a key.
- **Extensions** — a focused version of the module list, filtered to the AI‑related
  packages (AI, AI Experimental, AI Providers, AI Tools) rather than the whole
  `/admin/modules` page.
- **Configuration** — the AI section of the admin menu, for jumping to each AI module's
  own settings.
- **Documentation** — documentation links gathered from every enabled module (see
  below), shown a few at a time with a "show more" toggle.

## Add a provider and API key

1. In the **Setup** block, choose your provider from the list.
2. Paste the provider's **API key**.
3. Submit. The dashboard saves the key (creating a Key entity and wiring it to the
   provider's settings). For OpenAI it also enables the moderation submodule.

That is the fastest path to a working AI provider — you do not need to visit each
provider module's own configuration page.

## Customize the dashboard layout (optional)

Because the page is a Dashboard entity built with Layout Builder, you can rearrange it:

- Go to **Structure → Dashboards → AI Dashboard** and edit its layout to add, remove,
  or re‑order blocks. You can also place your own block plugins (category "AI Dashboard")
  on it.
- The **Extensions** block has a **Packages** setting (a newline‑separated list of
  module package names) controlling which packages it lists.
- The **Documentation** block has a **Soft limit** (how many links to show before "show
  more", default 4) and a **Hard limit** (an absolute cap, 0 = no cap).

## Add a documentation link (no code)

Any module can add a link to the **Documentation** block by shipping a file named
`{module}.ai_documentation.yml` in its root. Each entry needs a `label` and a `url`
(a `description` is optional):

```yaml
my_module_ai_docs:
  label: 'My AI feature guide'
  url: 'https://example.com/docs/ai'
  description: 'How to use our AI feature'
```

## Point recommended recipes at your own feed (optional)

The **Features** block reads a curated YAML list of recipes from a Drupal.org‑hosted
URL, configured as a Project Browser source named `ai_dashboard_recommended`. To point
it at your own list or change how long it is cached, edit that source's `uri` and `ttl`
in the Project Browser settings (`project_browser.admin_settings`). For example, to
raise the cache time:

```bash
drush php:eval '$c=\Drupal::configFactory()->getEditable("project_browser.admin_settings");
$s=$c->get("enabled_sources"); $s["ai_dashboard_recommended"]["ttl"]=3600;
$c->set("enabled_sources",$s)->save();'
```

## Permission

- **Administer AI** (provided by the AI module) — required to reach the dashboard at
  `/admin/config/ai`. AI Dashboard adds no permission of its own.
