# Configuration

Setting up reCAPTCHA is two jobs: enter your Google keys and widget preferences on
the **reCAPTCHA settings** form, then tell the **CAPTCHA** module which forms
should show the challenge.

## Open the settings form

1. Log in as a user with the **Administer CAPTCHA settings / recaptcha**
   permission.
2. Go to **Configuration → People → CAPTCHA → reCAPTCHA**, or navigate directly to
   `/admin/config/people/captcha/recaptcha`.

## General settings — your keys

- **Site key** *(required)* — the public key from the Google reCAPTCHA console. It
  is embedded in the page so the widget can render.
- **Secret key** *(required)* — the private key used server-side to verify the
  visitor's response with Google. Keep it out of public view.

If either key is empty, protected forms fall back to CAPTCHA's Math challenge.

## Widget settings

These control how the "I'm not a robot" box looks and behaves:

- **Theme** — **Light** (default) or **Dark**, to match your site.
- **Type** — **Image** (default) or **Audio** challenge.
- **Size** — **Normal** (default) or **Compact**, useful in narrow layouts.
- **Enable `<noscript>` fallback** — renders a fallback widget for visitors whose
  browsers have JavaScript disabled.

## reCAPTCHA settings (advanced)

- **Verify the hostname of reCAPTCHA solutions** — when enabled, the module also
  checks locally that the response's hostname matches your site, for stricter
  validation.
- **Use global reCAPTCHA (recaptcha.net)** — routes the widget script and
  verification through `recaptcha.net` instead of `google.com`. Turn this on in
  regions where `google.com` is blocked so the challenge still loads.

Click **Save configuration** when done. Settings are exportable configuration, so
they deploy cleanly between environments (though you'll typically manage the secret
key per-environment).

## Assign the challenge to your forms

Entering keys does not protect anything by itself — you choose the forms on the
CAPTCHA side:

1. Go to **Configuration → People → CAPTCHA**
   (`/admin/config/people/captcha`).
2. Under **Form protection**, add or edit a form entry (identified by its form ID —
   e.g. `user_register_form`, `user_login_form`, `contact_message_feedback_form`),
   and set its **challenge type** to **reCAPTCHA**.
3. Alternatively set reCAPTCHA as the **default challenge type** so it applies to
   newly added forms automatically.

Save, then load the target form as an anonymous user to confirm the reCAPTCHA
widget appears.
