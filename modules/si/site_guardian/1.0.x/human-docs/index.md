# Site Guardian — manual setup guide

**Site Guardian** (`site_guardian`) exposes a site's status report and its list of
enabled projects (with available and security updates) as JSON, over two
key-protected endpoints. The idea is central monitoring: instead of logging into
dozens of Drupal admin dashboards to check versions and updates, a monitoring
tool — the companion Site Guardian Client, or any HTTP consumer — can pull the same
information from each site over the network.

Two endpoints are published:
`/site_guardian/status_report` (the same data as **Reports → Status report**:
Drupal, PHP and database versions, cron status, warnings) and
`/site_guardian/enabled_modules_and_updates` (the same data as **Reports →
Available updates**: every enabled project with its version and computed update
status). Both are gated by a strong, randomly generated **access key** that must
be supplied as a `?site_guardian_key=` query parameter.

Be honest about the security model: there is **no login** on these endpoints — the
random key *is* the credential. That makes it convenient for machine-to-machine
monitoring, but it also means the key must be treated like a password and sent
only over HTTPS. To reduce brute-force risk, Site Guardian flood-limits failed key
attempts (10 per hour per IP) and logs suspicious activity. A master **activation**
switch lets you turn the endpoints off without uninstalling, and you can rotate
the key at any time.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form (key, activation,
   notes), the endpoints page, and the security model in plain terms.

## Where it lives in the admin menu

- **Settings** — **Configuration → Development → Site Guardian**
  (`/admin/config/development/site_guardian`), gated by the core **Administer site
  configuration** permission.
- **Endpoints list** — `/admin/config/development/site_guardian/endpoints`, which
  lists the available JSON endpoints with the current key pre-filled.

The module defines no permissions of its own; the admin pages use core
**Administer site configuration**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)). A
   strong random access key is generated automatically on install, and the module
   is activated.
2. Open the [settings form](configuration/index.md), copy the access key, and note
   the endpoint URLs from the **Endpoints** page.
3. Point your monitoring tool (Site Guardian Client or a custom consumer) at the
   endpoints, passing `?site_guardian_key=<key>` — always over HTTPS.
4. Optionally add free-text **site notes** (patch details, special
   considerations); they appear both in the JSON and as an info line on the local
   Status report.
5. Rotate the key from the form whenever you need to; deactivate the endpoints via
   the activation switch if you want to pause monitoring without uninstalling.
