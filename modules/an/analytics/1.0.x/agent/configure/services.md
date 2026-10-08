# Admin UI, service entities & settings

## Service listing & entity

`/admin/config/services/analytics` (`entity.analytics_service.collection`) lists the
`analytics_service` config entities. Add/edit via `AnalyticsServiceForm`:
- `label`, machine `id`, and a **Service** select (the `analytics_service` plugin to use;
  disabled after creation). Selecting a plugin AJAX-loads its configuration subform
  (`buildConfigurationForm`).
- Stored config entity keys (`Entity/AnalyticsService`, schema `analytics.service.*`):
  `id`, `label`, `service` (plugin id), `service_configuration` (plugin config, typed by
  `analytics.service_configuration.<plugin>`), `weight`, `status`. `admin_permission =
  administer analytics`.

Enable/disable use dedicated CSRF-protected routes handled by
`AnalyticsController::ajaxOperation()`:
- `entity.analytics_service.enable` / `.disable`
  (`/admin/config/services/analytics/{analytics_service}/enable|disable`,
  `_csrf_token: TRUE`, `_entity_access: analytics_service.enable|disable`). Returns an AJAX
  replace of the list, or redirects.

## Shared settings (`analytics.settings`)

Config form at `/admin/config/services/analytics/settings`
(`\Drupal\analytics\Form\AnalyticsSettingsForm`, route `analytics.settings_form`,
`_permission: administer analytics`). Defaults (`config/install/analytics.settings.yml`):

```yaml
privacy:
  dnt: true            # wrap every snippet in a navigator.doNotTrack guard + attach DNT JS lib
  anonymize_ip: false  # request IP anonymization from services that support it
cache_urls: false
disable_page_build: false   # when true, analytics_page_bottom() emits nothing at all
```

`privacy.dnt` is consumed by `AnalyticsJsMarkup::isDntEnforced()` (wraps JS in
`if (!navigator.doNotTrack && !window.doNotTrack && !navigator.msDoNotTrack) {...}`) and by
`analytics_page_attachments()` which attaches the `analytics/dnt` library. A
`ConfigSubscriber` invalidates cache tags when settings change.

## Output pipeline

`analytics_page_bottom()`:
1. returns early if `disable_page_build` is set;
2. loads all `analytics_service` entities, skips disabled ones;
3. for each, if `$plugin->canTrack()` and `$plugin->getOutput()` is non-empty, attaches the
   output to `$page_bottom` with the service's cache metadata.

`canTrack()` (`ServicePluginBase`) allows only when **not** on an admin route and the current
user lacks `bypass all analytics services`, then fires
`hook_analytics_service_can_track_access_alter($access, $plugin)`.
