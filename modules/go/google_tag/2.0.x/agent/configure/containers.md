# Configure tags & containers

The default container form at `/admin/config/services/google-tag` (Measurement/Container IDs):
![Google Tag default tag settings](../../../../../../../screenshots/google_tag/2.0.x/default-tag-settings.png)

Global settings (`/admin/config/services/google-tag/settings`):
![Google Tag global settings](../../../../../../../screenshots/google_tag/2.0.x/global-settings.png)

Global settings UI: `/admin/config/services/google-tag/settings` (route
`google_tag.settings_form`). Container list: `/admin/config/services/google-tag/containers`.

Global config object `google_tag.settings`:
```yaml
use_collection: false           # allow multiple containers (list UI) vs single default
default_google_tag_entity: ''   # id of the default container
```

**Tag container** — config entity `google_tag_container` (`config_prefix: container`,
class `Drupal\google_tag\Entity\TagContainer`). Exported keys:
```yaml
id, label, status, weight
tag_container_ids: []      # one or more IDs: G-… (GA4), AW-… (Ads), GTM-…, UA-…, DC-…
advanced_settings: {}      # per-tag advanced options
dimensions_metrics: []     # custom dimensions/metrics: {type: dimension|metric, name, value}
conditions: {}             # Condition plugin config (request_path, response code, …)
events: []                 # enabled GoogleTagEvent plugins + their configuration
```

- ID format is validated against `TagContainer::GOOGLE_TAG_MATCH`
  (`(GT|UA|G|AW|DC|GTM)-…`); GTM IDs load `gtm.js`, others load `gtag.js`.
- **Conditions** decide where a container fires — path visibility plus the module's
  `ResponseCode` condition plugin (skip 403/404, etc.). Evaluated by `TagContainerResolver`.
- **dimensions_metrics** values support tokens (via `DimensionsMetricsProcessor`, `@token`).
- Enable/disable without deleting: routes `entity.google_tag_container.enable` / `.disable`.
- Snippets are added by `EventSubscriber\ResponseSubscriber`; libraries `gtag` / `gtm` set
  `drupalSettings`. `CspSubscriber` adds a CSP nonce when the `csp` module is present.
- Config is exportable; a post_update + `Migration\*` upgrade path imports from the older
  `google_analytics` module.
