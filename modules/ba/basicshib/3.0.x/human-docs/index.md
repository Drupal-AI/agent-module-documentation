# BasicShib — manual setup guide

**BasicShib** (`basicshib`) connects Drupal to a **Shibboleth** single sign-on
(SSO) system. It is the Drupal half of a two-part setup: an external Shibboleth
**Service Provider (SP)** — typically Apache's `mod_shib` sitting in front of your
site — authenticates the visitor against your identity federation (for example
InCommon) and hands a set of attributes to the web server. BasicShib reads those
attributes and logs the matching Drupal user in, creating the account on first
visit if you allow it. Because the SP has already verified the person, Drupal never
asks for or stores a local password on the SSO path.

Out of the box it maps the federated `eppn` attribute to the Drupal username and
email, and tracks the Shibboleth session id so that when the SP session ends or
changes, Drupal logs the user out on the next request. It can optionally integrate
with **Grouper**: you define reusable **Policies** (sets of Grouper group paths)
and **Authorizations** (which Drupal role each policy grants), and BasicShib
adds or removes roles at each login based on the user's `isMemberOf` groups.

BasicShib is deliberately extensible through three plugin types — **user_provider**
(how accounts are loaded or created), **auth_filter** (extra allow/deny rules and
per-request checks), and **grouper** (how groups map to roles) — so you can bend
the behavior to a particular federation without patching the module. It has no
third-party Drupal module dependencies of its own; its real dependency is a working
Shibboleth SP in front of Drupal.

A word on trust: BasicShib takes identity from the attributes the web server
exposes, so the SP must be configured correctly and the `/basicshib/login` path
must be protected so only SP-authenticated requests reach it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the Shibboleth SP prerequisites.
2. [Configuration](configuration/index.md) — the settings forms field by field:
   attribute map, handlers, messages, the auth-filter toggles, and Grouper
   Policies and Authorizations.

## Where it lives in the admin menu

All of BasicShib's admin pages sit under **Configuration → BasicShib**
(`/admin/config/basicshib`):

- **Core settings** (`/admin/config/basicshib/coresettings`) — attribute map,
  handler paths, messages, plugin selection, redirect path.
- **Grouper settings** (`/admin/config/basicshib/groupersettings`) — enable Grouper
  and configure the group-to-role map.
- **Authorizations** and **Policies** (shown once Grouper is enabled) — the
  role-mapping config entities.

Login and logout happen at `/basicshib/login` and `/basicshib/logout`; you expose
login either as a menu link through the SP handler or with the **Shibboleth login**
block.
