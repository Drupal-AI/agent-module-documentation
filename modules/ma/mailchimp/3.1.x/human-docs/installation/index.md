# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Composer library **`thinkshout/mailchimp-api-php`** `^3.1.2` (installed
  automatically with the command below) — the PHP client for Mailchimp's API.
- Core's **Path alias** module (`path_alias`), enabled automatically as a
  dependency.
- A **Mailchimp account** with an API key or OAuth access.
- *Optional:* the **Webform** module — the base module suggests it so that
  Mailchimp events can fire on webform submissions.

## Install with Composer

From the project root:

```bash
composer require drupal/mailchimp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`thinkshout/mailchimp-api-php` library and update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mailchimp -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mailchimp -y
```

Once enabled, connect your account on the settings form — see
[Configuration](../configuration/index.md).

## Submodules — enable only what you need

The base module is a connector; the user‑facing features are submodules. Enable
them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Mailchimp Audiences** | `mailchimp_lists` | A subscription field type so any entity (usually users) can be tied to Mailchimp audiences and merge fields. |
| **Mailchimp Campaign** | `mailchimp_campaign` | Author, send, test, and pull stats for campaigns from within Drupal. |
| **Mailchimp Signup** | `mailchimp_signup` | Configurable newsletter signup blocks and standalone pages. |
| **Mailchimp Events** | `mailchimp_events` | Behavioral‑targeting events sent to Mailchimp. |
| **Mailchimp ECA** | `mailchimp_eca` | Exposes Mailchimp events and actions to the ECA automation module. |

For example, to add a newsletter signup block:

```bash
drush en mailchimp_signup -y
```

Each submodule requires the base Mailchimp module, which is already present once
you have installed it above.
