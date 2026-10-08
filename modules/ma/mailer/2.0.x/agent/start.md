# Mailer — agent index

Developer module. Provides the `MailerMail` plugin type: each outgoing email = one plugin
(template + config class). Send via the `plugin.manager.mailer_mail` service. No SMTP config
(uses core mail manager, module key `mailer`). Minimal UI. Deps: none.

- plugins/mailer_mail.md — define a coded email: `@MailerMail` annotation, Twig template,
  config class, discovery, alter hook.
- api/sending.md — send a defined mail programmatically; the config object (setters/getters,
  defaults); `MailerMailPluginBase` methods; `hook_mail` mapping; mail key.

Quick facts:
- Service: `plugin.manager.mailer_mail` (`Drupal\mailer\Plugin\MailerMailPluginManager`).
- Plugin dir: `Plugin/MailerMail/`; annotation `Drupal\mailer\Annotation\MailerMail`;
  interface `MailerMailPluginInterface`; base `MailerMailPluginBase`.
- Config base: `Drupal\mailer\Plugin\MailerMailConfigBase` (implements `MailerMailConfigInterface`).
- Base template: `mailer/templates/mailermail--base` (Twig, `config` variable).
- Admin page (list of plugin IDs only): route `mailer.configuration` →
  `/admin/config/system/mailer-module`, permission `access content`.
- No permissions, no Drush, no settings config, no dependencies.
- Submodules on disk: `mailer_storage` (documented), `mailer_example` (examples, not documented).
