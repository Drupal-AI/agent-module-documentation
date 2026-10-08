<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ULI Custom Workflow changes messages related to one-time login links and allows those links to be used by users who are already logged in.

---

ULI Custom Workflow customizes the one-time-login (ULI) experience — changing the messages shown around
one-time login links, and allowing such links to be used even by users who are already logged in (core
normally handles the already-logged-in case differently). It works by overriding the controller for the
`user.reset.login` route. It requires PHP 8.x.

Importantly for security, it does **not** weaken the token: its controller calls
`parent::resetPassLogin()` — Drupal core's one-time-login controller — so core's cryptographic hash/
timestamp/expiry validation of the reset link is fully preserved. The module only adjusts messaging and
the already-logged-in behaviour around that validated flow. When adopting, note the behaviour change
(logged-in users may follow one-time links); since the underlying core validation still requires a valid,
user-specific token, this is a UX/workflow change rather than a weakening of one-time-login security.

---

- Customize one-time-login messages.
- Allow logged-in users to use ULI links.
- Override the user.reset.login controller.
- Delegate to core resetPassLogin.
- Preserve core's token validation.
- Require PHP 8.x.
- Keep hash/timestamp/expiry checks.
- Adjust ULI messaging.
- Change already-logged-in behaviour.
- Not weaken one-time-login security.
- Understand it is a UX/workflow change.
- Rely on core validation.
- Follow one-time links when logged in.
- Customize the ULI flow.
- Change reset-link messages.
- Keep security in core's hands.
- Modify ULI workflow.
- Adjust login-link UX.
- Preserve token security.
- Customize reset messaging.
