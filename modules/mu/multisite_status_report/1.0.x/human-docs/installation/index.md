# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Update Manager** module (`update`), which Drupal enables automatically
  as a dependency — this is what supplies the update/security data.
- **No third‑party libraries** and no external authentication modules; the HMAC
  signing is implemented with core only.
- **HTTPS** in front of the site. HMAC protects the secret, but the JSON
  responses still contain sensitive site information, so always serve the
  endpoints over TLS.

> This is an early release (1.0.x) marked *not covered* by the security advisory
> policy. Review it before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/multisite_status_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/multisite_status_report -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multisite_status_report -y
```

On install the module automatically:

- generates a **key identifier** and a strong **shared secret**,
- creates a dedicated, **login‑blocked service account** that carries the
  **access multisite status report** permission, and
- **activates** the three endpoints.

Both permissions the module defines (**access multisite status report** and
**administer multisite status report**) are marked *restricted* — keep them off
ordinary roles.

## Verify it worked

Open **Configuration → Development → Multisite Status Report**
(`/admin/config/development/multisite-status-report`) and confirm you can see the
key identifier and the activation switch. To confirm the endpoint itself works,
have your monitoring client send a correctly **signed** request to
`/multisite-status-report/summary` — a signed request returns JSON, while an
unsigned or wrongly signed one is denied (and flood‑counted).
