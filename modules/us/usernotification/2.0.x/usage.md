<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Send User Notification lets an administrator email a single, site-wide configured notification message (subject + body, with user and site tokens) to one or more accounts by selecting them on the People admin page and running the "Send notification message to user(s)" action.
---
The module has two parts. First, a settings form at `/admin/config/people/accounts/notification-setting` (permission `administer account settings`) stores one reusable notification: a `subject` and a `message` body in the `usernotification.settings` config object. Both fields accept `user` and `site` tokens (a token browser is shown on the form), so the same template personalizes every recipient. Second, it registers a core Action plugin (`usernotification_action`, entity type `user`) named "Send notification message to user(s)". On the People listing (`/admin/people`), an admin selects accounts, chooses that action from the Actions dropdown, and applies it; the action's `access()` check requires edit access to each target user, so only users the operator may edit are mailed.

For each selected account the action calls Drupal's mail manager with the account's preferred language. `hook_mail()` then token-replaces the stored subject and body against that user, sending the subject as plain text and the body as the message content. The email is dispatched with `Content-Type: text/html`, `From` and `Reply-To` set to the site email (`system.site` `mail`), so the configured body is delivered as an HTML email. There is no per-send editing, no scheduling, no queue, and no on-site display — it is strictly an outbound email triggered on demand from the People page. It is intended for broadcasting the same announcement, coupon, voucher, or activity notice to chosen users. Typical setup: save the subject and body once (using tokens like the user display name and site name), then run the bulk action whenever a batch of users needs the notice.

Note the config object `usernotification.settings` has no install default, so the subject and body must be saved on the settings form before the action can produce a meaningful email.
---
- Store one reusable notification subject and body in site configuration.
- Personalize each email with `user` and `site` tokens (e.g. display name, mail, site name).
- Email selected users in bulk from the People admin page via the Actions dropdown.
- Send the notification to a single specific account from the same action.
- Broadcast an announcement to a chosen set of users.
- Distribute a coupon or voucher code to selected customers.
- Notify users about a new activity, event, or site change.
- Deliver the message in each recipient's preferred language code.
- Send the body as an HTML email (`Content-Type: text/html`).
- Set the site email as both `From` and `Reply-To` on every message.
- Reuse one message template across many recipients without retyping it.
- Restrict who can author the message to holders of `administer account settings`.
- Limit recipients to accounts the operator has edit access to (action `access()` check).
- Combine with core VBO-style user actions already on the People listing.
- Edit the template once and have all future sends pick up the change.
- Use the token browser on the settings form to insert available tokens.
- Send onboarding or welcome-style notices to newly created users.
- Announce policy or terms updates to existing account holders.
- Notify a subset of members about a membership or subscription change.
- Provide a lightweight admin-triggered email path without building a custom mailer.
