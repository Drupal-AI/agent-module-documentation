# CiviCRM User Synchronisation — manual setup guide

**CiviCRM User Synchronisation with Message Queue** (`cmrf_user_sync`) keeps
Drupal user accounts in step with **CiviCRM contacts**. It consumes CiviCRM
"change messages" through a **CiviMRF / CMRF** connection and, on cron, creates,
updates, blocks, or deletes Drupal users to match what happened in the CRM. When
a new contact appears in CiviCRM, a Drupal account can be created for them; when
a contact's name or email changes, the matching account is updated.

It works by reading a configured CiviCRM **ChangeMessage** definition (which
requires the CiviCRM ChangeMessages extension), enqueuing each message, and
processing the queue on cron. A pluggable **processor** decides what to do with
each message. The **Basic User Sync** processor creates an account when a contact
has none, updates name and email on a match, and blocks a (non-administrator)
account when its email goes empty. The **Portal User Sync** processor adds more:
it assigns configured **roles**, can **notify** users on activation, and can
**delete** synced users according to a delete-or-block policy. Administrator-role
accounts are protected from automatic deletion or blocking in both cases.

This module needs configuration before it does anything, and the sync then runs
unattended on cron. Contacts are matched to accounts through a
`field_user_contact_id` user field (write access to which is limited to users
with **Administer users**). New accounts are created without a password, so users
must reset their password to log in with one.

> **A note on access control.** The configuration form controls mass account
> creation, role assignment, and deletion, yet the route is only gated by the
> **Access administration pages** permission — which is much weaker than the
> impact of those settings. If that permission is held broadly on your site,
> consider restricting the route to a high-privilege permission such as
> **Administer users**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its CMRF Core dependency.
2. [Configuration](configuration/index.md) — choose the connection, message
   definition, and processor, map the fields, and enable the sync.

## Where it lives in the admin menu

The configuration form sits at
`/admin/config/cmrf_user_sync/usersyncconfig`. The synchronisation itself runs
on **cron** — there is no button to press once it is enabled.
