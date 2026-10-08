# Configuration

Configuring MTCaptcha is a matter of entering the two keys from your MTCaptcha
account and then choosing which forms should show the challenge.

## Get your keys first

Log in to your MTCaptcha account and register your website's domain. MTCaptcha
gives you two values:

- a **site key** (public — it is sent to the browser so the widget can load), and
- a **private key** (secret — used only server-side to verify challenge responses).

## Open the settings form

1. Log in as a user with permission to administer the module (an administrator by
   default).
2. Go to **Configuration → Development → MTCaptcha settings**
   (`/admin/config/development/mtcaptcha`), or use the module's *Configure* link on
   the **Extend** page.

## The fields

- **Private key** (required) — paste your MTCaptcha private key. Used server-side to
  verify each challenge; see "Keeping the private key secret" below.
- **Enable MTCaptcha for** — choose the audience: All Users, Logged-In Users, or
  Logged-Out Users.
- **MTCaptcha is applied for** — tick the built-in forms to guard: **login**,
  **registration**, **lost password**, **change password**, **comment**, and
  **contact** forms.
- **Other Forms to enable** — a comma-separated list of additional form IDs to
  protect.
- **Show Captcha label in the form** — toggle a "Captcha *" label above the widget.
- **Site key** — paste your MTCaptcha public site key. It appears in the page so
  the widget can render.
- **Theme / skin** — choose one of the built-in MTCaptcha appearances (Standard,
  Overcast, Neowhite, Goldbezel, Blackmoon, Darkruby, Touchoforange, Caribbean,
  Woodyallen, Chrome, Highcontrast).
- **Language** — pick from 60+ supported languages.
- **Captcha Widget size** — Standard or Modern Mini.
- **Advanced → custom configuration** — optionally enable this and paste a raw
  MTCaptcha JavaScript config snippet (generated from MTCaptcha's demo page) for
  full control over how the widget renders. Only trusted administrators should use
  this field, since the snippet is emitted into the page as-is.

Click **Save configuration** when done.

## Keeping the private key secret

The private key is a credential. The module stores it in the site's configuration
(`mtcaptcha.settings`); it is not sent to the browser. It has no built-in Key-module
or environment-variable integration, so treat the value carefully:

- Do not commit it to version control. If you export configuration, keep the
  exported `mtcaptcha.settings.yml` out of any public repository (or override the
  value per environment).
- Restrict who can reach the settings form and view configuration to trusted
  administrators.

## Verify it worked

Log out (or use a private browser window) and open one of the forms you protected —
for example the user login or contact form. The MTCaptcha widget should appear, and
the form should refuse to submit until the challenge is satisfied.
