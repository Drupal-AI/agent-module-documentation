# Project Versions — manual setup guide

**Project Versions** (`project_versions`) exposes a **JSON report** of your site's PHP
version plus every contrib module and theme with its version (and lifecycle info), so
an external monitoring service can track available updates across many Drupal sites
from one central place. It's a maintained, simplified fork of the old System Status
module, hardened for Drupal 10+.

Instead of logging into each site's update report, a fleet‑monitoring tool polls each
site's endpoint and collects the data. There are two endpoints: a plain JSON report
for a logged‑in admin, and an **encrypted** report served at a secret token URL that
an off‑site collector can poll without a Drupal login. The report lists only contrib
(core and field‑type packages are filtered out) and includes lifecycle status, so you
can spot deprecated or end‑of‑life projects across your estate.

Security is built in: on install the module generates two random secrets — a **URL
token** embedded in the encrypted endpoint's address, and an **encryption key** used
to AES‑encrypt the report body. A collector that knows the URL token receives
ciphertext it decrypts with the shared key, so possession of the URL alone yields
only encrypted data.

This guide is written for a **human** setting it up. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

The settings page is at **Configuration → System → Project Versions**
(`/admin/config/system/project-versions`), gated by the core **Administer site
configuration** permission.

There is nothing to *tune* here — the page simply **displays** the two auto‑generated
secrets (the URL token and the encryption key) in read‑only fields, so you can copy
them into your external collector. The three endpoints are:

| What | Path | Who can reach it |
|---|---|---|
| Plain JSON report | `/admin/reports/project-versions` | Users with **Administer site configuration** |
| Encrypted report | `/admin/reports/project-versions/{urlToken}` | Anyone who knows the secret URL token (no login) — returns AES‑encrypted ciphertext |
| Settings page | `/admin/config/system/project-versions` | Users with **Administer site configuration** |

The encrypted endpoint is intentionally reachable without a Drupal login — that's the
design, so external monitors can poll it. If you treat your module inventory as
sensitive, keep the token and key out of public config exports; you can override them
per environment in `settings.php`:

```php
$config['project_versions.settings']['project_versions_url_token'] = getenv('PV_URL_TOKEN');
$config['project_versions.settings']['project_versions_encryption_key'] = getenv('PV_KEY');
```

For the full report payload shape and the encryption details, see the sibling
[`agent/configure/settings.md`](../agent/configure/settings.md).
