# GDPR Compliance (gdpr_compliance) 2.0.x

Three GDPR building blocks: a cookie-consent pop-up, a required consent checkbox on key
forms, and a bundled multilingual privacy-policy page. Depends on `js_cookie`. One config
object, two admin forms behind `administer gdpr compliance` (`restrict access: true`).
Runs on Drupal 11 and 12 (`core_version_requirement: ^11 || ^12`).

- **Config keys, the two settings forms, the pop-up, the consent checkbox** →
  [configure/settings.md](configure/settings.md)
- **`hook_gdpr_compliance_policy_alter` — alter the policy page content/context** →
  [hooks/policy_alter.md](hooks/policy_alter.md)

Key facts:
- Config object: `gdpr_compliance.settings` (schema only covers the text/link keys; the
  toggle/color keys are schema-less). Configure routes: `gdpr_compliance.settings_form`
  (`/admin/config/gdpr/compliance`), `gdpr_compliance.settings_popup`
  (`/admin/config/gdpr/compliance/popup`). Labels are config-translatable
  (`gdpr_compliance.config_translation.yml`).
- Pop-up: `hook_page_bottom` → `PageBottom::hook` (`src/Hook/PageBottom.php`), theme
  `gdpr-popup` (`templates/gdpr-popup.html.twig`), library `gdpr_compliance/popup`
  (jQuery + js_cookie). Hidden on `/admin/*`.
- Consent checkbox: form alters wired in `gdpr_compliance.module` to per-form classes in
  `src/Hook/Form*Alter.php` (user register/login, contact_message, node, webform), each
  calling `Utility\FormWarning::addWarning`, required, toggled per bundle.
- Policy page: `/gdpr-compliance/policy` (route `gdpr_compliance.policy`, perm
  `access content`), body = shipped `assets/policy/policy-{en,ru,de}.html`, rendered via
  `inline_template`; `PagePolicy::title()` localizes the title.
- Permission: `administer gdpr compliance` (`restrict access: true`).
