<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flagger Notify emails users when content they flagged (with selected flags) is updated.

---

Flagger Notify sends notifications to users when content they flagged — using selected flags — is later updated, processed via Cron. It lets members 'follow' content by flagging it and be told when it changes, without manual checking.

Administration is gated by `administer flagger notify`. Depends on core `node`, `user`, `flag`, and `token`; requires Drupal 11.

---

- Notify users on flagged-content updates.
- Use selected flags to determine follows.
- Process notifications via Cron.
- Let members follow content by flagging.
- Tell users when content changes.
- Gate admin with `administer flagger notify`.
- Depend on core `node`, `user`.
- Depend on `flag` and `token`.
- Require Drupal 11.
- Avoid manual checking.
- Support content following.
- Send update notifications.
- Configure which flags notify.
- Integrate with Flag.
- Use tokens in messages.
- Run on cron.
- Notify flaggers.
- Track flagged-content changes.
