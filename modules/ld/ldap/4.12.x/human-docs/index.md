# LDAP — manual setup guide

**LDAP** (`ldap`) integrates a Drupal site with an LDAP or Active Directory server so
you can delegate identity and access management to a corporate directory. With it,
staff sign in to Drupal using their existing directory username and password, Drupal
accounts are created and kept in sync from directory data, and Drupal roles can be
granted automatically based on a user's LDAP group membership.

An important thing to understand up front: the top‑level **`ldap`** module is only a
meta package — it has no functionality of its own. All the real work is done by five
cooperating submodules, and you enable just the ones you need:

- **LDAP Servers** (`ldap_servers`) — the required foundation. It defines the LDAP
  *server* connection (address, port, encryption, bind account, base DNs, and the
  attribute mappings for users and groups) and the services that actually talk to the
  directory.
- **LDAP Authentication** (`ldap_authentication`) — validates the Drupal login form
  against your configured servers, with mixed or exclusive modes, allow/deny DN
  rules, email templating, and SSO support.
- **LDAP User** (`ldap_user`) — maps directory entries to Drupal user fields in either
  direction, provisioning and updating accounts on login, cron, or manually, and
  handling orphaned accounts.
- **LDAP Query** (`ldap_query`) — stores reusable directory searches and exposes their
  results to code and to Views.
- **LDAP Authorization** (`ldap_authorization`) — grants Drupal roles from LDAP groups
  (via the separate Authorization module), including revocation when someone leaves a
  group.

The whole suite is built on the `symfony/ldap` PHP bridge and Drupal's `externalauth`
module, and every admin screen lives under one place: **Configuration → People →
LDAP**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including per‑submodule
internals — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the suite with Composer (it pulls
   in the `symfony/ldap`, `externalauth`, and `authorization` dependencies) and
   enable the submodules you need.
2. [Configuration](configuration/index.md) — the recommended setup order: add a
   server, map users, choose an authentication mode, and optionally set up queries and
   authorization.

## Where it lives in the admin menu

Every LDAP admin screen sits under **Configuration → People → LDAP**
(`/admin/config/people/ldap`) and is gated by a single **Administer LDAP**
(`administer ldap`) permission. Because all servers, mappings, queries, and settings
are stored as Drupal configuration entities and objects, the entire suite deploys
cleanly with `drush config:export` / `config:import`.

## How to use it

At a high level: install the project, enable **LDAP Servers** plus whichever
submodules match your goal (authentication, user sync, group‑to‑role authorization,
queries), then configure them in order under **Configuration → People → LDAP**.
Always use each server's built‑in **Test** form to confirm the connection, bind, and a
sample user lookup before going live. The full step‑by‑step is in
[Configuration](configuration/index.md).
