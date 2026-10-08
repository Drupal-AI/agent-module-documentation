# Mail Denylist — manual setup guide

**Mail Denylist** (`mail_denylist`) maintains a list of email addresses (and
domains) that your site should never send mail to. When Drupal is about to deliver
an outbound message, the module checks the recipient against the denylist and, if
it matches, prevents that message from going out.

The main reason to use it is to keep your sender reputation healthy: mailbox
providers watch your **bounce and complaint rates**, and repeatedly emailing dead
addresses or people who've marked you as spam hurts deliverability for everyone
else. By adding those addresses to the denylist, you stop wasting sends on them.
It's also handy as a safety net on non‑production environments — for example, to
block accidental sends to real customer addresses from a staging site.

Mail Denylist is deliberately narrow. It is a simple list that blocks delivery;
it does **not** reroute mail, and it does **not** do pattern or wildcard matching
beyond the addresses/domains you enter. (If you need rerouting or richer matching,
the maintainers suggest looking at the Reroute Email module instead.) It ships a
management UI and its own permissions, and it targets Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — where the denylist lives and how to
   add and remove addresses.

## Where it lives in the admin menu

After installation, manage the denylist at **Configuration → System → Mail
Denylist** (`/admin/config/system/mail-denylist`). See
[Configuration](configuration/index.md) for how to use that page.
