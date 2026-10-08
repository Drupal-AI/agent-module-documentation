# CiviMember Roles Sync — manual setup guide

**CiviMember Roles Sync** (`civicrm_member_roles`) keeps Drupal user roles in
step with CiviCRM membership. If your organisation runs CiviCRM behind Drupal,
you almost certainly want "current members get the *member* role, lapsed members
lose it" — and doing that by hand doesn't scale. This module automates it.

You define **association rules**. Each rule maps a CiviCRM membership type plus
the membership statuses that count as "current" (for example *New*, *Current*,
and *Grace*) onto a Drupal role. The module then grants that role to every
contact whose membership matches, and revokes it from contacts whose membership
no longer matches. You can have as many rules as you like — different membership
types mapping to different roles, lifetime members getting a distinct role,
committee members getting an extra role, and so on.

Synchronisation runs automatically on **cron**, and you can also trigger it on
demand — including from the command line via Drush, which is handy right after a
bulk membership import instead of waiting for the next cron run. Because the sync
is **authoritative**, a role that a rule manages will be *removed* on the next
sync if the membership no longer qualifies, so avoid hand-assigning roles that a
rule controls.

This is an integration module: it requires **CiviCRM** to be installed and
bootstrappable from Drupal. The version documented here is the `8.x-1.0-rc1`
release-candidate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (CiviCRM must already be running).
2. [Configuration](configuration/index.md) — create association rules and run the
   sync manually or on cron.

## Where it lives in the admin menu

Association rules are managed from the **Association Rules** listing, reached via
the module's configuration link (the `civicrm_member_role_rule` entity
collection). From there you add, edit, and delete rules, each mapping a
membership type + statuses to a Drupal role.

The module's permissions (defined in `civicrm_member_roles.permissions.yml`)
gate who may administer rules — grant rule administration only to staff who
should be able to change who gets which role.
