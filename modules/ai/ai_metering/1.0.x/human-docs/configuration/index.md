# Configuration

Metering starts working the moment the module is enabled — every AI call through
the AI module is logged automatically, so you do not have to wire anything up to
start collecting data. Everything on this page tunes *how* costs are priced,
displayed, and capped.

## Open the settings

1. Log in as a user with the **Administer AI metering** permission.
2. Go to **Configuration → AI → AI Metering** (`/admin/config/ai/ai-metering`) —
   this is the settings hub. The settings form itself is at
   `/admin/config/ai/ai-metering/settings`.

All settings live in the `ai_metering.settings` configuration object, so they
export and deploy like any other Drupal configuration.

## Model routing

Model routing lets you control cost by sending prompts to different models based
on their size. Short prompts can go to a fast, cheap model and long ones to a
higher-quality (pricier) model.

- **Small threshold** — the token cutoff below which a prompt counts as
  "small". (Live default: 500 tokens.)
- **Small model** / **Large model** — which model handles prompts below and
  above the threshold. (Live defaults route small prompts to a Claude Haiku
  model and large prompts to a Claude Sonnet model.)
- **Small label** / **Large label** — friendly labels shown for each route.

## Quotas

A quota is a per-user **monthly token budget**. The pre-call event subscriber
checks it before each AI call:

- Set a user's monthly budget from the settings/quota UI or with Drush
  (`drush aim-budget <uid> <tokens>`).
- When a user goes over budget, the request can **fall back** to a configured
  cheaper or local provider instead of being refused — so work continues at
  lower cost.
- Reset a user's used-quota counter with `drush aim-quota-reset <uid>` (for
  example after granting an overage).

## Pricing

Costs are calculated from per-model prices supplied by a **pricing source**
plugin — **LiteLLM** and **models.dev** ship with the module, and you can add
custom per-model prices for a private or self-hosted model.

- Trigger a sync from the **Sync pricing** action
  (`/admin/config/ai/ai-metering/sync-pricing`) or with `drush aim-sync`.
- Run a sync after install, and periodically thereafter, so cost figures reflect
  current prices.

## Currency

Costs are recorded in USD but can be **displayed** in any currency. Choose your
display currency in the settings; live exchange rates come from the Frankfurter
service, so this needs outbound HTTP access.

## Dashboards and exports

- **Cost dashboard** — **Reports → AI Metering**
  (`/admin/reports/ai-metering`): spend per editor and per model.
- **By role** — `/admin/reports/ai-metering/by-role`.
- **Export** — download the raw per-call usage log as CSV or JSON from
  `/admin/reports/ai-metering/export/csv` and `/export/json` (handy for finance
  or an external billing pipeline).

## Permissions

Set these on **People → Permissions**:

| Permission | What it allows |
|---|---|
| **Use AI metering** (`use ai_metering`) | Trigger AI operations that are subject to a token quota. Intended to be granted broadly. |
| **View AI metering dashboard** (`view ai metering dashboard`) | See the per-editor cost dashboard. Grant to editors and managers. |
| **Administer AI metering** (`administer ai metering`) | Configure quotas, model routing, and pricing; reach the settings, hub, and sync routes. A trusted, administrative permission. |
| **Export AI metering usage log** (`export ai metering usage log`) | Download the raw per-call usage log (CSV / JSON). |

For example:

```bash
drush role:perm:add content_editor 'view ai metering dashboard'
```

## Drush commands

Five commands cover the command-line workflow:

| Command | Alias | What it does |
|---|---|---|
| `ai-metering:set-user-budget` | `aim-budget` | Set a user's monthly token budget. |
| `ai-metering:quota-reset` | `aim-quota-reset` | Reset a user's used-quota counter. |
| `ai-metering:sync-pricing` | `aim-sync` | Sync model pricing from the configured source. |
| `ai-metering:litellm-user-spend` | `aim-user` | Show a user's spend from the LiteLLM proxy. |
| `ai-metering:litellm-report` | `aim-report` | Show the global LiteLLM proxy spend report. |

```bash
drush aim-budget <uid> <tokens>   # set a user's monthly token budget
drush aim-quota-reset <uid>       # clear their used-quota counter
drush aim-sync                    # refresh model prices
drush aim-report                  # LiteLLM global spend
```

Run `drush <command> --help` for the exact arguments and options.
