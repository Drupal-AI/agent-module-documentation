# CRM Membership — manual setup guide

**CRM Membership** (`crm_membership`) adds a flexible membership-management framework
to the Drupal [CRM](https://www.drupal.org/project/crm) project. It links CRM Contact
entities to membership types, tracks dated membership periods, and drives activation,
renewal, and expiration through pluggable "term" rules — giving you the foundation for
anything from a simple annual membership to a complex, custom membership system.

Under the hood it defines three things. A **Membership** is the record itself, linking
one or more member contacts to a **target contact** (the organization or household
they are a member of). A **Membership Type** is a configurable bundle that picks a
term plugin and its settings — this is what you set up in the admin UI. And a
**Membership Period** records the concrete start and end dates of each stretch of a
membership's life. Three term plugins ship in the box: **Fixed Duration** (a fixed
calendar term, such as a full year), **Rolling Duration** (each renewal starts from
the previous period's end), and **Lifetime** (never expires). Developers can add their
own term plugins for bespoke rules.

Two behaviors are worth knowing up front. **Expiration is automatic via cron**: a cron
job finds active memberships whose periods have all lapsed and queues them to be marked
expired — so enabling cron is part of a working setup. **Renewal is manual**, done from
a renew form on each membership and gated by a dedicated permission. Access throughout
is enforced by granular per-operation permissions (view, edit, renew, delete), with an
admin override, and unpublished memberships are visible only to administrators.

The module requires the **CRM** and **Duration Field** projects plus core **Datetime
Range**, needs Drupal 11.1+ and PHP 8.3+, and provides its own permissions. A companion
module, **CRM Membership Commerce**, connects it to Drupal Commerce so purchases can
grant memberships.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it alongside CRM and Duration Field.
2. [Configuration](configuration/index.md) — create membership types, choose a term
   plugin, and manage renewal and expiration.

## Where it lives in the admin menu

Membership types are configured at **Structure → CRM → Membership Types**
(`entity.crm_membership_type.collection`). Actual memberships are managed from the CRM
portal at **Memberships** (`/crm/membership`).
