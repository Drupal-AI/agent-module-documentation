<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Queue Mail Language makes the parent Queue Mail module send each queued email in that email's own language, instead of formatting it in the site's default language at cron time.

---

This is a small companion submodule of [Queue Mail](https://www.drupal.org/project/queue_mail); it requires the `language` module and the parent `queue_mail`. It has no config, no UI, no permissions, and no settings of its own. Its `hook_queue_info_alter()` swaps the `queue_mail` queue's worker class to `LanguageAwareSendMailQueueWorker` (which extends the parent's `SendMailQueueWorker`). The problem it fixes: because Queue Mail defers sending to cron, by the time a queued mail is dequeued the active language is the cron/default language, so a message built for a French user could be formatted in the site default language. The language-aware worker overrides `setMailLanguage()` / `setActiveLanguage()` so that, when a message's `langcode` differs from the default, it activates that language for formatting and restores it afterward — driven by a dedicated `QueueMailLanguageNegotiator` (service `queue_mail.language_negotiator`, extending core `LanguageNegotiator`) whose `setLanguageCode()` forces negotiation to a specific langcode and then resets the language manager. `queue_mail_update_8003()` in the parent auto-installs this submodule on update to preserve backwards-compatible behavior. Enabling it is purely a behavioral change — there is nothing to configure.

---

- Send a queued password-reset email in the recipient's language rather than the site default.
- Ensure cron-sent transactional mail is formatted in each mail's own `langcode`.
- Fix wrong-language queued emails on a multilingual site using Queue Mail.
- Preserve per-user language for notifications deferred to the queue.
- Keep queued newsletter/digest mails localized to each subscriber's language.
- Restore language-correct mail after moving to cron-based sending with Queue Mail.
- Format a queued order-confirmation email in the customer's checkout language.
- Guarantee translated subject/body render correctly when sent later from the queue.
- Support multilingual sites that offloaded mail sending for performance.
- Avoid a custom queue worker just to re-activate the mail's language at send time.
- Automatically activate and reset the mail's language around formatting on cron.
- Complement Queue Mail without adding any new configuration to manage.
- Maintain backwards-compatible language behavior after a Queue Mail update (auto-installed).
- Send admin vs user notifications each in their intended language from the same queue.
- Use the dedicated language negotiator to force the mail's langcode during send.
- Localize emails triggered by background/batch processes that run under the default language.
