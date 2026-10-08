# Configuration

The top‑level `ldap` module installs nothing configurable itself — you configure the
**submodules** you enabled. Every LDAP admin screen lives under one root,
**Configuration → People → LDAP** (`/admin/config/people/ldap`), and all of them are
gated by the single **Administer LDAP** (`administer ldap`) permission. Grant that
permission only to trusted administrators.

Because every server, mapping, query, and setting is stored as Drupal configuration,
you can build the whole setup on one environment and deploy it to others with
`drush config:export` / `config:import`.

## Recommended setup order

Work through the submodules in this order — each step builds on the one before it.

### 1. Define an LDAP server (LDAP Servers)

This is the foundation. Enable `ldap_servers` and add a server at
**Configuration → People → LDAP → add server**
(`/admin/config/people/ldap/server/add`). On the server form you set:

- The **connection details** — the directory's address, port, and encryption
  (plain, LDAPS, or StartTLS).
- The **bind method** — whether Drupal connects using a dedicated service (bind)
  account or the user's own credentials.
- The **base DNs** — the branches of the directory tree to search.
- The **attribute mappings** — which directory attributes hold the username, the
  email address, and, crucially, the persistent unique identifier (such as
  `objectSid` or `entryUUID`) so that a directory rename doesn't break the linked
  Drupal account.

Before going any further, use the server's built‑in **Test** form to confirm that
Drupal can connect, bind, and look up a sample user. Do not skip this — almost every
LDAP problem is easier to diagnose here than later. You can add several servers, each
with a weight, for failover.

### 2. Map directory entries to Drupal users (LDAP User)

Enable `ldap_user` and go to its screen at
`/admin/config/people/ldap/user`. Here you map LDAP attributes to Drupal user
properties and fields — name, email, department, and so on — and choose the
**provisioning triggers** that decide *when* accounts are created or updated (on
login, on update, on cron, or manually). You can also provision directory entries
*from* Drupal accounts (reverse sync) and decide how to handle "orphaned" accounts
whose directory entry has been removed.

### 3. Turn on LDAP login (LDAP Authentication)

Enable `ldap_authentication` and configure it at
`/admin/config/people/ldap/authentication`. The key choices are:

- The **authentication mode** — *mixed*, where both LDAP and local Drupal accounts
  can log in, or *exclusive*, where only LDAP accounts are accepted.
- The **allowed servers** the login form validates against.
- Optional **allow/deny DN rules** to restrict login to users under a particular
  branch of the directory, an **email template** for when the directory has no mail
  attribute, and **SSO** settings where an upstream module already asserts the
  authenticated username.

### 4. Optional — stored queries and group‑to‑role authorization

- **LDAP Query** (`ldap_query`) lets you save reusable directory searches as
  configuration entities and surface their results in Views. Manage them from the LDAP
  query collection screen.
- **LDAP Authorization** (`ldap_authorization`) grants Drupal roles from LDAP group
  membership. It plugs into the separate **Authorization** module, so you configure the
  actual group‑to‑role mappings (with regex matching and revocation) on an Authorization
  *profile*. Nested groups can be honored so members of a parent group inherit a child
  group's roles.

## Debugging

LDAP Servers adds a debugging area under
`/admin/config/people/ldap/debug`. Turning on its verbose/`watchdog_detail` logging
records detailed bind and search information to Drupal's log, which is the fastest way
to track down connection or mapping problems.

## Where to go deeper

Each submodule has its own detailed reference in the agent docs — start from the
[agent overview](../../agent/start.md), which links out to `ldap_servers`,
`ldap_authentication`, `ldap_user`, `ldap_query`, and `ldap_authorization`.
