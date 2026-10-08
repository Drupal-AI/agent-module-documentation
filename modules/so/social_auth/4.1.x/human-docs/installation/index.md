# Installation

## Requirements

Social Auth is a framework that sits on top of Social API. It needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The **Social API** module (`drupal/social_api`, `^4.0`), which Composer installs
  automatically as a dependency.
- **At least one provider module** — for example `drupal/social_auth_google`,
  `drupal/social_auth_facebook`, or `drupal/social_auth_github`. Social Auth by
  itself offers no "Sign in with…" buttons; the provider modules supply them.
- **An OAuth application** registered with each external provider, giving you a
  **client ID** and **client secret**. This is an external dependency you set up in
  the provider's developer console — you cannot complete a real login without it.

## Install with Composer

From the project root, install the framework and a provider together:

```bash
composer require drupal/social_auth drupal/social_auth_google -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Social API and
update any shared dependencies as needed. Swap in whichever provider modules you
need.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth … -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en social_auth social_auth_google -y
```

Enabling Social Auth also turns on Social API. Enable each provider module you
installed.

## Grant permissions

Social Auth adds two permissions of its own, plus it relies on one from Social API.
At **People → Permissions** (`/admin/people/permissions`):

- **Administer social api authentication** *(from Social API)* — needed to reach the
  integrations page and the provider settings forms. Give this to administrators.
- **Administer social auth profiles** — full management of the stored provider↔user
  links (view the site‑wide list, delete any profile).
- **Delete own social auth profile** — lets a user remove providers linked to their
  own account. Commonly granted to authenticated users.

## Verify it worked

Go to **Configuration → Social API settings → Social Auth**
(`/admin/config/social-api/social-auth`). You should see the integrations page
listing your installed provider(s), each with a link to its settings form. Continue
to [Configuration](../configuration/index.md) to enter credentials and set your login
policy.
