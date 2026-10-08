# Notify User Default — manual setup guide

**Notify User Default** (`notify_user_default`) flips one checkbox. When an
administrator creates an account at **People → Add user**
(`/admin/people/create`), Drupal shows a *Notify user of new account* checkbox
that is **unchecked** by default. The predictable result is a support problem:
an account is created, nobody tells the new person, and they sit waiting for a
welcome email that was never sent. This module makes that checkbox **ticked by
default**, so staff-created accounts send their welcome email unless someone
deliberately opts out.

That is the entire behaviour. Under the hood it is a single form alter that
sets the checkbox's default to on, and only when that checkbox is present — it
appears solely on the administrative *Add user* form, so the public
registration form is left completely untouched. The checkbox is still fully
editable, so an administrator creating a placeholder or service account can
still untick it before saving.

There is no settings form, no permissions, no configuration, and no Drush
commands. Enable the module and the new default is in effect; uninstall it and
Drupal's original unchecked default returns immediately, with no data or config
left behind.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is nothing to configure. After enabling the module, log in as an
administrator and go to **People → Add user** (`/admin/people/create`). The
*Notify user of new account* checkbox will already be ticked. Fill in the
account and save, and the new user receives the standard welcome email. If you
are creating an account that should *not* be notified — a service or test
account, say — simply untick the box before saving.

Note that this only affects accounts created through this admin form. Accounts
created programmatically, through migrations, or via REST never render this
form, so they are unaffected — send those welcome emails yourself if you need
them.
