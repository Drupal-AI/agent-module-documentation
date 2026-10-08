# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Module dependencies pulled in automatically by Composer:
  - **Masquerade** (`masquerade`) — user impersonation.
  - **Simple Sitemap** (`simple_sitemap`).
  - **Pathauto** (`pathauto`).
- The module also configures other standard modules (admin toolbar, anti-spam,
  backup, and more) as part of aligning the site with Diba conventions.

## Install with Composer

Installing with Composer is the recommended route, because it resolves the bundled
dependencies for you. From the project root:

```bash
composer require drupal/diba_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/diba_integration -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en diba_integration -y
```

## Submodules — enable only what you need

Diba Integration ships several optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Diba Integration CoGo** | `diba_integration_cogo` | CoGo-specific integration for the Diba platform. |
| **Diba Integration Extra** | `diba_integration_extra` | Additional optional integration pieces. |
| **Diba Integration SAML** | `diba_integration_saml` | SAML authentication for Diba single sign-on. |
| **Diba Integration VUS** | `diba_integration_vus` | VUS-specific integration for the Diba platform. |

For example, to add SAML authentication:

```bash
drush en diba_integration_saml -y
```

## Verify it worked

After enabling, confirm that the bundled modules (Masquerade, Pathauto, Simple
Sitemap, and any submodules you enabled) are present and configured under their
own admin pages.

> **Security follow-up:** Before going live, restrict **Masquerade** to trusted
> administrators, and if you enabled the SAML submodule, configure it with
> verified identity-provider metadata and certificates, keeping all secrets out
> of version control.
