# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core only — no other contrib module dependencies and no third-party PHP libraries
  are required by the base module.
- A **NeutrinoAPI subscription** (non-free) with a user ID and API key.
- **Recommended:** the **Key** module, to store the API credentials securely.

## Install with Composer

From the project root:

```bash
composer require drupal/neutrino_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/neutrino_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en neutrino_api -y
```

## Recommended: the Key module

Store your NeutrinoAPI credentials with the **Key** module. If it is not already
present:

```bash
ddev composer require drupal/key
ddev drush en key -y
```

## Submodules — enable only what you need

Enable the feature submodules individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Email Validator** | `neutrino_api_email_validator` | Decorates Drupal's email-validator service through NeutrinoAPI's Email Validate API, with an extended interface exposing extra data points. |
| **IP Info** | `neutrino_api_ip_info` | IP address lookups via NeutrinoAPI. |
| **User Agent** | `neutrino_api_ua` | User-agent parsing via NeutrinoAPI. |

For example:

```bash
drush en neutrino_api_email_validator -y
```

Each submodule requires the base NeutrinoAPI module, which is already present once
you have installed it above.

## Verify it worked

After enabling the module and entering your credentials (see
[Configuration](../configuration/index.md)), exercise one of the submodules — for
example, submit a form protected by the email validator — and confirm the lookup
returns a result from NeutrinoAPI.
