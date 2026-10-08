# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- The contributed **Webform** module (`drupal/webform`), which Composer pulls in
  automatically with the command below.
- Access credentials (endpoint URL and API key) for the external Live Search
  person‑directory service.

There are no PHP library requirements.

> **A note on security coverage:** this project is **not** covered by the Drupal
> security advisory policy. Combined with the PII and access‑control notes in the
> [overview](../index.md), take care where and how you expose it.

## Install with Composer

From the project root:

```bash
composer require drupal/livesearch_person -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform and update
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/livesearch_person -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en livesearch_person -y
```

This enables Webform as a dependency if it isn't already on.

## Grant the permission

Service configuration is gated by the **administer livesearch** permission. Grant
it to trusted administrator roles at **People → Permissions**
(`/admin/people/permissions`).

## Verify it worked

Log in as a user with the **administer livesearch** permission and open
`/admin/config/services/livesearch-person`. You should see the fields for the
directory URL and API key, and a **Test Connection** tab. Once configured, follow
[Configuration](../configuration/index.md) to map fields on a webform.
