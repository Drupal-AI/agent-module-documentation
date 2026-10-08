# First Time Login — manual setup guide

**First Time Login** (`first_time_login`) prompts users to update their password the
first time they log in. When you create an account for someone — or import accounts
in bulk — the initial password is usually a temporary one you set. This module
nudges each user to replace it with their own on that first login, which is good for
password hygiene and onboarding. Once a user has updated their profile, they aren't
prompted again on subsequent logins.

It works through `hook_user_login()`, so it acts *after* the user has authenticated:
it doesn't change how authentication works, it guides the already-logged-in user to
a password-change step. To get the full benefit, treat any admin-set initial
password as temporary and make sure the change actually happens before the user goes
about their work.

An administrator can set a **threshold in days** after which a user will be prompted
to update their profile again — the default is **120 days** — so you can use it for
ongoing password refreshes, not just the very first login. The site's super user
(UID 1) is never prompted. When you first install the module, the "last updated"
timestamp for existing users is set to their last access time so they aren't all
prompted at once.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the threshold number of days for
   re-prompting.

## How to use it

There's little to do beyond enabling the module and (optionally) adjusting the
threshold. Create or import your user accounts as normal; the next time each user
logs in, First Time Login prompts them to update their password. After they do, they
won't be prompted again until the threshold you set has elapsed.
