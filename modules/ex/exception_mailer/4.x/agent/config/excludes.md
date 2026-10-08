<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exclude rules (`exception_mailer_exclude` config entity)

Config entity type defined in `src/Entity/ExceptionMailerExclude.php`
(`@ConfigEntityType id = "exception_mailer_exclude"`, `config_prefix = "exception"`,
`admin_permission = "administer exception_mailer excludes"`). Schema:
`config/schema/exception_mailer_exclude.schema.yml` (`exception_mailer.exception.*`).

Interface: `src/ExceptionMailerExcludeInterface.php`. List builder:
`src/Controller/ExceptionMailerExcludeListBuilder.php`. Forms: `src/Form/ExceptionMailerExcludeForm.php`
(add/edit) and `src/Form/ExceptionMailerExcludeDeleteForm.php` (confirm delete).

## Routes (all require `administer site configuration`)

Defined in `exception_mailer.routing.yml` (base `/admin/config/exception-mailer/excludes`):
`entity.exception_mailer_exclude.collection`, `.add`, `.edit_form`, `.delete_form`. The collection is
reachable as an "Excludes" local task next to the settings form; "Add exclude" is an action link.

## Fields (config_export)

`id`, `label`, `description`, `type` (`exception` | `error`), `exception` (class substring),
`error_type` (logger channel), `error_severity` (int[] of levels), `message` (substring),
`hostname` (substring), `condition_roles` (string[]), `send_email` (bool), `emails` (string[]),
`roles` (string[]), `email_body` (string), `send_interval` (int minutes).

## How matching works

`ExceptionMailerExcludeManager::getExcludes($data, $type)` loads all excludes with the requested
`type` and `status = 1`, then `checkExcludesForData()` **unsets** any exclude whose set conditions do
NOT match the current event, so the returned list is the excludes that DO match:

- `error` type: drops if `error_type` set and `!= $data['type']`; drops if `error_severity` set and the
  event's `severity_level` is not among its keys.
- `exception` type: drops if `exception` set and not a substring of the thrown class (`strstr`).
- Both: drops if `message` set and not a substring of the event message; drops if `hostname` set and
  not a substring of the client IP; drops if `condition_roles` set and none intersect the current
  user's roles (`$data['user_roles']`).

## Effect of a matching exclude

In `ExceptionEventSubscriber::onException()` / `ErrorLog::log()`: **if one or more excludes match**,
the module iterates them and sends using each exclude's own recipients/body instead of the global
config; **if none match**, it falls back to the global settings-form recipients. So an exclude with
`send_email = FALSE` (or whose `getEmailAddresses()` returns empty) effectively **suppresses** mail
for the matched case, while an exclude with recipients **reroutes**/customizes it.

`ExceptionMailerExclude::getEmailAddresses()`:
- returns `[]` if `send_email` is false;
- returns `[]` if `send_interval` is set and `last_sent + send_interval*60 >= now` (per-exclude
  throttle; `last_sent` is state key `<id>_last_sent`, written after a successful send);
- otherwise returns the exclude's `emails` plus emails of users in its `roles`, deduplicated.

`getEmailBody()`, when non-empty, is prepended to the standard report under an
"Original system report" separator (see `hook_mail` in api/mail-pipeline.md).

## Notes

- The entity's declared `admin_permission` (`administer exception_mailer excludes`) is **not** defined
  by any `*.permissions.yml` in this module; the exclude admin routes are gated by the core
  `administer site configuration` permission set directly in routing.yml.
- The exclude form lets `condition_roles` include the Anonymous/Authenticated roles; the recipient
  `roles` select excludes those two pseudo-roles.
