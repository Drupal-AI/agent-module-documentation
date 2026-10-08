# Installation

> **Platform-only.** ACSF Connector is meant for sites hosted on **Acquia Cloud
> Site Factory**. On any other host it installs but does nothing. Only proceed if
> your site is part of an ACSF platform.

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **System** module (>= 8.5.0), always present.
- The PHP **JSON extension** (`ext-json`), standard in Drupal-ready PHP builds.
- The **`symfony/process`** library (`^4|^5|^6|^7.1`) — pulled in by Composer.
- The required submodules **`acsf_theme`** and **`acsf_variables`** (bundled;
  enabled with the main module).

## Install with Composer

From the project root:

```bash
composer require drupal/acsf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including `symfony/process`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acsf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix. Note that on a local/DDEV
> site the connector is inert; it only becomes active on an Acquia ACSF host.

## Enable the module

```bash
drush en acsf -y
```

This also brings in the required submodules `acsf_theme` (VCS/git-based theme
handling) and `acsf_variables` (a single scrubbable store for sensitive
variables). Do not uninstall those on a live ACSF site.

## Patch the codebase with `acsf-init`

This is the essential step that makes the connector work. **`acsf-init` is not an
enableable module** — it is a self-contained Drush script you run against the
codebase (it works even with no database or a broken site). Run it once, and
again after **every** ACSF module update:

```bash
# Patch sites.php, Cloud Hooks, and .htaccess for ACSF (-y overwrites without prompting):
drush --include=<PATH-TO-MODULE>/acsf_init acsf-init -y

# Verify the patched files are present and current — ACSF blocks deploys if this fails:
drush --include=<PATH-TO-MODULE>/acsf_init acsf-init-verify
```

Replace `<PATH-TO-MODULE>` with the path to the installed acsf module (for
example `web/modules/contrib/acsf`). Under Acquia BLT this is usually wrapped by
`blt recipes:acsf:init:all`. To connect a non-production site to a Factory for
testing, use `drush acsf-connect-factory`.

## Submodules

The suite ships several submodules from one shared codebase:

| Submodule | Machine name | Status | What it adds |
|-----------|--------------|--------|--------------|
| **ACSF Theme** | `acsf_theme` | Required | VCS/git-based theme handling on the platform. |
| **ACSF Variables** | `acsf_variables` | Required | A single scrubbable store for sensitive variables. |
| **ACSF Duplication** | `acsf_duplication` | Suite member | The site-duplication database scrub handlers. |
| **ACSF SSO** | `acsf_sso` | Optional | Management Console single sign-on via SAML. Has its own dependency: `composer require drupal/acsf_sso`. |
| **ACSF Scheduled Jobs** | `acsf_sj` | Optional | Integration with Site Factory Scheduled Jobs. |
| **ACSF Meta** | `acsf_meta` | Optional | Adds platform meta tags. |

Enable the optional ones as your platform setup requires, for example:

```bash
composer require drupal/acsf_sso -W
drush en acsf_sso -y
```

## After installation

There is no admin form to configure. The platform drives ongoing operations —
site sync, staging scrubs, and factory data updates — through the module's Drush
commands and event framework. See the sibling
[agent Drush reference](../../agent/drush/acsf.md) for the full command list.
