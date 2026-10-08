# Domain Login Restrict — manual setup guide

**Domain Login Restrict** (`domain_login_restrict`) closes a surprising gap in
Domain-module multi-sites: it stops a user from logging in on a domain their
account is not affiliated with. It is part of the **Domain Access** ecosystem and
depends on both the base `domain` module and `domain_access`.

The gap it fixes is easy to overlook. The Domain module runs several sites from a
single Drupal installation with **one shared user table**, and authentication in
Drupal is global. Domain governs *content* access, not *login* — so an account
created for the German brand can, by default, sign in on every domain the
installation serves. On a group of brands, a set of client sites, or a public
site sitting alongside a partner portal, that is a genuine boundary failure. This
module adds the missing check so that login only succeeds on a domain the account
is actually affiliated with, and it ships a **`login to any domain`** permission
(correctly marked as a restricted-access permission) for administrators and
support staff who legitimately need to reach every domain.

The module does not do anything purely on enable — you switch the restriction on
from the Domain settings, and you can additionally enforce it per domain using
roles. The restriction is applied at login time; a user who is *already* signed in
keeps their session until it expires, so change-of-affiliation takes effect on
their next login.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside its Domain dependencies.

There is no dedicated settings page for this module — its options live on the
Domain module's own forms, described under "How to configure it" below.

## Where it lives in the admin menu

The global switch lives on the **Domain settings** page at **Configuration →
Domain → Settings** (`/admin/config/domain/settings`), in a section labelled
*Domain User: Login restrict*. Per-domain role controls live on each individual
domain's edit form under **Configuration → Domain**
(`/admin/config/domain`).

## How to configure it

**Global affiliation check.** On the Domain settings page, tick the *Login
restrict* checkbox. Once enabled, every login is validated against the domains
assigned to the user (their *Domain Access* field on the user edit screen). If a
user has no affiliation with the domain they are trying to log in on, the module
refuses the login. Grant the **`login to any domain`** permission
(**People → Permissions**) to administrator and support roles so they can bypass
this check and reach any domain.

There is also an *Assign Domain to User* option that automatically affiliates a
newly created account with the current domain, so accounts registered on a given
domain start out belonging to it.

**Per-domain role restriction.** For finer control, edit an individual domain
record (`/admin/config/domain`, then the domain's edit link). You will find a
*Domain User: Login restrict using Role* section listing every role with a
checkbox. When you tick one or more roles there, only users holding one of those
roles may log in on that domain. The same `login to any domain` permission skips
this check. A companion *Assign Role to New User* field lets you automatically
grant selected roles to new accounts created on that domain.
