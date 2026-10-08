# Delay Submit — manual setup guide

**Delay Submit** (`delay_submit`) adds a short, client‑side delay before a form's
submit button becomes usable. The submit button is hidden for a configurable
number of milliseconds and then faded in, which discourages the kind of instant,
bot‑like submission that trips anti‑spam checks — and also curbs accidental
double‑submits by real users.

The problem it targets is a familiar frustration: spam bots (and impatient
clickers) submit a form the instant it renders, which can trigger Honeypot,
CAPTCHA or reCAPTCHA "you submitted too fast" rules and leave legitimate users
staring at an "Antibot verification failed" message. Delay Submit takes a
different, passive approach — it simply makes the submit button unavailable for a
brief moment, so a too‑fast submission cannot happen in the first place. You
choose which forms get the delay (by form ID) and how long the delay lasts,
per form.

One thing to be clear about: because the delay is enforced in the browser, it is
a **UX / nuisance‑mitigation** measure, not a hard security control — a
determined bot that bypasses your JavaScript is not stopped by it. Treat it as a
complement to real anti‑spam tools such as
[Honeypot](https://www.drupal.org/project/honeypot) or CAPTCHA/reCAPTCHA, not a
replacement. It requires only Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add form IDs and set per‑form delay
   times.

## Where it lives in the admin menu

Its settings form is at **Configuration → People → Delay Submit**
(`/admin/config/people/delay-submit`), gated by the **administer delay submit
settings** permission.
