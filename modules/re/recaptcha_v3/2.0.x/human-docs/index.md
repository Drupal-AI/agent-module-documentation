# reCAPTCHA v3 — manual setup guide

**reCAPTCHA v3** (`recaptcha_v3`) adds Google's score-based, **invisible**
reCAPTCHA v3 as a CAPTCHA challenge on your Drupal forms. Instead of showing a
puzzle for the visitor to solve, reCAPTCHA v3 runs quietly in the background and
returns a **score from 0.0 (almost certainly a bot) to 1.0 (almost certainly a
human)** for each request. You choose the passing **threshold**; submissions that
score at or above it pass silently, and submissions below it are handed off to a
**fallback challenge** (such as a math or image CAPTCHA). Because the scoring is
invisible, legitimate visitors usually never see a challenge at all.

This module does not protect forms on its own — it plugs into the **CAPTCHA**
module and registers reCAPTCHA v3 as a new challenge type. You then assign a
reCAPTCHA v3 challenge to individual forms through CAPTCHA's per-form **CAPTCHA
points**, exactly as you would with any other CAPTCHA challenge.

> **You need your own reCAPTCHA v3 keys.** reCAPTCHA v3 uses a different key type
> than reCAPTCHA v2 (checkbox / image). Keys you created for reCAPTCHA v2 will
> **not** work here — when you register your site in Google's reCAPTCHA console you
> must choose the **reCAPTCHA v3** type to get a v3 site key and secret key.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with a screenshot, from installing the module to entering your
keys and assigning the challenge to a form. If you want terse, token-cheap
references for an AI coding agent instead, read the sibling
[`agent/`](../agent/start.md) docs.

![The reCAPTCHA v3 settings page with the site key, secret key, fallback challenge and other options](images/settings.png)

## Where it lives in the admin menu

The reCAPTCHA v3 settings page sits under **Configuration → People → CAPTCHA →
reCAPTCHA v3** (`/admin/config/people/captcha/recaptcha-v3`). It appears as a tab
on the CAPTCHA administration screen, alongside the other CAPTCHA tabs — **CAPTCHA
Settings**, **Captcha Points**, **reCAPTCHA v3**, and **reCAPTCHA v3 actions**.

## Contents

1. [Installation](installation/index.md) — install reCAPTCHA v3 with Composer,
   enable it, and register your site with Google to get v3 keys.
2. [Configuration](configuration/index.md) — enter your keys, define a challenge
   with an action name and score threshold, and assign it to a form.
