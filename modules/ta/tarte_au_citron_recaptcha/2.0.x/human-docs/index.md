# Tarte au citron Recaptcha — manual setup guide

**Tarte au citron Recaptcha** (`tarte_au_citron_recaptcha`) is a small bridge
between two other modules: the [Tarte au citron](https://www.drupal.org/project/tarte_au_citron)
cookie‑consent manager and Drupal's [reCAPTCHA](https://www.drupal.org/project/recaptcha)
module. Its whole job is to make sure Google reCAPTCHA is only loaded *after* a
visitor has actively agreed to it in the Tarte au citron consent banner.

Out of the box, reCAPTCHA drops Google's third‑party cookies as soon as a page
with a protected form loads — before the visitor has consented to anything.
Under the GDPR and similar privacy rules, that is exactly the kind of thing a
consent banner is supposed to hold back. This module registers reCAPTCHA as one
of the services Tarte au citron controls, so the script (and its cookies) stay
dormant until the visitor opts in. It keeps your spam protection while keeping
your cookie handling honest.

There is nothing to configure on this module itself — it works as soon as it is
enabled, provided both Tarte au citron and reCAPTCHA are installed and set up.
It has no settings form and adds no admin pages of its own; it simply wires the
two modules together. It depends on `tarte_au_citron` and `recaptcha`, and
supports Drupal 10 and 11.

This guide is written for a **human** setting the site up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead — they are terser and cheaper to consume.

## Contents

1. [Installation](installation/index.md) — install the module and its two
   companion modules with Composer, then enable it.

## How to use it

Once all three modules are enabled, configure reCAPTCHA and Tarte au citron as
you normally would (add your reCAPTCHA site/secret keys, enable the Tarte au
citron banner). This module then adds reCAPTCHA to Tarte au citron's list of
managed services automatically. When a visitor lands on a page containing a
reCAPTCHA‑protected form, the widget stays blocked behind the consent banner;
after the visitor accepts, reCAPTCHA loads and works as usual. There is no
separate screen to visit — the behaviour is the module simply being present.
