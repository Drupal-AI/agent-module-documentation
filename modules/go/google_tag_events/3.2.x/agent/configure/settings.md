# Settings (Debug mode)

The module's entire configuration is one boolean. There is no UI for defining events — events come
from `setEvent()` calls in code (see [../api/service.md](../api/service.md)).

- Route: `google_tag_events.settings_form` → `/admin/config/services/google-tag/events/settings`
- Permission: `administer google_tag_container` (owned by the `google_tag` module; this module
  declares none of its own).
- Form: `Drupal\google_tag_events\Form\SettingsForm` (form id `google_tag_events_settings`), a
  `ConfigFormBase`. Shown as a local task tab (`google_tag_events.settings_form_tab`) under the
  google_tag container form (base route `entity.google_tag_container.single_form`).

## Config object

Object `google_tag_events.settings` (`SettingsForm::CONFIG_NAME`). Schema
`config/schema/google_tag_events.schema.yml`; install default in `config/install/`.

| Key | Type | Default | Effect |
| --- | --- | --- | --- |
| `debug_mode` | boolean | `false` | When on, `GoogleTagEvents::gtmIsEnabled()` returns TRUE without a configured GTM container, so `setEvent()` queues and pushes events even on a site with no container — useful for local testing with a dataLayer inspector. |

With Debug mode off, events are only queued/pushed when `google_tag`'s
`google_tag.tag_container_resolver` resolves an active container for the request.

## Set it programmatically

```php
\Drupal::configFactory()
  ->getEditable('google_tag_events.settings')
  ->set('debug_mode', TRUE)
  ->save();
```

```bash
drush config:set google_tag_events.settings debug_mode true
```
