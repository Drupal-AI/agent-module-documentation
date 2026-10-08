# Configuration

All settings live in the single config object `gdpr_compliance.settings` (defaults in
`config/install/gdpr_compliance.settings.yml`). Two forms, both behind permission
`administer gdpr compliance`. Labels are config-translatable
(`gdpr_compliance.config_translation.yml`, base route `gdpr_compliance.settings_form`).

## Form 1 — GDPR Form Settings (`/admin/config/gdpr/compliance`, route `gdpr_compliance.settings_form`)

Controls the required consent checkbox on forms (`SettingsFormWarning`).

| Key | Meaning |
|---|---|
| `from-morelink` | URL for the checkbox's policy link (`/path` = internal, `http(s)://` = external). Default `/gdpr-compliance/policy`. |
| `user-register` | 0/1 — add checkbox to `/user/register`. Default 1. |
| `user-login` | 0/1 — add checkbox to `/user/login`. Default 0. |
| `contact_message-mode` | `disable` / `all` / `custom` — apply to contact forms. Default `all`. |
| `contact_message-bundles` | selected contact form bundles (when mode `custom`). |
| `node-mode` / `node-bundles` | same, for node add/edit forms. Default mode `disable`. |
| `webform-mode` / `webform-bundles` | same, for webforms. Default mode `disable`. |

The three entity types (`contact_message`, `node`, `webform`) are only shown if the owning
module (`contact` / `node` / `webform`) is enabled; otherwise the detail is collapsed with a
"module not enabled" note. The checkbox itself (`Utility\FormWarning::addWarning`) is titled
"I have read and agree to the Cookie & Privacy Policy", is `#required`, and is skipped on
`/admin/people/create` and when the form carries a truthy `administer_users` value.

## Form 2 — GDPR Pop-up Settings (`/admin/config/gdpr/compliance/popup`, route `gdpr_compliance.settings_popup`)

Controls the cookie-consent banner (`SettingsPopup`, rendered in `hook_page_bottom`, hidden
on `/admin/*`).

| Key | Meaning |
|---|---|
| `popup-guests` | 0/1 — show to anonymous. Default 1. |
| `popup-users` | 0/1 — show to authenticated. Default 1. |
| `popup-position` | `top` / `bottom` (required radios). Default `bottom`. |
| `popup-morelink` | URL for the "More information" button (required). Default `/gdpr-compliance/policy`. |
| `popup-text-cookies` | Line 1 text (blank → built-in default). Max 255. |
| `popup-text-analytics` | Line 2 text (blank → default). Max 255. |
| `popup-btn-agree` | "Agree" button label (blank → "I've read it"). |
| `popup-btn-findmore` | "More information" button label (blank → default). |
| `popup-custom-color` | 0/1 — enable custom colors. |
| `popup-color` | Pop-up background hex (e.g. `#1157cc`); a `popup-hex` text field can override the color widget. |
| `button-color` | Button hex (color widget, or `button-hex` text field). |
| `popup-text` / `button-text` | Auto-computed (`black`/`white`) contrast text color — set by the submit handler from the chosen colors, not entered directly. |

The `*-hex` text fields are validated to 6-hex (`tryHex`) on submit; the contrast text color
is auto-inverted (`getColorContrastInverse`, YIQ threshold 128). At render, `popup-color` is
re-checked against `/^#([a-f0-9]{6})$/i` and expanded to an `rgba(...)` at opacity 0.9. The
banner remembers dismissal via a cookie (`js_cookie`), so it does not reappear once accepted.

## Policy page

`/gdpr-compliance/policy` (route `gdpr_compliance.policy`, permission `access content`) serves
a bundled static HTML policy (`assets/policy/policy-{en,ru,de}.html`) chosen by interface
language (fallback `en`); `PagePolicy::title()` localizes the page title (Russian gets a
distinct title). To change the wording, edit that file or implement
`hook_gdpr_compliance_policy_alter` (see `../hooks/policy_alter.md`), or point the links at
your own node instead.
