# Mail Redirect — manual setup guide

**Mail Redirect** (`mail_redirect`) intercepts **every** system-generated email
your site tries to send and reroutes it to a single test address or domain you
choose. It exists for one specific situation: testing a site whose database is a
copy of production, full of **real** email addresses. Without it, running through
signup flows, order confirmations, or password resets on that copy would blast
real messages at real people. With it, all of those messages land in one safe
inbox instead.

It works with any mail Drupal generates, redirecting the recipient while leaving
the rest of the message intact — for example `john_smith@about.com` becomes
`john_smith@yourtestdomain.com` (domain mode) or everything goes to a single
`you@yourtestdomain.com` (address mode). A common pattern is to point it at a
catch-all mailbox on a test domain so you can see exactly what the site sent and
to whom.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## ⚠️ This is a testing tool — never run it on production

Because Mail Redirect captures *every* outbound email, enabling it on a live site
does two harmful things at once:

1. **Real users stop receiving mail.** Password resets, order confirmations, and
   notifications never reach them — they all get redirected away.
2. **Their data leaks to your test inbox.** Those redirected emails can contain
   personal data, reset links, and order details, and they all pile up in the
   single test address instead of going where they should.

Use Mail Redirect only on **development and staging** environments (ideally ones
running a copied production database), and make sure it is disabled or absent on
production. If you ever find it enabled on a live site, treat that as a
misconfiguration to fix immediately.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (on non‑production only).
2. [Configuration](configuration/index.md) — choose whether to redirect by domain
   or to a single address, and set the target.

## Where it lives in the admin menu

Its settings form is provided by the `mail_redirect.admin_settings` route, under
**Configuration**. You can also set the same values directly in `settings.php`,
which is the tidiest way to keep the redirect scoped to a specific environment —
see [Configuration](configuration/index.md).
