# Configuration

All settings live in the single config object `gdpr_compliance.settings` (defaults in
`config/install/gdpr_compliance.settings.yml`). Two forms, both behind permission
`administer gdpr compliance`.

## Form 1 — GDPR Form Settings (`/admin/config/gdpr/compliance`, route `gdpr_compliance.settings_form`)

Controls the required consent checkbox on forms.

| Key | Meaning |
|---|---|
| `from-morelink` | URL for the checkbox's policy link (`/path` = internal, `http(s)://` = external). Default `/gdpr-compliance/policy`. |
| `user-register` | 0/1 — add checkbox to `/user/register`. Default 1. |
| `user-login` | 0/1 — add checkbox to `/user/login`. Default 0. |
| `contact_message-mode` | `disable` / `all` / `custom` — apply to contact forms. |
| `contact_message-bundles` | selected contact form bundles (when mode `custom`). |
| `node-mode` / `node-bundles` | same, for node add/edit forms. Default mode `disable`. |
| `webform-mode` / `webform-bundles` | same, for webforms. Default mode `disable`. |

The checkbox itself (`FormWarning::addWarning`) is titled "I have read and agree to the Cookie
& Privacy Policy", is `#required`, and is skipped on `/admin/people/create` and when the form
carries an `administer_users` value. Contact/node/webform detail forms only appear if the
respective module is enabled.

## Form 2 — GDPR Pop-up Settings (`/admin/config/gdpr/compliance/popup`, route `gdpr_compliance.settings_popup`)

Controls the cookie-consent banner (rendered in `hook_page_bottom`, hidden on `/admin/*`).

| Key | Meaning |
|---|---|
| `popup-guests` | 0/1 — show to anonymous. Default 1. |
| `popup-users` | 0/1 — show to authenticated. Default 1. |
| `popup-position` | `top` / `bottom`. Default `bottom`. |
| `popup-morelink` | URL for the "More information" button. Default `/gdpr-compliance/policy`. |
| `popup-text-cookies` | Line 1 text (blank → built-in default). Max 255. |
| `popup-text-analytics` | Line 2 text (blank → default). |
| `popup-btn-agree` | "Agree" button label (blank → "I've read it"). |
| `popup-btn-findmore` | "More information" button label (blank → default). |
| `popup-custom-color` | 0/1 — enable custom colors. |
| `popup-color` | Pop-up background hex (e.g. `#1157cc`); the form also accepts a hex text field. |
| `button-color` | Button hex. |
| `popup-text` / `button-text` | Auto-computed (`black`/`white`) contrast text color — set by the submit handler, not entered directly. |

Colors are validated to 6-hex (`tryHex`) and text color is auto-inverted for contrast. The
banner remembers dismissal via a cookie (`js_cookie`), so it does not reappear once accepted.

## Policy page

`/gdpr-compliance/policy` (route `gdpr_compliance.policy`, permission `access content`) serves
a bundled static HTML policy (`assets/policy/policy-{en,ru,de}.html`) chosen by interface
language (fallback `en`). To change the wording, edit that file or implement
`hook_gdpr_compliance_policy_alter` (see `../hooks/policy_alter.md`), or point the links at
your own node instead.
