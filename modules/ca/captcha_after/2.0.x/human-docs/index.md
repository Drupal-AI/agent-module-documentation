# CAPTCHA After — manual setup guide

**CAPTCHA After** (`captcha_after`) shows a CAPTCHA only *after* a configurable
number of unsuccessful submit attempts, rather than on every submission. A
CAPTCHA on every form frustrates legitimate visitors; showing it only once
someone has repeatedly failed aims that friction at likely bad actors while
leaving genuine users alone the first time or two. It is a refinement built on top
of the **CAPTCHA** module.

You set a threshold — the number of failed attempts allowed before the CAPTCHA
appears — and tune it to balance user experience against bot deterrence. It
supports Drupal 8.8 through 11 and depends on the CAPTCHA module.

There is a security trade‑off to understand honestly: allowing the first N
attempts without a CAPTCHA means the first N automated attempts also get through.
So set the threshold **low** enough to bound abuse, and make sure the
attempt‑counting is done **server‑side** and keyed on something an attacker cannot
trivially reset (such as IP or session) rather than a counter the client
controls. The [Configuration](configuration/index.md) page covers this.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (the CAPTCHA module is required).
2. [Configuration](configuration/index.md) — set the attempt threshold and the
   security points to check.

## Where it lives in the admin menu

CAPTCHA After extends the CAPTCHA module, so it is administered alongside CAPTCHA
under **Configuration → People → CAPTCHA** (`/admin/config/people/captcha`). See
[Configuration](configuration/index.md).

## How to use it

Enable the module, then set the attempt threshold to a low value and confirm the
security points on the Configuration page. From then on, protected form
submissions only present a CAPTCHA once a visitor has failed the configured number
of times.
