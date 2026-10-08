# Configure reCAPTCHA

![reCAPTCHA settings form](../../../../../../../screenshots/recaptcha/3.4.x/settings.png)

UI: `/admin/config/people/captcha/recaptcha` (route `recaptcha.admin_settings_form`, form
`ReCaptchaAdminSettingsForm`). Config object: `recaptcha.settings`.

Keys (`recaptcha.schema.yml`):
```yaml
site_key: ''             # public key from the Google reCAPTCHA console
secret_key: ''           # private key (server-side verification)
verify_hostname: false   # locally validate the response hostname
use_globally: false      # use recaptcha.net endpoints instead of google.com
widget:
  theme: light           # 'light' | 'dark'
  type: image            # 'image' | 'audio'
  size: normal           # 'normal' | 'compact' | 'invisible'
  noscript: false        # render <noscript> fallback widget
```

Setup flow:
1. Enable `captcha` + `recaptcha`.
2. Register the site at google.com/recaptcha/admin and get the site + secret keys.
3. Enter keys and widget options on this form.
4. Go to the CAPTCHA settings (`/admin/config/people/captcha`) and assign the **reCAPTCHA**
   challenge type to the form(s) you want to protect (per form_id, or as the default).

Notes:
- `use_globally` swaps `www.google.com` for `www.recaptcha.net` (for regions where google.com
  is blocked), including the noscript fallback URL.
- Config is exportable; a config event subscriber invalidates cache tags on change.
