Mailer is a developer module that turns each outgoing email your site sends into a reusable "MailerMail" plugin. Instead of scattering a `hook_mail`, a template hook and a calling function per message, you bundle everything (template, subject/from/to defaults, message data) into one plugin class and call it from anywhere with three lines of code.

---

Mailer provides a new Drupal plugin type, `MailerMail` (annotation `@MailerMail`, discovered under `Plugin/MailerMail`, managed by the `plugin.manager.mailer_mail` service). Each plugin declares an `id`, a `label`, one or more Twig `templates`, and a `config` class. The config class extends `MailerMailConfigBase` and carries the data passed to the template (subject, from, to, reply-to, message body, langcode, attachments, site logo, front-page URL) with sensible defaults pulled from `system.site`. A plugin's base class (`MailerMailPluginBase`) renders the chosen template in isolation, builds the mail parameters, and hands them to Drupal core's mail manager under the `mailer` module key. To send: get the plugin instance from the manager, mutate its config object, and call `send()`. The module also ships a reusable base HTML email template (`mailer/templates/mailermail--base`) with Twig blocks for header/content/footer, and a minimal admin page (`/admin/config/system/mailer-module`) that just lists the defined plugin IDs. It is a code-first tool with an intentionally minimal UI; it does not configure SMTP transports (that stays with core / a transport module). Two submodules ship with it: `mailer_example` (worked examples) and `mailer_storage` (persist and resend sent mail).

---

- Define a transactional email (welcome, password-changed, order-confirmation) as a single `MailerMail` plugin you can call from anywhere.
- Send a defined mail programmatically: `createInstance($id)`, set subject/message on its config, call `send()`.
- Keep email templates as versioned Twig files in your module instead of database-stored bodies.
- Share one branded HTML email skeleton across many mails by extending `mailermail--base.html.twig` and overriding only the content block.
- Give a mail a custom data object: subclass `MailerMailConfigBase` with extra getters/setters (e.g. an order total, a page link) that the template reads.
- Set per-message sender, reply-to, and recipient at call time via the config object's setters.
- Localize a mail to the recipient: the config resolves the recipient user's preferred langcode (falling back to the site default) so the template renders in their language.
- Attach files to a mail by passing them through the config object's attachments.
- Pick a template dynamically at send time by overriding `getTemplate()` (e.g. one layout for anonymous, another for authenticated users).
- Default a mail's subject and from/to to the site email and site name without any extra configuration.
- Render an email body to a string (without sending) via the plugin's `getMessage()` for previews or tests.
- Trigger a defined mail from a form submit handler, a queue worker, an event subscriber, or a cron hook.
- List which coded emails a site defines by visiting the module's admin page or reading the plugin manager's definitions.
- Send the same mail in bulk by looping over recipients and re-instantiating the plugin per recipient.
- Provide reusable email building blocks in a distribution or install profile as a set of `MailerMail` plugins.
- Alter another module's defined mails through the `mailer_mail_info` alter hook.
- Combine with the `mailer_storage` submodule to automatically archive and later resend everything sent through Mailer.
- Replace ad-hoc `\Drupal::service('plugin.manager.mail')->mail()` calls with named, template-backed plugins that are easier to test and reuse.
- Standardize the from address and HTML content type of all coded mails in one place.
