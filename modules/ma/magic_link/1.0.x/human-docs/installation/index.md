# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11`; the module targets
  Drupal 11.2+).
- The **HTMX** module (`drupal/htmx`, `^1.5`) — required for the in‑form request
  experience.
- A working **outbound mail** setup, since login links are delivered by email.
  Prefer a TLS‑secured mail transport.

## Install with Composer

From the project root:

```bash
composer require drupal/magic_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the HTMX module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/magic_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en magic_link -y
```

## Permissions

Magic Link provides its own permissions. For the feature to be useful, the
**"Request magic link"** route needs to be reachable by **anonymous** users (this
is the default), since people request a link precisely because they are not logged
in. Review permissions at **People → Permissions**
(`/admin/people/permissions`). Normal Drupal mail permissions and any site‑level
rate limits also apply.

## Drush command (development)

For development you can generate persistent magic links from the command line:

```bash
# Generate a link for user 1 (1 hour expiry)
drush mli

# Generate a link for user 123 (24 hour expiry)
drush mli --expire=24h --uid=123

# Generate a link with a custom destination
drush mli --expire=3d --destination=/admin
```

These are convenience commands for development — treat any generated link as a
live credential.

## Verify it worked

Visit the core login page at `/user/login`. You should see a **"Send me a magic
link"** option added to the form. Entering an email and confirming that a
one‑time login link arrives is the real confirmation the module is working. Then
tune the expiry and email template on the
[Configuration](../configuration/index.md) page.
