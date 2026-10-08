<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Masquerade Log extends the Masquerade module so that log entries created while a user is masquerading also record the original (real) user, not just the account being impersonated.

---

Normally a Drupal log entry's user id is the current user, so when an administrator masquerades
as someone else, log lines are attributed to the impersonated account and you lose track of who
really performed the action. Masquerade Log fixes this transparently, with **no configuration**.
Its service provider (`MasqueradeLogServiceProvider`, a `ServiceModifierInterface`) iterates
every service tagged `logger` and wraps it in a decorator (`MasqueradeLogLogger`, a PSR
`LoggerInterface`). On each log call the decorator checks the session's masquerade state
(`\Drupal::service('session')->getMetadataBag()->getMasquerade()`); if the current user is
masquerading, it appends a suffix to the message —
`[masquerading <username>, uid <uid>]` — and adds two context variables, `@original_uid` and
`@original_username`, so structured loggers (such as DbLog) also capture the original user.
When nobody is masquerading the decorator is a pass-through and changes nothing. The module ships
no settings form, permissions, config, plugins, or Drush commands; simply enabling it (with
Masquerade) is the whole setup.

---

- Record the real administrator behind an action performed while masquerading as another user.
- Keep an accurate audit trail on sites where staff impersonate users for support.
- See "[masquerading joe, uid 1234]" appended to log messages during impersonation.
- Add `@original_uid` / `@original_username` context to DbLog (watchdog) rows for structured querying.
- Attribute suspicious activity to the operator, not the impersonated account.
- Satisfy compliance requirements to log who really performed privileged actions.
- Trace a support agent's steps taken while masquerading as a customer.
- Distinguish genuine user activity from admin-impersonated activity in logs.
- Feed the original-user context into external log aggregators via structured logging.
- Improve incident forensics when accounts are shared or impersonated.
- Get original-user attribution across all logger channels at once (dblog, syslog, etc.).
- Avoid writing custom logging code just to capture impersonation in logs.
- Enable original-user logging with zero configuration — just turn the module on.
- Detect misuse of the masquerade feature by reviewing who masqueraded and when.
- Keep security logs meaningful on multi-admin sites that use Masquerade heavily.
- Preserve accountability when an admin fixes a user's content while masquerading.
- Correlate a masqueraded session's log lines back to the operator's uid.
- Provide reviewers a clear "acted as" trail in the log messages themselves.
- Support QA/staging debugging where testers masquerade as different roles.
- Strengthen an audit-logging setup that already relies on core dblog.
