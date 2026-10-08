# Authorization — manual setup guide

**Authorization** (`authorization`) is a framework that maps data from an
external identity provider — such as LDAP or Active Directory groups — onto
Drupal-side authorizations, such as roles. It does this through configurable
**authorization profiles**, each of which pairs one *provider* plugin with one
*consumer* plugin and a table of mappings between them.

It's important to understand that Authorization is a generic **mapping engine,
not a login mechanism**. It sits on top of the `externalauth` module and, at user
login, asks each enabled profile to reconcile the user: it fetches *proposals*
about the user from the provider (for example, the LDAP groups they belong to),
filters those proposals through the profile's mappings, and then tells the
consumer what to grant (for example, which Drupal roles). If the profile's
synchronization actions allow it, the consumer can also create missing targets
and revoke grants it previously made when they no longer apply — so directory
changes propagate automatically on the next login.

A **provider** plugin (an `@AuthorizationProvider`, such as an LDAP provider
supplied by a module like `ldap_authorization`) returns proposals about the user.
A **consumer** plugin (an `@AuthorizationConsumer`, such as the bundled **Drupal
Roles** consumer) grants a Drupal-side target. Between them sits a table of
mappings: provider mappings say which incoming proposals to match (a group name,
or a regex), and the paired consumer mappings say what to grant when they match.
The recommended pattern is one profile per provider/consumer combination, and
each profile is evaluated in isolation.

Out of the box the project ships only the **Drupal Roles** consumer
(`authorization_drupal_roles`); you supply a provider by installing an
integration module such as `ldap_authorization`. Until a provider plugin is
installed, a profile has nothing to reconcile.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, the Drupal Roles consumer submodule, and a provider module.
2. [Configuration](configuration/index.md) — build an authorization profile,
   field by field, and set the global message option.

## Where it lives in the admin menu

Authorization profiles are managed at **Configuration → People → Authorization**
(`/admin/config/people/authorization/profile`), with a global settings form at
`/admin/config/people/authorization/profile/settings`. Both are gated by the core
**Administer site configuration** permission — the module defines no permissions
of its own.

## How to use it

1. Install and enable the module, the Drupal Roles consumer, and a provider
   module (see [Installation](installation/index.md)).
2. Go to **Configuration → People → Authorization** and add a profile.
3. Choose a provider plugin and a consumer plugin, then build the mapping table:
   for each provider match rule, set the consumer target it grants (for example,
   group `cn=admins` → role `administrator`).
4. Decide when it runs (synchronization modes) and whether it creates and revokes
   targets (synchronization actions).
5. Save and enable the profile. From then on, matching users get their grants
   reconciled at login.
