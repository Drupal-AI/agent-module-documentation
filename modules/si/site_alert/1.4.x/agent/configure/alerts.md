# Configure Site Alert

## Managing alerts (UI)

Collection: `admin/config/system/site-alerts` (route `entity.site_alert.collection`). Add/edit/delete
forms at `…/add`, `…/{site_alert}/edit`, `…/{site_alert}/delete`. Admin permission for the entity is
`administer site alert`.

## The `site_alert` entity fields (`src/Entity/SiteAlert.php`)

| Field | Type | Notes |
|---|---|---|
| `label` | string (required) | Internal identifier, not shown to end users. |
| `active` | boolean | Default TRUE. Inactive alerts are hidden but retained for reuse. |
| `severity` | list_string (required) | `low` / `medium` / `high` (`SEVERITY_OPTIONS`); drives the `severity-{value}` CSS class in the template. |
| `message` | text_long (required) | The alert body. Rendered as raw markup (see permissions doc). |
| `scheduling` | daterange | Optional start (`value`) and end (`end_value`); either or both may be empty. |

An alert is "active for display" when `active == 1` **and** now ≥ start (or no start) **and** now < end
(or no end) — see `GetAlerts::getActiveAlertIds()`.

## The block

Place the **Site Alert** block (`site_alert_block`) in a region via *Structure → Block layout*. It
renders every active alert (`#theme => site_alert`, template `templates/site-alert.html.twig`) inside
`<div class="site-alert" aria-live="polite">`.

Block setting (schema `block.settings.site_alert_block`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `timeout` | integer | 300 | Seconds between AJAX refreshes. `0` = do not poll the server. |

## AJAX refresh & caching

- The block attaches the `site_alert/drupal.site_alert` JS + `drupalSettings.siteAlert.timeout` when a
  timeout > 0 (or when the page_cache workaround is active).
- JS polls route `site_alert.ajax` → `/ajax/site_alert` (`_access: TRUE`, `_maintenance_access: TRUE`),
  handled by `SiteAlertController::getUpdatedAlerts()`, which returns the freshly rendered active alerts.
- Correctness on cached pages: the block/controller set cache max-age to the next scheduled change, add
  the `site_alert` list cache tags, and use the custom `active_site_alerts` cache context
  (`cache_context.active_site_alerts` service). When core `page_cache` is enabled and scheduled alerts
  exist, the block skips server-side rendering and lets the JS fetch alerts (workaround for a core
  max-age bug), so alerts still flip on time.

Set a block's timeout with Drush:

```php
// drush php:eval — after the block is placed as e.g. "olivero_site_alert"
$b = \Drupal\block\Entity\Block::load('olivero_site_alert');
$s = $b->get('settings'); $s['timeout'] = 120; $b->set('settings', $s)->save();
```
