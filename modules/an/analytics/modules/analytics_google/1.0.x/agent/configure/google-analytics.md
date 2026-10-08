# Configure Google Analytics (the `google_ga` service)

`analytics_google` adds one provider plugin to the parent Analytics API. It has **no admin
route of its own** — you configure it by creating an `analytics_service` config entity of
type "Google Analytics (ga.js)" through the parent UI.

## The provider plugin

| Property | Value |
|---|---|
| Plugin id | `google_ga` |
| Class | `Drupal\analytics_google\Plugin\AnalyticsService\GoogleAnalyticsGa` |
| Base class | `Drupal\analytics\Plugin\ServicePluginBase` |
| Annotation | `@AnalyticsService(id="google_ga", label="Google Analytics (ga.js)", multiple=true)` |
| Managed by | `plugin.manager.analytics_service` (parent) |

`multiple = true` means a site may add more than one Google Analytics service entity.

## Config (Tracking ID)

`buildConfigurationForm()` provides a single field:

| Form key | `#type` | Required | Notes |
|---|---|---|---|
| `id` | `number` | yes | Tracking ID; `#min` 0, `#size` 15. `defaultConfiguration()` = `['id' => NULL]`. |

The value is written to the parent `analytics_service` entity under
`service_configuration` (the parent form's `submitConfigurationForm()` copies matching
form values into plugin configuration).

### Config schema

`config/schema/analytics_google.schema.yml`:

```yaml
analytics.service_configuration.google_ga:
  type: analytics.service_configuration
  label: 'Google analytics (GA) service settings'
  mapping:
    id:
      type: string
      label: 'Tracking ID'
```

`analytics.service_configuration` is the parent's base type; this adds the `id` key.

## Add a service

UI: `/admin/config/services/analytics` → add service → choose "Google Analytics (ga.js)" →
enter Tracking ID → save. Requires the parent `administer analytics` permission.

PHP (create/enable a GA service entity directly):

```php
\Drupal\analytics\Entity\AnalyticsService::create([
  'id' => 'my_ga',
  'label' => 'My GA',
  'service' => 'google_ga',
  'status' => TRUE,
  'service_configuration' => ['id' => '123456'],
])->save();
```

Read/update via config: the entity is stored as `analytics.analytics_service.my_ga`
(`drush config:get analytics.analytics_service.my_ga`).

## How the tag is emitted

The submodule itself never touches the page. The parent's `analytics_page_bottom()`
(hook_page_bottom) loads all enabled `analytics_service` entities and, for each whose
`canTrack()` returns TRUE, appends `getService()->getOutput()` to the page bottom.

`GoogleAnalyticsGa::getOutput()` returns:

```php
$output['analytics_' . $this->getServiceId()] = [
  '#type' => 'html_tag',
  '#tag' => 'googleanalytics',
  '#attributes' => ['tracking_id' => $this->configuration['id']],
];
```

So the rendered markup is `<googleanalytics tracking_id="…"></googleanalytics>`. The code
comments flag this as **placeholder** output — it emits a custom `<googleanalytics>`
element, not a real gtag/analytics.js snippet, so this provider is a stub awaiting a full
GA4 implementation. The Tracking ID is rendered as an `html_tag` attribute (escaped by
core's attribute rendering).

`canTrack()` (inherited from `ServicePluginBase`) suppresses output on admin routes and for
users holding `bypass all analytics services`; DNT / `disable_page_build` handling is the
parent's — see
[../../../../1.0.x/agent/plugins/analytics-service.md](../../../../1.0.x/agent/plugins/analytics-service.md)
and [../../../../1.0.x/agent/configure/services.md](../../../../1.0.x/agent/configure/services.md).
Unlike the parent's `google_tag_manager` plugin, `google_ga` does not wrap output in
`AnalyticsJsMarkup`, so its placeholder tag is not DNT-guarded.
