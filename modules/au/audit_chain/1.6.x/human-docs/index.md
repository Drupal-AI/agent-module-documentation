# Audit Chain — manual setup guide

**Audit Chain** (`audit_chain`) provides tamper-evident, hash-chained audit
logging that any Drupal module can build on. Each log entry is chained to the
previous one by hash, so any later alteration or deletion breaks the chain and
becomes detectable. On top of that it offers **optional HMAC signing**,
**at-rest encryption**, a **"prefix seal"** for historical segments, and
**independent verification** of the chain. Other modules (for example MCP
Sentinel) write their audit trails through it rather than reinventing the wheel.

This is a reusable **audit primitive**, not an end-user feature — you generally
install it because another module needs it, or because you are building
integrity-protected logging yourself. It is security-positive by design:
hash-chaining makes the log tamper-evident, HMAC signing (with a secret from the
Key module) lets you prove authenticity, and Encrypt protects entries at rest.
Entries are written *after* the response is sent, so they stay off the user's
critical path. It depends on core **User** plus the **Key** and **Encrypt**
modules, and it has no access-control role of its own.

Its guarantees rest entirely on **protecting the keys**. Store the HMAC and
encryption keys securely through the Key module — a leaked signing key lets an
attacker forge a consistent chain and defeat the whole point. Verify the chain
periodically (the module provides independent verification) and keep backups of
your seal points.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   alongside Key and Encrypt, and set up the keys.

## How to use it

Audit Chain is configured through the **keys** it uses and the **audit sources**
that write to it:

1. Using the **Key** module, create the keys Audit Chain needs — the HMAC signing
   key and, if you enable encryption, the encryption key. Store them as real
   secrets (an environment-backed key), never in committed configuration.
2. Point Audit Chain at those keys and enable the features you want (HMAC signing,
   at-rest encryption, prefix seal).
3. Let the modules that log through Audit Chain (or your own code) write entries.
4. Periodically run the **independent verification** to confirm the chain is
   intact, and back up your seal points.
