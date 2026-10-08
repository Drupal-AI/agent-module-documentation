<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# delay_submit — agent orientation

Client-side delay on configured forms' submit buttons to slow bot-like resubmission. Config at `/admin/config/people/delay-submit`.

- SECURITY NOTE (low): `DelaySubmitController::logAttempt` route gated only by `_permission: 'access content'` (effectively anon) and writes a static log line each call → log-flood/DoS only. No data exposure, no mutation. Consider tightening the perm.
- Autocomplete controller = substring filter over static/webform IDs (admin perm, no DB). `showWarning` just adds a message.
- Purely client-side control — not a real anti-bot measure. Pair with CAPTCHA/honeypot.
- Read: `src/Controller/DelaySubmitController.php`.
