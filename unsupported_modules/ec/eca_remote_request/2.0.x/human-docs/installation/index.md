# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **ECA** module (`eca`) — the base Event‑Condition‑Action engine.

Drupal will enable ECA automatically as a dependency. The module uses Guzzle,
which ships with Drupal core, so there are no extra third‑party library
requirements.

> **Heads up:** this project is marked **Unsupported / Obsolete** on drupal.org
> and has no security‑advisory coverage. Consider that before using it on a
> production site.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_remote_request -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/eca_remote_request -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_remote_request -y
```

This also enables `eca` if it is not already on.

## A note on outbound requests

This module makes **server‑side HTTP requests to URLs you configure in ECA
models**. Because a model author can target any URL and set any request option,
be deliberate about who can edit ECA models, and be aware of the egress the
action performs — it can reach internal services on your network (an SSRF
consideration). Keep TLS verification on (Guzzle's default) unless you have a
specific, trusted reason to change it.

## Verify it worked

Open the ECA model editor (**Configuration → Workflow → ECA**), create or edit a
model, and confirm the **Run Remote Requests** and **Convert JSON to List**
actions and the **Is JSON Data** condition appear among the available plugins. If
they do, the integration is active.
