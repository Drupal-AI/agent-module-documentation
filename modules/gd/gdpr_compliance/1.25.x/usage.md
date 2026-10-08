GDPR Compliance provides basic GDPR building blocks: a site-wide cookie-consent pop-up, a required "I agree to the Cookie & Privacy Policy" checkbox added to key forms, and a bundled multilingual privacy-policy page.

---

The module has three parts. (1) A cookie-consent pop-up rendered in `hook_page_bottom` on all non-admin pages (`PageBottom::hook`), themed via `templates/gdpr-popup.html.twig`, with its dismissal remembered by a cookie using the `js_cookie` library; text, buttons, position, colors and whether it shows to guests/authenticated users are all configurable. (2) A consent checkbox ("I have read and agree to the Cookie & Privacy Policy", required) injected into the user register/login, contact message, node, and webform forms via `hook_form_*_alter` (each toggled per entity type/bundle in settings; `FormWarning::addWarning` skips it on `/admin/people/create` and for users with the administer-users value present). (3) A privacy-policy page at `/gdpr-compliance/policy` (`PagePolicy`), whose body is read from a shipped static HTML file (`assets/policy/policy-{en,ru,de}.html`) chosen by the current interface language, rendered through an `inline_template` with `changed`/`url`/`mail` context and alterable via `hook_gdpr_compliance_policy_alter`. Configuration lives in one config object (`gdpr_compliance.settings`) across two admin forms — *GDPR Form Settings* (`/admin/config/gdpr/compliance`) and *GDPR Pop-up Settings* (`/admin/config/gdpr/compliance/popup`) — both behind the `administer gdpr compliance` permission (`restrict access: true`). Depends on the `js_cookie` module.

---

- Show a site-wide cookie-consent banner to visitors.
- Remember a visitor's cookie-consent dismissal so the banner does not reappear.
- Display the consent pop-up only to guests, only to logged-in users, or both.
- Position the cookie banner at the top or bottom of the page.
- Customize the banner text, "agree" and "more information" button labels.
- Set custom pop-up background and button colors (color widget or hex).
- Link the banner's "More information" button to a privacy policy page or external URL.
- Require a "I agree to the Cookie & Privacy Policy" checkbox on the user registration form.
- Add the consent checkbox to the login form.
- Add the consent checkbox to contact forms (all or selected contact form bundles).
- Add the consent checkbox to node forms for selected content types.
- Add the consent checkbox to selected webforms.
- Serve a ready-made privacy/cookie policy page at `/gdpr-compliance/policy`.
- Serve the policy in English, Russian, or German based on interface language.
- Override or extend the policy content/context via `hook_gdpr_compliance_policy_alter`.
- Point the consent checkbox's policy link at your own policy node/URL.
- Skip the consent checkbox for admin user-creation (`/admin/people/create`).
- Give editors a lightweight consent-capture mechanism without a full consent-management suite.
- Provide a minimal GDPR starting point on a small site without heavy dependencies.
- Auto-show the policy page's last-changed date from the source file mtime.
