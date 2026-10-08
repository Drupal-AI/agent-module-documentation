# Global settings & lightweight cron

The lightweight cron page (`/admin/config/content/scheduler/cron`) — a URL cron can hit to run
only Scheduler, with its access key:
![Scheduler lightweight cron](../../../../../../../screenshots/scheduler/2.3.x/cron.png)

Site-wide config lives in `scheduler.settings` (schema `config/schema/scheduler.schema.yml`).
Form: `\Drupal\scheduler\Form\SchedulerAdminForm` at `/admin/config/content/scheduler`
(route `scheduler.admin_form`, permission `administer scheduler`).

## Key `scheduler.settings` keys (defaults)
- `allow_date_only` (false) — let editors enter a date with no time; time taken from `default_time`.
- `default_time` ('00:00:00') — time applied when only a date is entered.
- `date_format` ('Y-m-d H:i:s'), `date_only_format` ('Y-m-d'), `time_only_format` ('H:i:s').
- `hide_seconds` (false) — hide seconds on the time input.
- `log` (true) — write start/complete messages to dblog on each lightweight cron run.
- Per-type **defaults** (used when a bundle is first enabled), each prefixed `default_`:
  `publish_enable`, `unpublish_enable`, `publish_required`, `unpublish_required`,
  `publish_past_date` ('error' | 'publish' | 'schedule'), `publish_past_date_created`,
  `publish_revision`, `unpublish_revision`, `publish_touch`, `show_message_after_update`,
  `expand_fieldset` ('when_required' | 'always'), `fields_display_mode` ('vertical_tab' | 'fieldset').

Read a value in code: `\Drupal::service('scheduler.manager')->setting('allow_date_only')`.

## Lightweight cron
Scheduler processes due entities on normal Drupal cron, but you can also run *only* Scheduler's
work more frequently:
- Config form: `scheduler.cron_form` at `/admin/config/content/scheduler/cron` — sets a cron key
  and the log option.
- Public URL: `/scheduler/cron/{cron_key}` (route `scheduler.lightweight_cron`), guarded by the
  key; call it from an external scheduler / webcron every minute.
- Drush: `drush scheduler:cron` (see [../drush/drush.md](../drush/drush.md)).

Bundled Views (`config/install` + `config/optional`) provide "Scheduled content" listings for
node, media, taxonomy term and commerce product.
