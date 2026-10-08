# Audit Trail — manual setup guide

**Audit Trail** (`audit_trail`) provides a tamper-evident audit trail for a Drupal
site. At its core is a canonical `event()` write API for recording audit events,
audit-shaped indexed storage, an admin **viewer with side-by-side diff**, and a
**chain verifier**. Its chained PSR-3 logger uses **HMAC** so the log is
tamper-evident: each entry is chained and signed, which makes any undetected
modification or deletion detectable. Any module can route its log messages into
the chained logger by adding `chain: TRUE` to the log context.

It ships several submodules that extend what can be audited — **entity**
(`audit_trail_entity`), **entity paragraphs** (`audit_trail_entity_paragraphs`),
**file** (`audit_trail_file`), **TSA** (`audit_trail_tsa`, trusted timestamping)
and **user auth** (`audit_trail_user_auth`). It provides its own permissions and
**Drush commands**, and belongs to the Logging package.

Use it when you need a trustworthy audit log for compliance or forensics: an
HMAC-chained, tamper-evident trail resists undetected tampering, which is what
makes it valuable for accountability and incident investigation. Three things
matter when you adopt it. Keep the **HMAC key secret** — its secrecy is exactly
what makes tampering detectable, so store it as a real secret, not in committed
config. **Gate the audit viewer to trusted admins** — audit logs reveal who did
what and may contain sensitive detail. And note that the **TSA** submodule adds
trusted timestamping if you need it. Beyond its own permission, it has no
access-control role.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the settings form, the HMAC key,
   permissions, the viewer, and the chain verifier.

## Where it lives in the admin menu

Audit Trail's settings form is registered under **Configuration** (route
`audit_trail.settings_form`); reach it from the module's **Configure** link on the
**Extend** (module list) page. The audit viewer and chain verifier are reached
from the module's admin pages once it is enabled and you hold its permission.
