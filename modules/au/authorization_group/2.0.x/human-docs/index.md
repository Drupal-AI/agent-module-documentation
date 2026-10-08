# Authorization - Group — manual setup guide

**Authorization - Group** (`authorization_group`) connects the
[Authorization](https://www.drupal.org/project/authorization) module to the
[Group](https://www.drupal.org/project/group) module, so that data from an
external identity provider can grant users Group memberships and Group roles
automatically. It is a back-office provisioning plugin — there is no page a
visitor ever touches.

The Authorization module works on a provider/consumer pattern. A *provider* —
LDAP, OAuth, SAML, and so on — supplies proposals about who a user is (their
directory groups, attributes, and the like). A *consumer* applies those
proposals to some part of Drupal. This module adds the **Groups** consumer:
its target is the Group module. In an Authorization profile you add mapping rows
that tie a provider value to a specific Group, and optionally to a specific Group
role.

When a profile is applied, the consumer adds the user as a member of the chosen
group and, if you picked a role, appends that role to their membership. When the
provider no longer grants something, the consumer either strips the affected
roles or — if you enabled the "remove the user from the group when no roles
remain" option — deletes the whole membership. Site-wide (global) group roles are
left untouched, anonymous users are skipped, and empty mappings are ignored. The
module never auto-creates Drupal groups; you create those yourself first.

Because all of this runs inside Authorization's own grant/revoke lifecycle,
there are no routes, endpoints, or request-driven code paths of its own, and it
has no security findings — the only way memberships change is through an
Authorization profile being applied.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Authorization, Group, and a provider.
2. [Configuration](configuration/index.md) — create an Authorization profile,
   choose the Groups consumer, and add mapping rows.

## Where it lives in the admin menu

The module has no settings page of its own. All of its configuration happens
inside the **Authorization** module's profile UI, where you set the consumer of
a profile to **Groups** and add mapping rows. See
[Configuration](configuration/index.md).
