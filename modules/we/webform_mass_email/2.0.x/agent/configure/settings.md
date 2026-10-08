<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — settings, permissions, routes

## Global settings form
Route `webform.config.mass_email`, path `/admin/structure/webform/config/mass-email`, form
`Form\AdminConfig\WebformAdminConfigMassEmailForm` (a `ConfigFormBase`), permission
**`administer webform_mass_email`**. Config object `webform_mass_email.settings`
(schema `config/schema/webform_mass_email.schema.yml`, install defaults `config/install/webform_mass_email.settings.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `cron` | integer (seconds) | `15` | Seconds spent draining the queue per cron run. Min 1; the form caps `#max` at PHP `max_execution_time` when that is set. Applied to the queue via `hook_queue_info_alter`. |
| `html` | boolean | `false` | When on, the send form's Body becomes a `text_format` editor and sent mail gets a `text/html` content-type header. The setting is read **when the mail is sent on cron**, not when queued. Rendering HTML mail requires a separate HTML-mail module. |
| `log` | boolean | `false` | When on, the queue worker writes a dblog entry per send (success `info`, faulty item `error`). A log entry means the message reached PHP `mail()`, not that it was delivered. High volume fills dblog. |

## Permissions (`webform_mass_email.permissions.yml`)
| Permission | Grants |
|---|---|
| `administer webform_mass_email` | Access the global settings form above. |
| `send webform_mass_email` | Reach a webform's Mass Email send form (in addition to the entity-access checks below). |

Neither permission declares `restrict access: true`.

## Send route access (`entity.webform.results_mass_email`)
Path `/admin/structure/webform/manage/{webform}/results/mass-email`. Requires **all three**:
- `_permission: 'send webform_mass_email'`
- `_entity_access: 'webform.submission_view_any'`
- `_custom_access: '\Drupal\webform\Access\WebformEntityAccess:checkResultsAccess'`

Effect: a sender must already be permitted to view that webform's submission results before they can
mass-email its collected addresses. Recipients are bounded to addresses that form actually collected — the
sender cannot type an arbitrary recipient list, and the `From:` is fixed to the site email.

## Local task tabs (`webform_mass_email.links.task.yml`)
- "Mass Emails" under the Webform config tab (`webform.config`).
- "Mass Email" under a webform's Results tabs (`entity.webform.results`).
