# reCAPTCHA v3 — manual setup guide

**reCAPTCHA v3** (`d8_recaptcha_v3`) integrates Google's **reCAPTCHA v3** — the
invisible, score‑based bot check — into Drupal forms. Unlike reCAPTCHA v2, there
is no "I'm not a robot" checkbox or image challenge: v3 quietly scores each
interaction for how bot‑like it looks, and the site decides a threshold below
which to reject a submission or add friction. Visitors see nothing.

A nice property of this module is that it is **self‑contained** — it does not
require the general‑purpose CAPTCHA module. You supply your Google reCAPTCHA
**site key** and **secret key**, choose a score threshold, and it does the rest.

Three considerations come with any reCAPTCHA integration, and they apply here.
The **secret key is a credential** — keep it out of plain configuration and out of
git. reCAPTCHA **sends interaction data to Google**, which is a privacy/disclosure
point you should cover in your privacy policy. And the **score threshold must be
tuned**: too strict and you block real users, too loose and bots get through.
Because v3 is probabilistic, pair it with other controls for high‑value forms.
The module supports Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Google keys, set the score
   threshold, and choose which forms to protect.

## Where it lives in the admin menu

Once enabled, reCAPTCHA v3 adds a settings form in the **Configuration** area
where you enter your Google site and secret keys and set the score threshold. See
[Configuration](configuration/index.md) for the field‑by‑field walkthrough. You'll
also need a reCAPTCHA v3 key pair from the Google reCAPTCHA admin console before
the module can do anything.
