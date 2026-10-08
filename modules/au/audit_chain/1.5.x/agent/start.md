<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Chain — agent index

**Tamper-evident, hash-chained audit logging for any Drupal module** — optional HMAC signing, at-rest encryption,
prefix seal, scheduled keyed verification, and data-minimized off-system evidence export. Depends on core `user`,
`key`, `encrypt`. Version **1.5.0**. Core `^10.6 || ^11.3`, PHP `>=8.1`.

**Security-positive** audit primitive — hash-chaining makes the log tamper-evident; HMAC (Key module) proves
authenticity; Encrypt protects metadata at rest. Guarantees depend on **protecting the signing/encryption keys** (a
leaked signing key lets an attacker forge the chain). No access role beyond the admin settings form
(`administer site configuration`).

Since 1.3.x: **1.4.0** = scheduled keyed verification + status-report health + failure event/log; **1.5.0** =
off-system evidence export.

- **Configure it** (signing key, retired keys, encryption profile, streaming, scheduled verification, export) →
  [configure/audit_chain.md](configure/audit_chain.md)
- **Drush commands** (`verify`, `seal`, `reencrypt`, `export`) → [drush/audit_chain.md](drush/audit_chain.md)
- **Write to / read the chain programmatically** (services, `AuditChainLoggerInterface`, collector, failure event) →
  [api/audit_chain.md](api/audit_chain.md)
