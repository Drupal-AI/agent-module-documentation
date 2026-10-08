<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simplenews Resend adds a permission-gated "Reset newsletter status" operation that flips an already-sent Simplenews issue back to "not sent" so it can be sent again through Simplenews.

---

Simplenews marks a newsletter issue as sent once and, by design, will not send it a second time — the issue's `simplenews_issue.status` field sits at `SIMPLENEWS_STATUS_SEND_READY` and the newsletter admin no longer offers a send button. That is the right default, but it leaves the ordinary "I need to send this again" cases with only bad workarounds: cloning the node (which loses the tie to the original), or editing the status column straight in the database. Simplenews Resend replaces those with one action. On any newsletter node that has finished sending it exposes a "Reset newsletter status" operation (in the node operations dropdown and as a local task tab) that leads to a confirm form; confirming resets the issue status to `SIMPLENEWS_STATUS_SEND_NOT` and saves the node, after which Simplenews treats the issue as unsent and its normal send flow (spool, cron/mail) becomes available again. The module itself sends no mail and changes no recipient targeting — it only clears the sent flag. Who actually receives the re-send, and whether anyone gets a duplicate, is entirely Simplenews' job: it depends on the newsletter category the issue points at and on Simplenews' own spool/subscription handling at send time. Because the follow-up send is a real Simplenews bulk send, treat it with the same care — pick the intended newsletter/category before sending again, and make a correction obvious in the subject so a duplicate-looking issue is not deleted unread. The reset action is gated by a dedicated `reset simplenews status` permission and only appears once an issue has actually been sent.

---

- Re-enable sending for a newsletter that already went out, without cloning the node.
- Resend an issue after fixing a broken link in the body.
- Resend after correcting a wrong date on an event notice.
- Resend after fixing a typo or a pricing error in the copy.
- Resend after repairing a broken newsletter template.
- Recover from a stalled or partially failed send by resetting and sending again.
- Resend an issue after fixing mail/SMTP configuration that blocked the first send.
- Reset the status so the issue can be pointed at a different newsletter category and sent.
- Resend an archive/welcome issue to a list after a delivery problem.
- Avoid editing the `simplenews_issue.status` value directly in the database.
- Give editors a safe, confirm-guarded reset instead of manual DB surgery.
- Restrict who can re-send by granting the `reset simplenews status` permission to a trusted role.
- Reset from the node operations dropdown on the Newsletter Issues listing.
- Reset from the "Reset newsletter status" local task tab on the node itself.
- Keep the original node (and its revisions/URL) intact while making it sendable again.
- Send a corrected reissue after an apology edit to the newsletter.
- Resend an issue whose first send was cancelled or interrupted mid-queue.
- Re-open sending on an issue that was marked sent prematurely.
- Prepare an already-sent issue for another scheduled send window.
- Confirm before every reset, so an accidental click does not re-open a send.
