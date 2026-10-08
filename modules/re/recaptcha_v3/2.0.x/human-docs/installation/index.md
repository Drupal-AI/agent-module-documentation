# Installation

## Requirements

reCAPTCHA v3 runs on **Drupal 10 or 11** and depends on:

- **CAPTCHA** (`captcha`) — the core spam-protection framework this module extends.
  reCAPTCHA v3 registers itself as a new challenge *type* within CAPTCHA, and you
  assign it to forms through CAPTCHA's per-form points. Composer pulls it in
  automatically, and `drush en` enables it for you.
- **`google/recaptcha`** — the Google reCAPTCHA PHP library used to verify the
  score server-side. This is a Composer library dependency, installed
  automatically with the module.

> **Not the same as the reCAPTCHA (v2) module.** reCAPTCHA v3 is a separate project
> from the `recaptcha` module (which provides reCAPTCHA v2 — the checkbox and image
> challenges). The two can coexist on a site — both are CAPTCHA challenge types —
> but reCAPTCHA v3 needs its own **v3-type** keys and does not reuse the
> `recaptcha` module's v2 keys.

## Install with Composer

From the project root:

```bash
composer require drupal/recaptcha_v3 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `drupal/captcha`
and the `google/recaptcha` library as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/recaptcha_v3 -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en recaptcha_v3 -y
```

This also enables the **CAPTCHA** module if it is not already on. Once enabled, the
**reCAPTCHA v3** tab appears under **Configuration → People → CAPTCHA**
(`/admin/config/people/captcha/recaptcha-v3`).

## Register your site with Google (v3 keys)

Before the module can do anything you need a reCAPTCHA **v3** site key and secret
key from Google:

1. Go to the [Google reCAPTCHA admin console](https://www.google.com/recaptcha/admin)
   and sign in with a Google account.
2. Register a new site.
3. When asked for the reCAPTCHA type, choose **reCAPTCHA v3** — *not* v2. This is
   what makes the keys score-based. (v2 keys will not work with this module.)
4. Add the domain(s) your site runs on.
5. Submit the form. Google shows you a **Site key** and a **Secret key** — keep this
   page open (or copy both values), you will paste them into Drupal next.

## Verify it worked

Log in as an administrator and go to
`/admin/config/people/captcha/recaptcha-v3`. You should see the **reCAPTCHA v3
settings** page with **Site key** and **Secret key** fields:

![The reCAPTCHA v3 settings page after installation](../images/settings.png)

If the page loads with the CAPTCHA tabs across the top (including **reCAPTCHA v3**
and **reCAPTCHA v3 actions**), the module is installed correctly. Next, enter your
keys and define a challenge in [Configuration](../configuration/index.md).
