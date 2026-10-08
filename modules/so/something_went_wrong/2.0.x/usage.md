<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Something Went Wrong catches Drupal exceptions and sends them to Slack or email.

---

Something Went Wrong **catches exceptions and notifies** — capturing Drupal exceptions/errors and sending them
to a Slack channel or by email, so developers are alerted to problems. It is in the Development package.

Use it for error alerting. It is a developer/ops feature. Security/data handling: exception reports can include
**stack traces, request data and other sensitive details**, and they are **sent externally** (Slack/email egress) —
so send to a **trusted, access-controlled** destination, avoid leaking sensitive data in the notifications, treat
the Slack webhook URL as a secret, and consider redacting. It has no access-control role. Configure the
notification destination.

---

- Catch Drupal exceptions.
- Send them to Slack/email.
- Alert developers to errors.
- Serve development/ops.
- Notify on exceptions.
- Report errors.
- Include stack traces/request data (sensitive) in reports.
- Send them externally (Slack/email egress) to a trusted destination.
- Treat the Slack webhook URL as a secret + consider redacting.
- Have no access-control role.
- Configure the notification destination.
- Handle error alerting.
- Alert errors.
- Configure the destination.
- Send errors.
- Handle the exceptions.
- Notify problems.
- Report exceptions.
- Secure the destination.
- Provide exception alerting.
