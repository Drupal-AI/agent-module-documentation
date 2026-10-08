# Installation

## Requirements

File Gate needs:

- **Drupal 11.4 or newer** (`core_version_requirement: ^11.4`).
- Core's **File** module (`file`), which Drupal enables automatically as a
  dependency.
- Files served through it must be stored on the **`private://`** scheme — public
  files bypass all gating.
- A secure place to keep the **signing secret** (an environment variable, a Key
  entity, or the module's secret registry).

There are no third‑party Composer or PHP library requirements for the core
module.

## Install with Composer

From the project root:

```bash
composer require drupal/file_gate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_gate -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_gate -y
```

## Submodules — enable only what you need

The core module keeps its gate methods dependency-light. Three optional
submodules add gate methods that pull in extra integrations:

| Submodule | What it adds |
|-----------|--------------|
| **File Gate Form** | A coupled form method: Drupal renders a lightweight email / lead-capture form and grants the download on submission. Spam-guarded (honeypot plus per-IP rate limit); a lead-captured event lets you persist leads into Contact, Webform, or a CRM without File Gate storing PII. |
| **File Gate Commerce** | A commerce method: deliver only to a buyer or licensee, re-checked live on every download so expiry and revocation take effect immediately. The bundled checker grants on a completed Drupal Commerce order matching a configured SKU. This is access gating, not DRM. |
| **File Gate Assurance** | An assurance method: gate delivery on a hardware-backed, phishing-resistant OIDC assurance level (PIV/CAC or FIDO2/WebAuthn) proven at any standards-compliant identity provider. Provider-agnostic via OIDC discovery and JWKS. |

Enable a submodule the same way, for example:

```bash
drush en file_gate_form -y
```

## Verify it worked

After enabling, request a gated private file directly at `/system/files/…` as an
unauthorised user — File Gate should **deny** it by default. A file should only
download through File Gate's own signed endpoint after a gate method approves the
request. Then work through [Configuration](../configuration/index.md) to choose a
gate method and store your signing secret.
