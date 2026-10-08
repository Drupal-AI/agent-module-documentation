# CAPTCHA Pack — manual setup guide

**CAPTCHA Pack** (`captcha_pack`) is a bundle of lightweight, non-image CAPTCHA
challenge types for Drupal's **CAPTCHA** module. It exists to provide effective
alternatives to the traditional distorted-image CAPTCHA, which is undesirable in
plenty of situations — bandwidth or CPU restrictions, and above all accessibility,
since image CAPTCHAs can be as hard for humans as for bots. Each challenge type is a
small submodule you enable only if you want it.

The pack includes a highly configurable **math** CAPTCHA (questions like "two plus
three equals ?"), several **text** challenges (a "lost character" puzzle, a phrase
picker, and an odd-word-out list), a **CSS** CAPTCHA that scrambles the markup order
but reads correctly in a browser, an **ASCII-art** CAPTCHA that renders a code in
figlet-style text, a deliberately trivial **foo** example (type the word "foo"), and
a **random** meta-type that picks one of your enabled types per submission.

A word on expectations: these are lightweight *deterrents*, not strong anti-bot
protection — some (foo and simple math especially) are trivially solvable and are
meant for basic spam deterrence where an image CAPTCHA would be overkill or
inaccessible. Their enforcement is sound, though: each type returns a solution that
the CAPTCHA module stores and validates **server-side**, so protection does not
depend on client-side JavaScript, and challenge pages are marked uncacheable while a
challenge is active.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the pack
   submodules you want, and assign challenge types to forms.

There is no separate settings page for CAPTCHA Pack itself. Each challenge type's
options, and the assignment of a type to a given form, live inside the CAPTCHA
module's administration area (`/admin/config/people/captcha`).

## Where it lives in the admin menu

All configuration happens under the CAPTCHA module at
**Configuration → People → CAPTCHA** (`/admin/config/people/captcha`). Once you have
enabled the submodules you want, their challenge types appear there so you can pick
one per form and adjust that type's settings.
