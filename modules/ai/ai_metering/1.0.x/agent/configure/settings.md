# Configure AI Metering

Config object `ai_metering.settings` (schema `config/schema/ai_metering.schema.yml`).
Read/write with `drush config:get ai_metering.settings` /
`drush config:set ai_metering.settings <key> <value>`.

## Admin routes
| Route | Path | Permission |
|---|---|---|
| `ai_metering.settings` | `/admin/config/ai/ai-metering/settings` | administer ai metering |
| `ai_metering.hub` | `/admin/config/ai/ai-metering` | administer ai metering |
| `ai_metering.sync_pricing` | `/admin/config/ai/ai-metering/sync-pricing` | administer ai metering |
| `ai_metering.dashboard` | `/admin/reports/ai-metering` | view ai metering dashboard |
| `ai_metering.dashboard_by_role` | `/admin/reports/ai-metering/by-role` | view ai metering dashboard |
| `ai_metering.export_csv` / `.export_json` | `/admin/reports/ai-metering/export/{csv,json}` | export ai metering usage log |

## Key settings
- **Model routing** — route by prompt size to control cost:
  `model_routing.small_threshold` (token cutoff), `small_model`, `large_model`,
  `small_label`, `large_label`. Example live default: small=`claude-haiku-4-5-…`,
  large=`claude-sonnet-4-5-…`, threshold 500.
- **Quotas** — per-user monthly token budget (enforced by the pre-generate subscriber; set
  per user via Drush `aim-budget` or the `set-quota` route). On overage the request can fall
  back to a configured local/cheaper provider.
- **Pricing** — synced from a `PricingSource` plugin (LiteLLM / models.dev); trigger with
  `drush aim-sync` or the sync-pricing route. Custom per-model prices are stored in settings.
- **Currency** — display currency; live rates via the `ai_metering.exchange_rate` service
  (Frankfurter).

```
drush config:set ai_metering.settings model_routing.small_threshold 800 -y
drush config:get ai_metering.settings model_routing
```
