# Spambot — manual setup guide

**Spambot** (`spambot`) protects your site from known spammers and spambots by
checking new registrations against the [Stop Forum Spam](https://www.stopforumspam.com)
blacklist — a large, community-maintained database (often abbreviated "SFS") of
email addresses, usernames, and IP addresses that have been reported for spam.
When someone submits the user registration form, Spambot asks the Stop Forum Spam
service whether their email, username, or IP has been reported, and blocks the
registration if it crosses the thresholds you set. It is a good complement to, or
alternative to, a CAPTCHA, because it does not make legitimate users solve a
puzzle.

Spambot does more than guard the registration form. A cron job can scan your
**existing** accounts and log, block, or delete ones that turn out to be
spammers. Each user gets a **Spam** tab where an administrator can check the
account against Stop Forum Spam on demand, report its content back to the service,
and unpublish or delete everything they posted. A bundled Webform handler lets you
apply the same email/username/IP checks to any Webform. Trusted users and roles
can be given a permission that exempts them from every check.

Because the module talks to an external service, a few things are worth knowing:
you can whitelist trusted emails, usernames, and IPs so they are never checked;
you can tune each check's sensitivity independently; and *reporting* spammers back
to Stop Forum Spam requires a free API key from stopforumspam.com. Responses are
cached to keep API traffic down and stay within the service's daily query limits.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form field by field:
   registration checks, thresholds, whitelists, cron scanning, messages, the API
   key, and caching.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Spambot**
(`/admin/config/system/spambot`) and requires the core **Administer site
configuration** permission. Each account also gains a **Spam** tab at
`/user/{user}/spambot`, available to users with the **Administer users**
permission.

## How to use it

Out of the box, once enabled, Spambot immediately starts checking new
registrations by email and IP. To go further, open the settings form to tune the
thresholds and messages, add any whitelists, and — if you want it to police
existing accounts — turn on cron scanning and choose whether matches are logged,
blocked, or deleted. To report spammers back to Stop Forum Spam, register for a
free API key and paste it into the settings. See
[Configuration](configuration/index.md) for every option.
