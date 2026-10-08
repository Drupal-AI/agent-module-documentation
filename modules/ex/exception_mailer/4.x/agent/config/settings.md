<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & operation

## Install / enable

`drush en exception_mailer -y`. No composer dependencies, no libraries. Default config is installed
from `config/install/exception_mailer.settings.yml`. Configure at
`/admin/config/exception-mailer/config` (route `exception_mailer.exception_mailer_config_form`,
permission `administer site configuration`, also linked under Configuration » Development).

## Config object: `exception_mailer.settings`

Schema: `config/schema/exception_mailer.schema.yml` (type `config_object`). Keys:

| Key | Type | Default (install) | Meaning |
|---|---|---|---|
| `enabled` | boolean | `true` | Master on/off for sending mail. Logging still happens when off. |
| `level_type` | sequence of string | `['0','1','2','3']` | RFC severity levels (via `RfcLogLevel::getLevels()`) whose **log entries** trigger mail. 0=emergency,1=alert,2=critical,3=error,4=warning,5=notice,6=info,7=debug. |
| `roles` | sequence of string | `{administrator}` | Roles whose active users receive mail. |
| `emails` | text | `''` | Comma-separated recipient addresses. |
| `max_similar_emails` | integer | `5` | Flood control: consecutive similar alerts suppressed before one is allowed through. Empty = no flood control. |
| `min_similarity` | integer | `50` | Flood control: `similar_text()` percentage above which two messages count as "similar". |

The settings form is `src/Form/ExceptionMailerConfigForm.php` (`ConfigFormBase`,
`getEditableConfigNames()` = `exception_mailer.settings`). It:

- Renders `enabled` as a checkbox and shows the live state status (see below).
- Renders `level_type` as checkboxes from `RfcLogLevel::getLevels()`.
- Renders `roles` as a multi-select (excludes the Anonymous and Authenticated pseudo-roles; labels
  passed through `Html::escape()`).
- Renders `emails` as a textarea; `validateForm()` requires at least one of roles/emails and
  validates each address with `email.validator`.
- Renders `max_similar_emails` / `min_similarity` (0–100) inside an "Email sending limits" fieldset.
- `submitForm()` stores `level_type` with `array_filter(...)` dropping unchecked (`0`) entries.

## Enable / disable

Two independent gates, both checked before any mail is built (in `ExceptionEventSubscriber::onException()`
and `ErrorLog::log()`):

1. **Config (permanent, exported):** `enabled` flag. `!($config->get('enabled') ?? TRUE)` → return.
2. **State (temporary, not exported):** `exception_mailer.enabled` state key.
   `!$this->state->get('exception_mailer.enabled', TRUE)` → return. Toggle with
   `drush state:set exception_mailer.enabled 0` / `1`, clear with `drush state:delete exception_mailer.enabled`.
   The settings form displays the current state value (DISABLED / ENABLED / not set).

Default when neither is set: enabled (`TRUE`).

## Recipient resolution (default, no matching exclude)

`getConfigFormEmailAdress()` (present in both the subscriber and the logger):
`explode(',', trim($config->get('emails')))` plus, for each selected role,
`UserRepository::getUserEmails(array_keys($roles))` — an entity query for active (`status = 1`) users
in those roles (`accessCheck(FALSE)`, internal recipient lookup). Deduplicated with `array_unique()`.

## Flood control

Both trigger paths call `exception_mailer__last_message_similarity($state_id, $email_data)`
(in `exception_mailer.module`) only when `max_similar_emails` is set. It keeps a per-key record in
state (`count`, `timespan`, `first_timestamp`, `message`) and uses `similar_text()` against the last
message. Once `count >= max_similar_emails` at similarity `>= min_similarity`, further alerts are
suppressed until an escalating window elapses (15 min → 1 h → 6 h → 24 h). State keys:
`exception_mailer.log.exception` (exceptions) and
`exception_mailer.log.<type>-<severity_level>` (log errors). The recurrence count is surfaced in the
email subject (e.g. `5x ... (in last 1 hour)`).

## Update hooks (`exception_mailer.install`)

- `update_8301` — installs the `exception_mailer_exclude` config entity type.
- `update_10001` — sets defaults `max_similar_emails=5`, `min_similarity=50`.
- `update_10002` — coerces null `emails` to `''`.
- `update_10003` — sets `enabled=TRUE` when unset.
