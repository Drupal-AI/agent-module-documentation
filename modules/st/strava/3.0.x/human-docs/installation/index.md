# Installation

## Requirements

- **Drupal 10.3 or newer, including Drupal 11** (`core_version_requirement:
  ^10.3 || ^11`).
- Core's **Serialization** module (`serialization`), which Drupal enables
  automatically as a dependency.
- A **Strava account** with a registered API application, so you have OAuth client
  credentials (client ID and secret) to connect with.

## Install with Composer

From the project root:

```bash
composer require drupal/strava -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Serialization
module and any other shared dependencies alongside Strava.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/strava -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en strava -y
```

## Connect to Strava

1. Register an application on Strava to obtain your OAuth **client ID** and **client
   secret**.
2. Provide those credentials to Drupal. **Keep the client secret out of version
   control** — store it in an environment variable and reference it from your
   configuration rather than pasting it into committed files.
3. As a signed-in Drupal user, link your account via the **Strava login block** or
   the **`/admin/strava`** page.

## Verify it worked

After linking, load `/admin/strava` (or the page where you placed the Strava login
block) and confirm your account shows as connected to Strava. Because Strava no
longer shares email addresses, remember that only existing, signed-in Drupal users
can link — the module will not create a new account from a Strava login.
