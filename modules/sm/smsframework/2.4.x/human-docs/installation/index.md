# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`). This 2.4.x line targets Drupal
  10/11; the maintainers consider v2 unsupported and suggest v3/v4 for new sites.
- Core's **System** and **Telephone** modules (part of a standard install).
- The **Dynamic Entity Reference** module (`dynamic_entity_reference`), pulled in
  by Composer as a dependency.
- A **gateway account** with whichever provider you'll send through (Twilio and
  many others are supported), for the credentials you enter on the gateway.

Non‑Composer installations are explicitly not supported.

## Install with Composer

From the project root:

```bash
composer require drupal/smsframework -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Dynamic Entity
Reference and any shared dependencies. (The project's own docs sometimes show
`composer require drupal/sms`; either way the module's machine name is `sms`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smsframework -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `sms`:

```bash
drush en sms -y
```

## Submodules — enable only what you need

SMS Framework ships several optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **SMS Blast** | `sms_blast` | Bulk sending — send one message out to many recipients. |
| **SMS User** | `sms_user` | Per‑user SMS features, including binding and verifying a user's phone number. |
| **SMS Send to phone** | `sms_sendtophone` | Send a piece of content (or part of it) to a phone. |
| **SMS Devel** | `sms_devel` | Developer tooling for testing SMS during development. |

For example, to add bulk sending:

```bash
drush en sms_blast -y
```

## Next step

Add a gateway, set it as the default, and lock down permissions — see
[Configuration](../configuration/index.md).
