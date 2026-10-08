# Shy One-Time — manual setup guide

**Shy One-Time** (`shy_one_time`) fixes a baffling problem: a user requests a password
reset, opens the email, clicks the link — and is told *"You have tried to use a
one-time login link that has either been used or is no longer valid."* Nobody used it.
What happened is that a corporate mail-security gateway, a link-preview service, or a
search bot followed the URL while the email was in transit, and Drupal dutifully marked
the single-use link as spent before the real person ever clicked. This is especially
common with Microsoft (Outlook, Bing) and sometimes Gmail.

The module stops that from happening. It watches requests to Drupal's password-reset
and one-time login routes (`user.reset` and `user.reset.login`) and, when it
recognises the caller as a bot, it denies or redirects the request *without consuming
the token* — so the link is still valid when the human clicks it. Detection uses the
**CrawlerDetect** library, which knows thousands of bots, crawlers, and spiders by
their User-Agent; on top of that you can add your own list of User-Agents to block
(handy for a specific security appliance your organisation uses). Recognised bots are
redirected to the login form with a 302, and the reset link survives.

It works out of the box with no configuration required — CrawlerDetect alone catches
most offenders. You only need the settings form if you want to add extra User-Agents
to block.

One thing deserves to be said plainly, because it is a **trade-off, not a free win**:
a link that can survive being fetched by a third party is a link that third party
could still *use*. Single-use is exactly what limits the damage when a reset URL leaks
into a shared inbox, a forwarded message, or a proxy log — so you are trading a little
of that protection for reliable delivery. The list of "exempt" callers is matched by
User-Agent, which is trivially spoofable, so it gives no real assurance about *who*
fetched the link. And if a real person's browser happens to match a pattern you
configured, they will be bounced to the login page and can never complete their reset —
so keep any custom User-Agent list narrow and specific. This module is most useful when
you use login-by-email modules (Passwordless, Mail Login, Login with Email only) where
a single valid link is the whole login; a plain Drupal install often does not need it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the optional User-Agent block list.

## Where it lives in the admin menu

The settings form is at **`/admin/config/system/shy_one_time`** (route
`shy_one_time.settings`), behind the **Administer site configuration** permission. You
only need it if you want to block additional User-Agents beyond what CrawlerDetect
already handles.
