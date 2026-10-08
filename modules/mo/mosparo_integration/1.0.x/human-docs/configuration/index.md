# Configuration

Configuring mosparo Integration means creating a **connection** to a mosparo
project (its host and keys), then applying that protection to the forms you want
to guard. You'll get the keys from your own mosparo installation.

## Step 1 — create a project in mosparo

In your mosparo installation, create (or open) a **project** for this Drupal
site. mosparo gives each project a **public key** and a **private key**, and it
is reached at your mosparo **host** URL. Keep those three values handy.

## Step 2 — add the connection in Drupal

In Drupal, add a mosparo **connection** and enter:

- **Host / mosparo URL** — the base URL of your mosparo installation. Use
  **HTTPS**.
- **Public key** — the project's public key (used in the browser-side widget).
- **Private key** — the project's private key, used for the server-side
  verification. **This is a secret.** Note that this module stores the private
  key in Drupal configuration in **plain text**, and configuration can be
  exported — so prefer storing it via the
  **[Key](https://www.drupal.org/project/key)** module or an environment
  variable so it stays out of your config export and version control. With DDEV
  you can store it with `ddev dotenv set .ddev/.env --mosparo-private-key=<value>`
  (restart DDEV afterwards) and reference it through a Key entity.
- **Verify TLS certificate** — **leave this enabled** (the default). There is a
  toggle that can disable TLS certificate verification; only ever consider it for
  a local/self-signed development mosparo, never against a public instance, as
  disabling it exposes the verification to interception.

## Step 3 — apply protection to your forms

How you switch protection on depends on the submodule:

- **CAPTCHA** (`mosparo_captcha`) — in the CAPTCHA module's administration
  (**Configuration → People → CAPTCHA**), set mosparo as the challenge for the
  forms you want to protect.
- **Contact** (`mosparo_contact`) — enable mosparo protection for the core
  contact form(s).
- **Webform** (`mosparo_webform`) — add the mosparo element/protection to the
  relevant webform.

Choose which mosparo connection each protected form uses if you have more than
one.

## How the check works (why it's trustworthy)

When a protected form is submitted, the module calls your mosparo instance to
**verify the submission server-side**: it confirms the submission is submittable
*and* that the required field set matches (defending against tampered fields),
and it **fails closed** — if mosparo can't be reached or returns an error, the
submission is blocked rather than accepted. It does not simply trust a token from
the browser.

## Verify it worked

Submit a protected form as an anonymous visitor. A legitimate submission should
pass; the mosparo box should be present on the form. Check **Reports → Recent log
messages** if submissions are unexpectedly blocked (for example a wrong key or an
unreachable host).
