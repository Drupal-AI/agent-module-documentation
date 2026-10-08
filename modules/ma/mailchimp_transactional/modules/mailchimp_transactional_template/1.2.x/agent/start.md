# Mailchimp Transactional Templates — agent index

Submodule of **mailchimp_transactional**. Maps Drupal module/mail-key pairs to a Mailchimp
Transactional template + editable content area, via a **config entity** ("Template Map"). At send
time it overrides the base send service to route matching mail through the API's `sendTemplate()`.

- **The `mailchimp_transactional_template` config entity, admin route, permission, the send
  override, and the alter hook** → [configure/template-maps.md](configure/template-maps.md)

Key facts:
- Config entity type id `mailchimp_transactional_template` (class `Entity\TemplateMap`), config
  prefix `mailchimp_transactional_template.mailchimp_transactional_template.<id>`. Exported keys:
  `id`, `label`, `template_name`, `content_area`, `only_use_merge_vars`, `mailsystem_key`.
- Admin/list route `mailchimp_transactional_template.admin` at
  `admin/config/services/mailchimp_transactional/templates`; permission
  `administer mailchimp transactional templates` (restricted).
- `MailchimpTransactionalTemplateServiceProvider` swaps `mailchimp_transactional.service` to
  `TemplateService`, which uses a matching map (else `default-system`, else base send) and calls
  the API `sendTemplate()`.
- Hook `hook_mailchimp_transactional_template_map_alter(TemplateMapInterface, $module_key, $module)`.
- Helper functions in the `.module`: `mailchimp_transactional_template_load_entities()`,
  `..._load_by_mailsystem()`, `..._usage()`. No plugin type, no Drush.
