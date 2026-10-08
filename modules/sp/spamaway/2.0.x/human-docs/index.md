# SpamAway — manual setup guide

**SpamAway** (`spamaway`) is an anti-spam module for **Webform**. Instead of adding
a CAPTCHA, it adds a Webform **handler** that quietly blocks submissions which look
like spam — either because too many near-identical posts are coming in, or because
one IP address is submitting the same form too many times in a short window. That
keeps your public forms usable for real visitors while dropping the obvious flood.

It ships a single Webform handler plugin, **"SpamAway - Anti spam handler"**
(`spamaway_anti_spam_forms`), which you attach to any individual webform under its
*Settings → Emails / Handlers*. On each submission it runs two checks: an **IP
check** (too many submissions from the same address within a time window) and a
**similarity check** (the new submission is too similar to recent ones on the same
form). When a webform stores its own results, similarity is measured with PHP's
`similar_text()` against a threshold you set; when a webform doesn't store results,
SpamAway keeps its own hashed copies of the chosen field values in a private table
and compares those instead. If a submission trips either check, the handler sets a
"Spam detected" form error and the submission is rejected.

There is **no global settings page** — all tuning is per-webform, on the handler you
add, which is why the module lists no `configure` route. SpamAway requires the
contributed **Webform** module and has no other dependencies. Two escape hatches let
trusted users through: a *bypass* permission for logged-in staff, and a
`settings.php` flag to disable checking entirely in a dev or staging environment.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   make sure Webform is present.
2. [Configuration](configuration/index.md) — add the handler to a webform and tune
   the similarity and IP checks, plus the bypass options.

## Where it lives in the admin menu

SpamAway has no page of its own. You configure it from inside each webform:
**Structure → Webforms**, open a form, then **Settings → Emails / Handlers → Add
handler → SpamAway - Anti spam handler**. The one permission it defines,
*SpamAway bypass spam detection*, is set on the usual **People → Permissions** page.

## How to use it

Enable the module, then attach the SpamAway handler to each webform you want to
protect and adjust its thresholds. High-value forms (quote requests, contact forms)
can get stricter settings; low-risk forms can be left unguarded. See
[Configuration](configuration/index.md) for the field-by-field walkthrough.
