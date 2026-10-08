# mailchimp — agent start

Base connector for the Mailchimp email platform (wraps `thinkshout/mailchimp-api-php`). Most
user features live in submodules. Settings UI: **Admin → Config → Web services → Mailchimp**
(`/admin/config/services/mailchimp`, route `mailchimp.admin`). Webhook endpoint:
`/mailchimp/webhook/{hash}`. Submodules: `mailchimp_lists`, `mailchimp_campaign`,
`mailchimp_signup`, `mailchimp_events`, `mailchimp_eca`.

- Connect account (API key / OAuth), settings keys → [configure/settings.md](configure/settings.md)
- Call Mailchimp from code (ApiService / ClientFactory) → [api/api-service.md](api/api-service.md)
- Alter merge vars, interest groups, campaigns, webhooks (hooks) → [hooks/hooks.md](hooks/hooks.md)
- Run queued operations on cron (Drush) → [drush/commands.md](drush/commands.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
