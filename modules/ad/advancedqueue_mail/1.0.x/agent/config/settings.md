<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — advancedqueue_mail.settings

## Install & enable

```bash
composer require drupal/advancedqueue_mail
drush en advancedqueue_mail -y
```

Requires `drupal/advancedqueue` `^1.6` (info.yml declares `advancedqueue:advancedqueue (>=8.x-1.6)`). By default
notifications go through Drupal core mail. For Mailer Plus, also enable the submodule (see
`../../modules/advancedqueue_mail_symfony_mailer/1.0.x/agent/start.md`).

`hook_update_10001()` installs the default config if missing; `hook_update_10002()` auto-enables the
`advancedqueue_mail_symfony_mailer` submodule on sites where `symfony_mailer` is already installed (preserves the
pre-1.0 behaviour where symfony_mailer support lived in the main module).

## Config route & UI

- Route `advancedqueue_mail.settings` → `Form\SettingsForm`, path `/admin/config/system/queues/mail`,
  requirement `_permission: 'administer site configuration'`.
- Menu link (`links.menu.yml`) and local task (`links.task.yml`) place it under the Advanced Queue
  *Queues* collection (`entity.advancedqueue_queue.collection`) as **Mail Notifications**.
- `SettingsForm` extends `ConfigFormBase` and uses `RedundantEditableConfigNamesTrait` + `#config_target`, so
  each field writes straight to a key in `advancedqueue_mail.settings`; there is no custom `submitForm()`.

## Config object `advancedqueue_mail.settings`

Three parallel mappings — `on_success`, `on_retry`, `on_failure` — each with the same keys (schema type
`config_object`, in `config/schema/advancedqueue_mail.schema.yml`):

| Key | Schema type | Meaning |
|---|---|---|
| `enabled` | `boolean` | Whether this event type sends mail. |
| `subject` | `label` | Email subject template. |
| `body` | `text` | Email body template. |
| `recipients` | `string` | Comma-separated recipient addresses. |

Install defaults (`config/install/advancedqueue_mail.settings.yml`): `on_failure.enabled: true`, the other two
`false`; all `recipients` empty; subjects/bodies pre-filled with `[Queue] …` templates. With empty `recipients`
no mail is sent even if `enabled` is true (see `MailSender::sendNotificationMail()`).

## Placeholders

Usable in `subject` and `body`; substituted by `MailSender::getReplacements($job)` via a plain `str_replace`:

| Placeholder | Source (`Drupal\advancedqueue\Job`) |
|---|---|
| `[job_id]` | `$job->getId()` |
| `[job_type]` | `$job->getType()` |
| `[queue_id]` | `$job->getQueueId()` |
| `[message]` | `$job->getMessage()` (job result message) |
| `[state]` | `$job->getState()` |

## Editing config with Drush

```bash
drush cset advancedqueue_mail.settings on_success.enabled true -y
drush cset advancedqueue_mail.settings on_failure.recipients "ops@example.com, dev@example.com" -y
drush cr
```
