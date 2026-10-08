# reCAPTCHA — manual setup guide

**reCAPTCHA** (`recaptcha`) protects your site's forms from spam and automated
abuse by adding Google's reCAPTCHA (v2) challenge — the familiar "I'm not a robot"
checkbox — to any form you choose. It's an extension of the core **CAPTCHA**
module: CAPTCHA provides the framework for attaching challenges to forms, and this
module registers *reCAPTCHA* as one of the available challenge types.

Because it relies on Google's service, reCAPTCHA needs two keys — a **site key**
and a **secret key** — that you generate for free in the Google reCAPTCHA admin
console. You enter those on the module's settings form, then decide (on the CAPTCHA
settings page) which forms should carry the challenge: user registration, login,
the contact form, comments, password reset, webforms, or any custom form. Because
validation does not depend on a stored session solution, reCAPTCHA challenges are
cacheable and work correctly on cached pages served to anonymous users.

The module needs the contributed **CAPTCHA** module and bundles Google's
`google/recaptcha` PHP library for server-side token verification. Once the keys
are in place and a form is assigned the challenge, it starts blocking bots
immediately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and CAPTCHA.
2. [Configuration](configuration/index.md) — enter your Google keys, tune the
   widget, and assign the challenge to forms.

## Where it lives in the admin menu

The reCAPTCHA settings form sits at **Configuration → People → CAPTCHA →
reCAPTCHA** (`/admin/config/people/captcha/recaptcha`, route
`recaptcha.admin_settings_form`). You choose *which* forms get a challenge on the
neighbouring CAPTCHA settings page (`/admin/config/people/captcha`). Access to the
reCAPTCHA settings is controlled by the **Administer CAPTCHA settings /
recaptcha** permission (`administer recaptcha`) — grant it only to trusted roles.
