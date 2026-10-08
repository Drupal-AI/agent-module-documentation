# Captcha Riddler — manual setup guide

**Captcha Riddler** (`riddler`) is an add-on for the **CAPTCHA** module that adds a
"Riddler" challenge type: simple, site-defined question-and-answer riddles that a
visitor must answer correctly to submit a form. Instead of an image or a
third-party service like reCAPTCHA, you ask something a human can answer — "What is
our town's name?", "Do you really hate spam?", "What is 2 + 2?" — to keep automated
bots out. It makes no external calls and collects no user data.

You create riddles as content-free configuration: each riddle has a **question**, a
**solution** (the accepted answer), an optional **hint**, and an enabled/disabled
**status**. A riddle can accept several answers by listing them comma-separated in
the solution (for example `4,four`). Riddles are translatable and exportable as
config, so they deploy across environments like the rest of your site
configuration.

Once you've defined riddles, you attach the **Riddler** challenge to whichever forms
you want to protect using CAPTCHA's normal per-form settings (CAPTCHA points) — for
example the user registration, contact or comment forms. When a protected form
loads, Riddler shows a random enabled riddle as a required text field and checks the
answer on submit, honouring CAPTCHA's global case-sensitivity setting. Riddler
depends on the **CAPTCHA** module (^2) and reuses CAPTCHA's own permission — there
is no separate permission to grant.

> **Caching note:** page caching stays fully enabled only with **exactly one**
> enabled riddle. With two or more enabled riddles, Riddler disables the page cache
> on protected forms so a fresh random riddle is shown each time. Keep a single
> enabled riddle if page cache on those forms matters to you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create riddles and attach the Riddler
   challenge to your forms.

## Where it lives in the admin menu

Riddles are managed under CAPTCHA's admin area at **Configuration → People →
CAPTCHA → Riddler**
(`/admin/config/people/captcha/riddler-riddle`). You attach the challenge to forms
from the main **CAPTCHA settings** page (`/admin/config/people/captcha`). Both are
reached with CAPTCHA's **Administer CAPTCHA settings** permission.
