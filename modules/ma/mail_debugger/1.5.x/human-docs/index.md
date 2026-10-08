# Mail Debugger — manual setup guide

**Mail Debugger** (`mail_debugger`) gives you a simple admin form for sending a
test email straight from your site, so you can confirm that mail actually leaves
the server. When someone reports "the site isn't sending email," the cause could
be a broken SMTP transport, a mail module intercepting messages, a DNS/SPF
problem, or a template throwing an error — and the fastest way to tell them apart
is to send something minimal and watch what happens. That is exactly what this
module does.

It provides two forms. The first takes a recipient address, a subject, and a
body, and sends that message. The second sends to a chosen *site user* instead of
a free-text address, which exercises the account-mail path (the same path used by
password resets and similar account emails). Both go through Drupal's mail
manager, so whatever transport and mail-altering modules your site has configured
are in play — which is the whole point: it tests the *real* delivery path, not a
synthetic one. The last message you sent is remembered and repopulated on your
next visit.

Mail Debugger is declared a **development** package and has no dependencies beyond
Drupal core (it supports Drupal 8 through 11). It is meant for development and
staging environments — see the safety note below before enabling it anywhere it
matters.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

This module has no settings form — the two send-test-email forms *are* the module,
and they're described under "How to use it" below.

## Where it lives in the admin menu

Once enabled, the forms live at **Configuration → Development → Mail Debugger**
(`/admin/config/development/mail_debugger`). A second form for sending to a
specific site user sits just below it at
`/admin/config/development/mail_debugger/user`.

## How to use it

1. Go to `/admin/config/development/mail_debugger`.
2. On the first form, enter a **recipient address**, a **subject**, and a
   **body**, then submit. The message is sent through your site's configured mail
   system. Check the destination inbox (or your mail-catching tool) to confirm it
   arrived.
3. To test the account-mail path instead, open
   `/admin/config/development/mail_debugger/user`, pick a **site user**, and send.
   This is handy for confirming that emails addressed to real accounts behave the
   way you expect.

If the message arrives, your transport is working and you can turn your attention
to templates or the specific notification that was failing. If it doesn't, the
problem is upstream in your mail configuration.

## A safety note — keep this on development sites only

Both forms are gated by a single permission, **`access mail_debugger`**, and that
permission is **not** flagged as "restricted" on the Permissions page. Because the
first form sends arbitrary content to an arbitrary address *using your site's own
mail identity* (your domain, and on a well-configured site your aligned
SPF/DKIM), anyone who holds that permission can send convincing mail that appears
to come from your organisation. Grant it only to trusted administrators, and treat
this as a development/staging tool rather than something to leave enabled on a
production site.
