# Pantheon SI Tokens — manual setup guide

**Pantheon SI Tokens** (`pantheon_si_tokens`) exposes **Pantheon Secure
Integration (SI)** connection values — the tunnel host/port constants that
Pantheon injects into the PHP runtime — as ordinary **Drupal tokens**. That lets
you reference an SI tunnel's port from any configuration that accepts tokens (a
Feeds source, an integration's endpoint setting, and so on) without hard-coding
environment-specific values into your config.

The way it works: an administrator lists which PHP constant names should be
surfaced, on a settings form at **Configuration → System → Pantheon SI Tokens**
(`/admin/config/system/pantheon-si-tokens`). Each allowlisted constant is then
published under the **`pantheon_si_tunnel`** token type, with the token name being
the constant name lowercased. For example `PANTHEON_SOIP_LDAP` becomes
`[pantheon_si_tunnel:pantheon_soip_ldap]`. When a token is evaluated the module
returns the runtime value of that constant (or an empty string if it isn't
allowlisted and defined). It depends on the **Token** module, supports Drupal 10.1
and 11, and this is a **beta** release (`1.0.0-beta3`); note the project is marked
**not covered** by the security advisory policy.

By design the module only accepts constants that start with the `PANTHEON_SOIP_`
prefix and hold an integer in the valid port range — a guard that keeps it to its
intended purpose (SI tunnel ports) and prevents accidentally exposing other PHP
constants. Even so, **the allowlist is the security control**: whatever a listed
constant holds is returned verbatim, so never allowlist a sensitive value and then
place its token where unprivileged users can see it. If combined with the
`feeds_enhanced_tokens` submodule, these tokens can be used directly in Feeds
configurations for environment-aware imports.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Token
   dependency with Composer, and enable it.
2. [Configuration](configuration/index.md) — allowlist the SI constants to expose
   and use the resulting tokens.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Pantheon SI Tokens**
(`/admin/config/system/pantheon-si-tokens`), gated by the **Administer site
configuration** permission. See [Configuration](configuration/index.md).
