# Email Registration — manual setup guide

**Email Registration** (`email_registration`) lets people register and log in with
their **email address** instead of inventing a separate username. Drupal still needs a
username internally, so the module quietly generates one from the email (the part
before the `@`, cleaned up and made unique) — the visitor never has to think about it.
The result is a lower‑friction signup and login flow that matches what users expect
from most modern sites.

On the registration and account forms it makes the email field required and hides the
username field from users who aren't allowed to change it. On the login form the
"Username" field becomes an email field that authenticates by looking up the account by
its email address. There's a single option — **Allow login with username** — that, when
turned on, lets people sign in with *either* their email or their generated username.

The behavior also reaches the REST/JSON:API login endpoint (so decoupled and mobile
logins accept email too), ships a Drupal Commerce checkout login pane, and provides a
bulk **"Update username"** action so you can regenerate usernames for existing
accounts. It depends only on core's **User** module and defines no permissions of its
own. An optional submodule, **Email Registration (username)**, goes further and uses
the full email address as the username.

> This release is a **release candidate** (`rc`). Its one setting lives on core's
> existing Account settings form — there's no separate settings page to hunt for.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pick the submodule if you need it.
2. [Configuration](configuration/index.md) — the single option and the related
   welcome‑email tip.

## Where it lives in the admin menu

Email Registration has no settings page of its own. Its one option is added to core's
**Account settings** form at **Configuration → People → Account settings**
(`/admin/config/people/accounts`), inside an "Email Registration" section. The bulk
**Update username** action appears on the **People** view (`/admin/people`).
