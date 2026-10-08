# ai_metering — agent start

Meters token usage + USD cost of every operation through the `ai` module; per-user monthly
quotas; multi-currency dashboard. Depends on `ai` + `views_data_export`.
Config UI: **Admin → Config → AI → AI Metering** (`/admin/config/ai/ai-metering`, configure
route `ai_metering.settings`). Dashboard: `/admin/reports/ai-metering`.

- Settings: quotas, model routing, pricing, currency → [configure/settings.md](configure/settings.md)
- Drush (quota reset, set budget, pricing sync, LiteLLM reports) → [drush/commands.md](drush/commands.md)
- Add a model-pricing source (plugin) → [plugins/pricing-source.md](plugins/pricing-source.md)
- Read/estimate usage & cost in code (services) → [api/services.md](api/services.md)
- Alter usage records / react to quota-exceeded (hooks) → [extend/hooks.md](extend/hooks.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)

Storage: DB tables `ai_metering_usage` (per-call log) + `ai_metering_quota` (per-user
budget) — no config/content entities. It works by subscribing to `ai` core's
Pre/PostGenerateResponse events.
