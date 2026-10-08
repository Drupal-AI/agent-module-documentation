<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AI Dashboard

## Where the page lives (no routing.yml)

The module defines **no route**. `src/Routing/RouteSubscriber.php` alters AI Core's
`ai.settings.menu` route:

- path stays **`/admin/config/ai`**, permission stays **`administer ai`** (both from `ai`)
- title → `AI Setup and Configuration`
- controller → `\Drupal\ai_dashboard\Controller\AiDashboard::index`

`index()` loads the **Dashboard config entity** `ai_dashboard` and renders its Layout Builder
sections. If that entity is missing it falls back to the plain system menu block.
So `configure` in `.info.yml` is unset (`null`) — you reach the dashboard via AI Core's page.

## The dashboard config entity

Config name: **`dashboard.dashboard.ai_dashboard`** (entity type provided by the `dashboard`
module; ships in `config/install/`). `id: ai_dashboard`, `label: AI Dashboard`,
`description: 'Configure your AI environment, connect providers, and enable additional functionality.'`
One `layout_onecol` section with six components (block instances):

| Block plugin id | Dashboard label | Provided by | Notable settings |
|---|---|---|---|
| `ai_setup_ai_provider` | Setup | ai_dashboard | — (renders `SetupAiProviderForm`) |
| `project_browser_block:ai_dashboard_recommended` | Features | project_browser | `paginate`, `page_sizes`, `sort_options` |
| `ai_operations_status` | Status | ai_dashboard | — |
| `module_list_packages` | Extensions | ai_dashboard | **`packages`** (newline-separated package names) |
| `admin_menu_links` | Configuration | ai_dashboard | — |
| `ai_documentation` | Documentation | ai_dashboard | **`soft_limit`** (default 4), **`hard_limit`** (default 0) |

Edit it in the UI via Layout Builder (Structure → Dashboards → AI Dashboard) or read/write with
Drush. Because the layout is a list keyed by component **uuid**, target components by their
block `id`, not by array index:

```php
// Read the Extensions block's package filter.
$dash = \Drupal::config('dashboard.dashboard.ai_dashboard')->get('layout');
foreach ($dash[0]['components'] as $c) {
  if ($c['configuration']['id'] === 'module_list_packages') {
    print $c['configuration']['packages'];   // "AI\r\nAI (Experimental)\r\nAI Providers\r\nAI Tools"
  }
}
```

```php
// Change the Extensions package filter (writeable copy).
$cfg = \Drupal::configFactory()->getEditable('dashboard.dashboard.ai_dashboard');
$layout = $cfg->get('layout');
foreach ($layout[0]['components'] as $uuid => &$c) {
  if ($c['configuration']['id'] === 'module_list_packages') {
    $c['configuration']['packages'] = "AI\r\nAI Providers";
  }
}
$cfg->set('layout', $layout)->save();
```

The `module_list_packages` block filters the core "extend" module list to the packages named
in `packages` (default: `AI`, `AI (Experimental)`, `AI Providers`, `AI Tools`). The
`ai_documentation` block lists doc links (see plugins doc); `soft_limit` = links shown before a
"show more" toggle, `hard_limit` = absolute cap (0 = no cap).

## The Setup form (adding a provider + key)

The **Setup** block renders `SetupAiProviderForm` (form id `ai_setup_ai_provider`): pick an AI
provider, paste an API key, submit. On submit it runs the **`setupAiProvider`** config action
against `{provider_module}.settings`, creating a Key entity and wiring it up (and for `openai`
also enables `openai_moderation`). Providers that already have a key set are detected via the
`AiSetupStatus` service and their key field is disabled with a "already configured" note.

## The recommended-recipes Project Browser source

`hook_install()` (in `ai_dashboard.install`) registers a Project Browser source named
**`ai_dashboard_recommended`** into `project_browser.admin_settings` → `enabled_sources`:

```yaml
ai_dashboard_recommended:
  uri: 'https://git.drupalcode.org/api/v4/projects/196945/repository/files/ai_dashboard_recommended_recipes.yml/raw?ref=HEAD'
  ttl: 1
```

The source plugin is `AiDashboardRecommended` (`#[ProjectBrowserSource(id: 'ai_dashboard_recommended')]`),
which fetches that YAML (a curated list of AI recipes/modules, filtered to installable ones by
core-compat) and feeds the Features block. Change the feed URL or cache TTL by editing that
config key (schema: `project_browser.source.ai_dashboard_recommended` → `uri`, `ttl` [min 1]):

```bash
drush php:eval '$c=\Drupal::configFactory()->getEditable("project_browser.admin_settings");
$s=$c->get("enabled_sources"); $s["ai_dashboard_recommended"]["ttl"]=3600;
$c->set("enabled_sources",$s)->save();'
```

## Config schema (`config/schema/ai_dashboard.schema.yml`)

- `block.settings.module_list_packages` → `packages` (string)
- `block.settings.ai_documentation` → `soft_limit` (int), `hard_limit` (int)
- `project_browser.source.ai_dashboard_recommended` → `uri` (uri), `ttl` (int, min 1)
