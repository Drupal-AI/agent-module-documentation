# QA Accounts — manual setup guide

**QA Accounts** (`qa_accounts`) is a **development and testing tool** that creates
one dummy user account per user role so you don't have to hand‑build test users.
For every role on the site (except *anonymous*) it makes an active account whose
username, email, and **password are all derived from the role's machine name** —
role `editor` becomes username `qa_editor`, email `qa_editor@example.com`, and
password `qa_editor`. That predictable scheme is exactly what makes it handy for
manual QA and for browser‑automation smoke tests (Behat, Cypress, and the like)
that need a stable login for each role across environments.

> ## ⚠️ Never enable this in production
>
> The whole point of this module is **predictable, guessable credentials on active
> accounts that hold real roles** — including whatever role maps to
> `qa_administrator`. There is **no environment guard in the code**: nothing stops
> it from running on a live site, and the module's own description says *"Never
> enable in production environments."* Anyone who knows the naming scheme can log
> in as any role. Only enable it on local, CI, or throwaway development sites, and
> make sure it is not part of the config you deploy to production.

Accounts are created on install and can be recreated or torn down at any time with
two Drush commands. An optional settings form adds two toggles that spawn or remove
a matching QA account automatically whenever a role is created or deleted. All the
creation and deletion runs through a single service, so custom setup code can call
it too. The module depends only on core's **User** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   **on development sites only**.
2. [Configuration](configuration/index.md) — the two auto‑create/auto‑delete
   settings, the Drush commands, and how to tear the accounts down again.

## Where it lives in the admin menu

The settings form sits at **Configuration → People → QA Accounts**
(`/admin/config/people/qa-accounts`). Be aware of a quirk in this release: because
of a mismatch between the permission name and the route's permission requirement,
in practice **only user 1 can open this form** — see
[Configuration](configuration/index.md) for the details.

## How to use it

Right after enabling, the module has already created the full set of `qa_<role>`
accounts. Log in as any of them using the role machine name as both the username
and the password (for example `qa_editor` / `qa_editor`). To regenerate the set
after adding roles, or to remove them all before a demo or handoff, use the Drush
commands `drush qa_accounts:create` and `drush qa_accounts:delete`. See
[Configuration](configuration/index.md) for the full workflow, including the
important note that the accounts are **not** removed automatically when you
uninstall the module.
