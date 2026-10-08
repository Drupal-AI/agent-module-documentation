# SSO Connector – Permissions — manual setup guide

**SSO Connector – Permissions** (`sso_connector_permissions`) provides centralised
role and permission management for an SSO network. The Identity Provider becomes
the source of truth: it defines per-Service-Provider role mappings and per-user
overrides, works out each user's effective roles for each SP, and pushes signed
updates out to the registered Service Providers.

In a federation of sites, keeping "who has which role where" consistent by hand is
error-prone. This module centralises that decision on the IdP. There it lets you
define per-SP role mappings (this IdP role becomes that SP role) and per-user role
and granular permission overrides (extra permissions to add, or restricted ones to
exclude). It resolves each user's effective SP roles and pushes HMAC-SHA256 signed
updates to registered SPs — via a queue and cron, or immediately. On the SP side,
the module registers with the IdP, applies inbound pushes, and can pull the full
permissions manifest on cron (throttled).

Registration is deliberately gated: an SP self-registers, but no signing key is
issued until an administrator approves it, and registration is rate-limited.
Inbound data is handled fail-closed — HMAC verification with a replay window, plus
a privilege-escalation guard that strips restricted permissions and never touches
admin roles. Outbound calls are SSRF-guarded (HTTPS only; private, loopback, and
reserved IPs blocked). Per-site secrets — the API key, signing secret, and
registration secret — live in `settings.php` or State, never in exportable
configuration, and the global SSO JWT secret is never reused for permission
signing.

Because these forms govern cross-site role assignment, the module's permissions
are strong and should be restricted to trusted administrators only:
`administer sso connector permissions`, `manage sso site registrations`, and
`view sso permissions report`.

This is a submodule of the SSO Connector suite. It depends on **SSO Connector**
(`sso_connector`), core **User**, core **Serialization**, and core **Help**,
requires PHP 8.1 or newer, and runs on Drupal 11.2 (or 12).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside SSO Connector.

## How to set it up

On the **IdP**, you register the Service Provider sites (approving each
registration, which is what releases its signing key) and define the per-SP role
mappings, plus any per-user role or permission overrides. A permissions report
lets you review the resulting assignments. On each **SP**, enabling the module and
registering with the IdP is enough for it to receive pushes and pull the manifest
on cron. Grant the three administrative permissions above only to people you trust
to control cross-site role assignment, and keep the per-site secrets in
`settings.php` or State.
