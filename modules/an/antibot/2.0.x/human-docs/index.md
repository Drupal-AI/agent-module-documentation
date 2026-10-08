# Antibot — manual setup guide

**Antibot** (`antibot`) blocks automated spam submissions using JavaScript. A
protected form only submits if the visitor's browser has JavaScript enabled and
the person actually interacts with the page — there is no puzzle, checkbox, or
image challenge to solve, so real visitors never notice it is there. Most spam
bots do not run JavaScript, so they post to the wrong place and are rejected
before the form is ever processed.

Because protection depends on JavaScript, Antibot **requires your visitors to have
JavaScript enabled** to use and submit any form you protect. That is the trade-off
for skipping a CAPTCHA: the check is invisible to humans, but anyone browsing with
JavaScript switched off will be unable to submit a protected form.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to choosing which
forms to protect. If you are looking for terse, token-cheap references for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The Antibot settings page listing the form IDs to protect](images/settings.png)

## Where it lives in the admin menu

Antibot adds a single settings page at **Configuration → User interface → Antibot**
(`/admin/config/user-interface/antibot`). Everything in this guide happens on that
one page — you list the form IDs you want protected and save.

## Contents

1. [Installation](installation/index.md) — install Antibot with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which forms Antibot protects,
   exclude specific forms, and use the debug mode to discover form IDs.
