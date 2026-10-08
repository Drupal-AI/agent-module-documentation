<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Publish Guard adds an editorial safeguard that warns or blocks content publishing outside configured allowed days and daily time windows.
---
The module implements `hook_form_BASE_FORM_ID_alter()` for `node_form`. `PublishGuardChecker::isPublishingAllowed()` (publish_guard/src/PublishGuardChecker.php:29) compares the current time (in the site default timezone) against configured `allowed_days` and `allowed_start_time`/`allowed_end_time`. In "warn" mode it injects a warning message; in "block" mode it adds a form `#validate` handler that raises a form error when the `status` field is set to published. Users with `bypass publish guard` are exempt, and `administer publish guard` gates the settings form.

Important scope note: enforcement is at the **node edit-form layer only**. It is not an entity access or presave hook, so it does not restrict *viewing* content and it does not intercept programmatic saves, REST/JSON:API writes, migrations, or other entity forms. It is designed to prevent accidental UI publishing during off-hours, not to be a hard authorization boundary. Both permissions are `restrict access: true`.

Typical setup: visit `/admin/config/content/publish-guard`, enable it, choose allowed days, set the daily window and strictness, and optionally customise the message.
---
- Restrict node publishing to business hours.
- Block publishing on weekends.
- Warn (but allow) publishing outside the window.
- Hard-block publishing outside the window.
- Set the allowed days of the week.
- Set the daily start/end publishing time.
- Customise the restriction message shown to editors.
- Grant trusted roles `bypass publish guard`.
- Prevent accidental after-hours go-live.
- Keep an editorial change-freeze window.
- Gate configuration behind `administer publish guard`.
- Combine with a formal content-scheduling module for real scheduling.
- Enforce a change-freeze during a release window.
- Show a custom off-hours warning to editors.
- Vary strictness between warn and block.
- Exempt release managers from restrictions.
