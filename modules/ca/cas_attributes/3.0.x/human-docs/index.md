# CAS Attributes — manual setup guide

**CAS Attributes** (`cas_attributes`) extends the **CAS** single-sign-on module so that
the attributes your CAS server sends back at login — things like email, display name,
department or group membership — can be turned into Drupal **tokens**, written into
**user account fields**, and used to **assign roles** automatically. It is the piece that
lets your identity provider stay authoritative: instead of maintaining profile fields and
role assignments by hand, you describe the rules once and every CAS login keeps accounts
in sync.

There are three things it does. **Field mappings** copy attribute values into user fields
using token strings such as `[cas:attribute:email]` — applied at registration, on every
login, or never, and optionally overwriting existing values. **Role mappings** grant or
remove Drupal roles based on attribute comparisons (exact match, "contains", or a regular
expression), with options to *deny login* or *deny auto-registration* when no role
matches. And **sitewide token support** stores the attributes in the session so that
`[cas:attribute:…]` tokens resolve anywhere on the site — in webforms, blocks, mail
bodies and the like. Field-mapping tokens work even with sitewide support turned off.

The module works entirely through a single settings form and its config object, plus one
behind-the-scenes event subscriber; it adds no permissions or Drush commands of its own.
It requires the **CAS** module (`^3.0`) and the **Token** module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form, section by section: field
   mappings, role mappings, and sitewide token support.

## Where it lives in the admin menu

Once enabled, the settings form sits alongside CAS at **Configuration → People → CAS →
CAS Attributes** (`/admin/config/people/cas/attributes`), gated by the *Administer account
settings* permission. A read-only helper page at
`/admin/config/people/cas/attributes/available` lists the attributes and tokens for the
currently logged-in CAS user, which is handy for debugging an integration.
