# Configuration

## Before you start

Register a reCAPTCHA **v3** key pair at
<https://www.google.com/recaptcha/admin/create>. You'll get a **site key** (public,
used in the browser) and a **secret key** (private, used server-side). Make sure you
picked v3 — this module does not use the v2 checkbox challenge.

## Open the settings form

Go to **Configuration → Web services → ReCaptcha Element**
(`/admin/config/services/recaptcha_element`). You need the **Administer
recaptcha_element** permission. The form has these fields:

- **Enabled** *(on by default)* — the master switch. When you turn it **off**, the
  reCAPTCHA elements simply don't render and no verification runs. This is the clean
  way to disable reCAPTCHA on dev and staging without changing any form code.
- **Site key** — your public reCAPTCHA v3 site key (up to 40 characters). Required.
- **Secret key** — your private reCAPTCHA v3 secret key (up to 40 characters).
  Required. Treat this like a password — see the note in
  [Installation](../installation/index.md) about keeping it out of version control.
- **Action** *(default `default`)* — the reCAPTCHA "action" name executed and
  verified. Naming actions per form gives you better analytics and adaptive risk
  scoring in the Google admin console.
- **Threshold** *(default `0.5`)* — the minimum passing score, from `0.0` (bot) to
  `1.0` (human). Submissions scoring below this are rejected. Raise it for stricter
  protection, lower it if legitimate users are being blocked.
- **Verify hostname** *(off by default)* — when on, the server also checks that the
  request's hostname matches. Only enable this if you turned **off** "Verify the
  origin of reCAPTCHA solutions" (domain verification) in the Google key settings.
- **Error message** — the message shown to the user when verification fails. Defaults
  to "Antibot verification failed, please try again." It's sanitized before display.
- **Log successful responses** *(off by default)* — when on, successful verifications
  are also logged (failures are always logged). Turn it on temporarily to see the
  scores real submissions get, so you can tune the threshold, then turn it off to
  keep your logs quiet.

Click **Save configuration**. Changing the site key automatically rebuilds the Google
API script URL.

### Setting values with Drush

```bash
drush config:set recaptcha_element.settings site_key '6Lc...' -y
drush config:set recaptcha_element.settings secret_key '6Lc...' -y
drush config:set recaptcha_element.settings element_defaults.threshold '0.7' -y
```

## Protect a webform

1. Edit the webform and go to its **Settings → Emails / Handlers** tab.
2. Click **Add handler** and choose **reCAPTCHA Element**.
3. Configure the handler:
   - **Use reCAPTCHA Element defaults** — leave checked to use the global action,
     threshold, hostname, and error-message settings above. Uncheck it to set a
     per-webform override (a sub-form with the same action / threshold /
     verify-hostname / error-message fields appears).
   - **Override the element name** — optional; lets you set a custom machine name for
     the hidden token input if the default clashes.
4. Save. Every submission of that webform is now score-checked.

## Protect a custom form (developers)

Add an element of `#type => 'recaptcha_element'` to your form. Anything you omit falls
back to the global defaults:

```php
$form['antibot'] = [
  '#type' => 'recaptcha_element',
  // Optional per-element overrides:
  '#recaptcha' => [
    'action' => 'contact_form',
    'threshold' => 0.7,
    'verify_hostname' => FALSE,
    'error_message' => 'Please try again.',
  ],
];
```

The element attaches the JavaScript that fetches the token on submit (it also handles
AJAX submissions) and validates it server-side. When the global **Enabled** switch is
off, the element hides itself and skips validation, so you don't need to touch this
code per environment.

## A note on the threshold

reCAPTCHA v3 scores are probabilistic. Start at the default `0.5`, turn on **Log
successful responses** for a while, and watch the scores real users receive. If good
submissions cluster well above your threshold you can tighten it; if legitimate users
are being blocked, loosen it. Consider a stricter threshold on high-value forms and a
more lenient one on low-risk forms.
