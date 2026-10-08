# Configuration

Everything CookieCuttr does is controlled from a single settings form, which maps
the CookieCuttr jQuery plugin's options onto Drupal fields.

## Open the settings form

1. Log in as a user with the **`administer cookiecuttr`** permission (grant it under
   Administration → People → Permissions to a trusted role).
2. Go to **Configuration → User interface → CookieCuttr**, or navigate directly to
   `/admin/config/user-interface/cookiecuttr`.

## What you configure here

- **Notice text** — the cookie‑consent message shown to visitors. Localize the
  wording and adjust it for the jurisdictions you serve.
- **"Read more" / cookie‑policy link** — the URL of your cookie‑policy page that the
  notice links to.
- **Accept and Decline button labels** — the wording on the consent buttons.
- **Reset link** — an optional "reset cookie choice" link so visitors can change
  their earlier decision.
- **Appearance and position** — the banner's colors and whether the notice appears
  at the **top** or **bottom** of the page.
- **Script blocking** — whether analytics/other scripts are blocked until consent is
  given.
- **Consent duration** — how long the visitor's choice is remembered (stored via the
  `js_cookie` library).

Save the form. The module then attaches the `cookiecuttr/cookiecuttr` library
site‑wide and passes these settings to the front end via `drupalSettings`, so the
notice renders on every page and remembers each visitor's choice.

## Compliance note

A notice only helps with compliance if the scripts that set cookies actually respect
the visitor's choice. If you rely on the script‑blocking option, verify that your
analytics and embed scripts are genuinely held back until consent, and disclose your
cookie use in the linked policy page.
