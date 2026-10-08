# Configuration

Configuring Friendly Captcha is two parts: set up the service on its own settings
form, then tell the CAPTCHA module which forms should use it.

## Open the settings form

1. Log in as a user with CAPTCHA's **Administer CAPTCHA settings** permission
   (Friendly Captcha defines no permissions of its own).
2. Go to **Configuration → People → CAPTCHA → Friendly Captcha**
   (`/admin/config/people/captcha/friendlycaptcha`).

The settings are stored in the `friendlycaptcha.settings` config object, so they
export and deploy between environments.

## Settings

- **API endpoint** — which service verifies the visitor's solved challenge. Choose:
  - **Global** *(default)* — verifies against Friendly Captcha's global hosted service.
    Requires your site key and API key.
  - **EU** — verifies against the EU endpoint, keeping verification traffic in the EU.
    Requires a Business/Enterprise plan.
  - **EU with fallback** — uses the EU endpoint but falls back to the global one if it's
    unavailable. Business/Enterprise plan.
  - **Local** — fully self-hosted: your Drupal site serves the puzzles (at
    `/api/v1/puzzle`) and verifies solutions locally. No account, site key, or API key
    is needed, and no data leaves your server. In local mode, puzzle difficulty scales
    automatically with per-IP request frequency, and client IPs are anonymized.
- **Site key** — the site key from your Friendly Captcha account. Required for all
  endpoints except *local*.
- **API key** — the secret/API key from your account. Required for all endpoints except
  *local*.
- **Enable validation logging** — when on, failed validations are written to the
  `friendlycaptcha` log channel so you can debug rejected attempts. Off by default.

Click **Save configuration**. If the site key or API key is missing (and you're not in
local mode), the module falls back to CAPTCHA's Math challenge and warns
administrators, so your forms stay protected while you finish setup.

## Place the challenge on your forms

Friendly Captcha only *provides* the challenge type — deciding which forms use it is
the CAPTCHA module's job. At **Configuration → People → CAPTCHA**
(`/admin/config/people/captcha`) you can either:

- set **Friendly Captcha** as the site's **default challenge** for all
  CAPTCHA-protected forms, or
- add a **CAPTCHA point** for a specific form (for example the user registration,
  login, password-reset, or a contact/webform) and select Friendly Captcha there.

The widget automatically localizes to the visitor's current language, and because the
challenge is cacheable it keeps working on cached, anonymous pages.
