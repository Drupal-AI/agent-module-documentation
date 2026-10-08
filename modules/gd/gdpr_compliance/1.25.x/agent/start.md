# GDPR Compliance — agent index

Three GDPR building blocks: a cookie-consent pop-up, a required consent checkbox on key
forms, and a bundled multilingual privacy-policy page. Depends on `js_cookie`. One config
object, two admin forms behind `administer gdpr compliance` (`restrict access: true`).

- **Config keys, the two settings forms, the pop-up, the consent checkbox** →
  [configure/settings.md](configure/settings.md)
- **`hook_gdpr_compliance_policy_alter` — alter the policy page content/context** →
  [hooks/policy_alter.md](hooks/policy_alter.md)

Key facts:
- Config object: `gdpr_compliance.settings` (schema only covers text/link keys; many keys are
  schema-less). Configure routes: `gdpr_compliance.settings_form`
  (`/admin/config/gdpr/compliance`), `gdpr_compliance.settings_popup`
  (`/admin/config/gdpr/compliance/popup`).
- Pop-up: `hook_page_bottom` → `PageBottom::hook`, theme `gdpr-popup`
  (`templates/gdpr-popup.html.twig`), library `gdpr_compliance/popup` (jQuery + js_cookie).
  Hidden on `/admin/*`.
- Consent checkbox: `hook_form_alter` on user register/login, contact_message, node, webform
  forms (`src/Hook/Form*Alter.php` → `FormWarning::addWarning`), required, toggled per
  bundle.
- Policy page: `/gdpr-compliance/policy` (perm `access content`), body = shipped
  `assets/policy/policy-{en,ru,de}.html`, rendered via `inline_template`.
- Permission: `administer gdpr compliance` (`restrict access: true`).
