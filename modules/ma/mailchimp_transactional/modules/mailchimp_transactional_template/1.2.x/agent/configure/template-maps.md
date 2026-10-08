# Configure Template Maps

## Admin UI

*Configuration → Web Services → Mailchimp Transactional → Templates*
(`admin/config/services/mailchimp_transactional/templates`, route
`mailchimp_transactional_template.admin`). Requires `administer mailchimp transactional templates`
and the shared `_mailchimp_transactional_configuration_access_check` (base module API key set).
**Add Template Map**, then pick the Mailchimp template, the content area (editable region) to fill,
and which mail (module/key or site default) it applies to.

Prerequisite: the templates themselves must already exist in your Mailchimp Transactional account,
with at least one editable content region.

## The config entity — `mailchimp_transactional_template`

Class `Drupal\mailchimp_transactional_template\Entity\TemplateMap` (`@ConfigEntityType`,
`admin_permission = "administer mailchimp transactional templates"`). Config object name:
`mailchimp_transactional_template.mailchimp_transactional_template.<id>`. Exported fields
(schema `mailchimp_transactional_template.schema.yml`):

| Field | Meaning |
|---|---|
| `id` | Machine name. |
| `label` | Human label. |
| `template_name` | The Mailchimp Transactional template identifier to use. |
| `content_area` | The template's editable content region to inject the Drupal email body into. |
| `only_use_merge_vars` | If true, do not inject body content — rely on merge variables only. |
| `mailsystem_key` | Which mail this applies to: a `<module>_<key>` id, a bare `<module>`, or `default-system`. |

Create via API/config:

```php
\Drupal::entityTypeManager()->getStorage('mailchimp_transactional_template')->create([
  'id' => 'default_brand',
  'label' => 'Default brand template',
  'template_name' => 'site-branded',
  'content_area' => 'main',
  'only_use_merge_vars' => FALSE,
  'mailsystem_key' => 'default-system',
])->save();
```

```
drush config:get mailchimp_transactional_template.mailchimp_transactional_template.default_brand
```

## The send override (`TemplateService`)

`MailchimpTransactionalTemplateServiceProvider::alter()` sets the class of the base service
`mailchimp_transactional.service` to `TemplateService`. On send, `TemplateService`:

1. Finds the Template Map for the current module/key via
   `mailchimp_transactional_template_load_by_mailsystem($module_key, $module)`, which matches the
   exact `<module>_<key>`, then the bare `<module>`, then a `default-system` map.
2. If a map is found, calls the API `sendTemplate($message, $template_name, $template_content)`,
   placing the rendered body into `content_area`.
3. If no map matches, delegates to the base `Service::send()` (plain send).

`mailchimp_transactional_template_usage()` reports which mailsystem keys point at this mailer and
their assigned template maps (used by the admin UI).

## Hook

```php
function mymodule_mailchimp_transactional_template_map_alter(
  \Drupal\mailchimp_transactional_template\Entity\TemplateMapInterface $template_map,
  string $module_key,
  string $module
): void {
  // Swap the template for certain keys, etc.
}
```

Invoked from `..._load_by_mailsystem()` after a map is selected.
