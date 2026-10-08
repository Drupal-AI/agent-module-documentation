<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Syncloud settings & site-wide behavior

Install/enable: `drush en syncloud -y` (pulls the `contact` module; the `politsin/phpmqtt`
library must already be present via Composer). `hook_install` (`syncloud.install`) seeds three
state values: `syncloud.uuid` and `syncloud.secret` (random base64, 16 bytes) and
`syncloud.weekly` (set to one week ago so the first cron run publishes immediately).

## Settings form

- Route: `entity.syn.settings` → `admin/structure/syn`, title "Syn Settings".
- Permission: `administer syn` (marked `restrict access: true`).
- Class: `Drupal\syncloud\Form\SynSettingsForm` (a plain `FormBase`, form id `syn_settings`).
- Reads/writes the `syncloud.settings` config object. Also linked from the config menu as
  "SynCloud" under System (`syncloud.links.menu.yml`).

## `syncloud.settings` config keys

No config schema is shipped, so these are the effective keys from
`config/install/syncloud.settings.yml` and `SynSettingsForm`:

| Key | Type / default | Meaning |
| --- | --- | --- |
| `enable` | bool, `1` | Master switch for the page-attachment tracking snippet. |
| `admin-pages` | bool, `0` | Also emit the snippet on admin routes. |
| `admin-disable` | bool, `0` | Suppress the snippet for user uid=1. |
| `user-disable` | bool, `0` | Suppress the snippet for all authenticated users. |
| `telegram-int` | bool, `0` | Gate: queue processing only MQTT-publishes an event when this is truthy. |
| `site-id` | string, `""` | Matomo/analytics Site ID used by the injected script. |
| `custom-matomo` | string, `""` | Custom Matomo host for the snippet (else same-origin `/`). |
| `weekly` | bool, `1` | Enable the weekly cron usage publish. |
| `server` | string, `""` | MQTT broker host. |
| `port` | string, `""` | MQTT broker port (falls back to `1883` when non-int). |
| `login` | string, `""` | MQTT username. |
| `password` | string, `""` | MQTT password. |

## How MQTT credentials are sourced (verbatim from source)

`Service\MqttService::getMqttSettings()` reads **only** from the `syncloud.settings` config object:
`server`, `port`, `login` → username, `password`. There is **no** environment variable, `getenv()`,
`.env`/dotenv, Key-entity, or settings.php path anywhere in the module — the four values come
straight from config edited in the settings form. `run()` builds
`new phpMQTT($server, $port, 'phpMQTT-client'.rand())` and calls
`connect(TRUE, NULL, $username, $password)`. There is no `$telega`/Telegram bot token in the code:
"Telegram integration" is just the boolean `telegram-int`; Telegram delivery is expected to happen
on the broker side, which receives events on the MQTT topic
`$telega/syncloud/<uuid>/event/contact-message`.

`Hook\Cron::checkMqtt()` and `Hook\Requirements::hook()` contain a self-provisioning path: if the
configured `login === 'stat:public'` **or** `password === 'notSecured'`, they issue a Guzzle GET to
`https://app.biz-panel.com/syncloud-info/log_pass/<uuid>` and overwrite the `login`/`password`
config keys with the JSON the endpoint returns. `hook_requirements` (runtime) additionally raises a
`REQUIREMENT_ERROR` on the status report — "Syncloud: public login/pass" — while those defaults are
in place. These Guzzle calls use HTTPS with Guzzle's default TLS verification.

## Page-attachment tracking snippet

`Hook\PageAttachments::hook()` (via `syncloud_page_attachments`) injects a Matomo-style
`<script>` into `html_head` when `enable` is on and the admin/user gates allow it. It sets
`setSiteId` from `site-id`, `setTrackerUrl` from the `custom-matomo` host (default same-origin),
and three custom dimensions: dim 2 = the site UUID (`syncloud.uuid` state, or a fresh random value
if unset), dim 1 = `_ym_uid` cookie, dim 3 = `_ga` cookie. It is skipped on admin routes unless
`admin-pages`, for uid=1 when `admin-disable`, and for authenticated users when `user-disable`.

## Mail alter

`Hook\MailAlter::hook()` (via `syncloud_contact_mail_alter_message_alter`) appends, to any mail
body, a link `https://biz-panel.com/clickhouse/profile/<matomo>` when the request carries a
Matomo `_pk_id*` cookie (the `<matomo>` id is parsed from that cookie).

## Cron

`Hook\Cron::hook()` (via `syncloud_cron`): when `weekly` is on and more than 604800 s have passed
since `syncloud.weekly`, it publishes a usage stat message (site URL, login, uuid, secret, syncloud
+ Drupal + PHP versions) to MQTT topic `stat/<uuid>/state/usage` via `syncloud.mqtt->run()->publish()`
and records the timestamp. This path uses `MqttService` directly and is unaffected by the queue-service
defect noted in the entity/flow docs.
