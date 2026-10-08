# Mailchimp Transactional — agent index

Sends Drupal email through the Mailchimp Transactional (ex-Mandrill) API via a **Mail System**
mail plugin. Requires the `mailchimp/transactional` Composer library and the `mailsystem` module.

- **Settings object, admin route, sender wiring, async queue, test email** →
  [configure/settings.md](configure/settings.md)
- **Services, mail plugins, queue worker, and how a message is built/sent** →
  [api/services-and-mail.md](api/services-and-mail.md)
- **Alter/response hooks the module invites** → [hooks/hooks.md](hooks/hooks.md)
- **Permission and route access checks** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `mailchimp_transactional.settings` (schema `config_object`); admin form route
  `mailchimp_transactional.admin` at `admin/config/services/mailchimp_transactional`.
- Mail plugins `mailchimp_transactional_mail` (real) and `mailchimp_transactional_test_mail`
  (test); assign them in Mail System (`mailsystem.settings`).
- Services: `mailchimp_transactional` (`Api`), `mailchimp_transactional.service` (`Service`),
  plus `.test` variants; QueueWorker id `mailchimp_transactional_queue`.
- Permission `administer mailchimp transactional` (restricted).
- Submodules (own docs): `mailchimp_transactional_activity`, `mailchimp_transactional_reports`,
  `mailchimp_transactional_template` — nested under `modules/`.
- No plugin type of its own; no Drush commands.
