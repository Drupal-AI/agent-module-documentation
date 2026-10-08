Mailchimp Transactional Templates lets you wrap Drupal's outgoing email in a Mailchimp Transactional template by mapping module/mail-key pairs to a template and one of its editable content areas.

---

This submodule of Mailchimp Transactional defines a `mailchimp_transactional_template` **config entity type** (the "Template Map"). Each map records a Mailchimp template name (`template_name`), the template's editable content region to inject Drupal's email body into (`content_area`), a `mailsystem_key` identifying which module/mail-key (or `default-system`) the map applies to, and an `only_use_merge_vars` flag. At send time the submodule's `ServiceProvider` overrides the base `mailchimp_transactional.service` with `TemplateService`, which looks up a matching Template Map (`mailchimp_transactional_template_load_by_mailsystem()`, falling back to a `default-system` map) and, if found, sends via the API's `sendTemplate()` — placing the Drupal-rendered email content into the chosen content area — otherwise it hands control back to the base send. You manage maps at *Configuration → Web Services → Mailchimp Transactional → Templates* (`admin/config/services/mailchimp_transactional/templates`, permission `administer mailchimp transactional templates`). The actual templates live in your Mailchimp Transactional account (external); the maps are local config entities, and a `hook_mailchimp_transactional_template_map_alter()` lets code adjust the chosen map.

---

- Wrap all site email in a branded Mailchimp Transactional template.
- Use a specific template only for a particular module/mail-key (e.g. commerce order receipts).
- Inject Drupal's email body into a named editable content area of a template.
- Set a default-system template map so every mail sent via Mailchimp uses one template.
- Give password-reset emails a different template from newsletters by mapping their keys separately.
- Keep email markup and styling in Mailchimp while Drupal supplies only the content.
- Clone a template map per module/key to assign templates individually.
- Use only merge variables (skip content injection) with the `only_use_merge_vars` flag.
- Centralize email design changes in Mailchimp without redeploying Drupal.
- Map a webform notification to a themed Mailchimp template.
- Ensure consistent header/footer branding across all transactional mail.
- Fall back gracefully to the plain base send when no template map matches.
- Alter which template map is used at runtime via `hook_mailchimp_transactional_template_map_alter()`.
- Export template maps as config for staging → production deployment.
- Point a map's content area at the correct editable region defined in the Mailchimp template.
- Switch a module's mail from a plain send to a templated send by adding one config entity.
- A/B two templates by re-pointing a map's `template_name`.
- Maintain per-brand templates in a multisite by mapping each site's keys.
- Enable inline-CSS in Mailchimp sending defaults so templated emails render consistently.
- Combine with the base module's message alter hook to add merge/global variables.
