# Configuration

Setting up hCaptcha is two jobs: **entering your keys and widget options**, and **telling
the CAPTCHA module which forms should use the hCaptcha challenge**. All the module's own
settings live in the `hcaptcha.settings` config object.

## Get your keys

Sign in to your hCaptcha dashboard (<https://www.hcaptcha.com/>) and note your **site
key** (public) and **secret key** (private). hCaptcha also publishes public *test* keys
on its docs site for local development.

## Store the secret key safely (recommended)

The **secret key is a credential** — it verifies submissions on the server. Don't commit
it to version control or bake it into a shared config export. On this DDEV‑based project,
store it in an environment variable instead of plain config:

```bash
# 1. Save the secret into DDEV's dotenv (never commit .ddev/.env)
ddev dotenv set .ddev/.env --hcaptcha-secret-key='0x...your-secret...'
ddev restart

# 2. Confirm it reached the container WITHOUT printing the value
ddev exec 'test -n "$HCAPTCHA_SECRET_KEY"'   # exit status 0 = it is set
```

You can then reference `getenv('HCAPTCHA_SECRET_KEY')` from `settings.php` to set the
config value at runtime (for example via a `$config` override), keeping the secret out of
the database and out of exported configuration. The **site key** is public, so it is fine
to enter directly on the form or in config.

## The settings form

Go to **Configuration → People → CAPTCHA module settings → hCaptcha**
(`/admin/config/people/captcha/hcaptcha`). You need the **administer hcaptcha**
permission. The fields map to `hcaptcha.settings`:

- **Site key** (`site_key`) — your public site key.
- **Secret key** (`secret_key`) — your secret key, used for server‑side verification.
  Prefer supplying this via the environment variable above rather than typing it here on
  production.
- **hCaptcha JS API URL** (`hcaptcha_src`, default `https://hcaptcha.com/1/api.js`) —
  only change this to point at an alternate or self‑hosted endpoint.
- **Theme** (`widget.theme`, default *Light*) — *Light* or *Dark*, to match your site.
- **Size** (`widget.size`, default *Normal*) — *Normal* or *Compact* (good for narrow
  layouts).
- **Tabindex** (`widget.tabindex`, default `0`) — the widget's tab order relative to
  other form fields.
- **Max score** (`widget.max_score`, default `0.8`) — the maximum acceptable risk score
  for **score‑based (invisible) verification**, which requires an **enterprise** hCaptcha
  account. Ignored on standard accounts.

> If **either** the site key or the secret key is empty, hCaptcha does **not** render its
> widget — protected forms fall back to CAPTCHA's built‑in **Math** challenge, so nothing
> is left unprotected while you finish provisioning keys.

You can set the non‑secret values from the command line too:

```bash
drush cset hcaptcha.settings site_key '0x...your-site-key...' -y
drush cset hcaptcha.settings widget.theme dark -y
drush cset hcaptcha.settings widget.size compact -y
drush cget hcaptcha.settings          # read them back
```

## Apply hCaptcha to your forms

Configuring keys is not enough — you must tell the **CAPTCHA** module to use the
*hCaptcha* challenge (its identifier is `hcaptcha/hCaptcha`). Two ways:

**1. Per‑form (a CAPTCHA point).** On the CAPTCHA administration
(**Configuration → People → CAPTCHA module settings**), add a CAPTCHA point for a form
(for example the user registration form) and set its challenge type to *hCaptcha*. Or in
code/Drush:

```php
\Drupal::entityTypeManager()->getStorage('captcha_point')->create([
  'id' => 'user_register_form',
  'formId' => 'user_register_form',
  'captchaType' => 'hcaptcha/hCaptcha',
  'label' => 'User register form',
  'status' => TRUE,
])->save();
```

**2. Site‑wide default.** Make hCaptcha the default challenge for every protected form:

```bash
drush cset captcha.settings default_challenge 'hcaptcha/hCaptcha' -y
```

Tip: CAPTCHA's "administration mode" lets you quickly add a challenge to many forms at
once.

## Troubleshooting

Server‑side verification errors (missing/invalid secret, a site‑key/secret mismatch,
connection failures) are logged to the **hCaptcha** logger channel — check **Reports →
Recent log messages** if the widget appears but submissions are rejected. hCaptcha
validation doesn't depend on a server session, so protected pages stay cacheable.
