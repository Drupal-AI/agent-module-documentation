<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Queue Mail - Mailer Plus routes Advanced Queue job notifications through Mailer Plus (Symfony Mailer) instead of core mail.

---

This submodule of Advanced Queue Mail replaces the mail sender used by the parent module with Mailer Plus
(formerly Symfony Mailer). When enabled it overrides the `advancedqueue_mail.mail_sender` service, auto-detecting
whether Mailer Plus 1.x or 2.x is installed and wiring the matching implementation. Job-event notifications are
then built as typed emails (`advancedqueue_mail` base tag, sub-types `on_success` / `on_retry` / `on_failure`),
so you configure subject, body, recipients, HTML and attachments through Mailer Plus policies rather than the
plain-text templates of the core mail path. It depends on both `advancedqueue_mail` and `symfony_mailer`.

---

- Send Advanced Queue notifications as HTML emails via Mailer Plus.
- Build job-failure emails from a Mailer Plus policy instead of a plain template.
- Add attachments to queue notification emails.
- Use Mailer Plus theming/branding for queue alerts.
- Configure recipients through a Mailer Plus policy per sub-type.
- Support Mailer Plus 1.x sites (EmailFactoryInterface).
- Support Mailer Plus 2.x sites (MailerPlusInterface).
- Register the email types (Job success / Job retry / Job failure) with Mailer Plus.
- Keep using the parent module's event handling while changing only delivery.
- Add a "Skip sending" policy element to suppress sub-types you don't want.
- Migrate an existing Symfony Mailer setup forward after the parent's refactor.
- Let a themer own the queue-notification email layout.
- Expose the `job` object as a template variable for policy templates.
- Centralise all outbound mail (including queue alerts) under Mailer Plus.
- Swap delivery transport without touching queue/event code.
