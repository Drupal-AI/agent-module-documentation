# Control Admin Access — manual setup guide

**Control Admin Access** (`control_admin_access`) provides a simple admin form for
allowing or denying access to chosen URLs by **IP address**. You enter a list of
trusted IPs (or IP ranges) and a list of URLs to protect; visitors coming from an
allowlisted IP have unrestricted access, while everyone else is blocked from those
URLs and receives an error. It is typically used to lock Drupal's admin area down
to known office or VPN addresses as a defense‑in‑depth hardening layer.

The module works once you configure it — there is nothing to set up beyond filling
in the two fields on its settings form. It requires no modules outside Drupal core
and provides its own permission for who may change the rules.

Please read the two caveats carefully, because both can bite. First, the **client
IP is spoofable** via the `X-Forwarded-For` header unless you have correctly
configured trusted reverse proxies in Drupal — so IP restriction is a hardening
layer, **not** a substitute for authentication. Never rely on it alone; pair it
with strong login security. Second, a **misconfiguration can lock you and every
other admin out** — if you allowlist the wrong address, or your own IP changes, you
lose admin access and have to recover through Drush or the database. Test carefully
before you depend on it, and always keep a recovery path.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field,
   including how the allowlist and blocked‑URL rules interact.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → Control admin
access** (`/admin/config/system/control-admin-access`).
