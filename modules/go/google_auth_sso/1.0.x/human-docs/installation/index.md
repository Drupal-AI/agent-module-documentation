# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- The **Social Auth Google** module (`social_auth_google`), which itself pulls in
  **Social Auth** / **Social API** and the League OAuth2 Google client library.
  Google Auth SSO builds directly on it.
- A **Google Workspace** account with **domain-wide delegation** configured and the
  **Google Admin Directory** read scope enabled, so the module can read users'
  directory profiles for role sync.

## Install with Composer

From the project root:

```bash
composer require drupal/google_auth_sso -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Social Auth Google
(and its OAuth2 library) and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_auth_sso -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_auth_sso -y
```

Drupal will enable `social_auth_google` (and its dependencies) at the same time.

## Verify it worked

Go to **Social Auth Google's** settings form at
`/admin/config/social-api/social-auth/google`. If Google Auth SSO is installed
correctly, you will see a new **Restricted IPs** field added to that form. Then
continue with [Configuration](../configuration/index.md) to wire up the OAuth
client, the directory scope, and the Workspace role schema.
