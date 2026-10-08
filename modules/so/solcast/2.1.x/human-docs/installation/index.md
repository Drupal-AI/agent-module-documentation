# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer**.
- The **HTTP Client Manager** module (`http_client_manager`) — this is the one
  required dependency and it provides the client factory Solcast plugs into.
  Composer pulls it in automatically with the command below.
- A **Solcast account** for a real integration — it gives you the API token and
  the `resourceId` (the UUID of your roof) that the API calls need.
- Optionally, the **Key** module if you plan to enable the API Key submodule, and
  the **ECA** module if you plan to enable the ECA submodule.

## Install with Composer

From the project root:

```bash
composer require drupal/solcast -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in HTTP Client
Manager and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/solcast -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en solcast -y
```

Once enabled, an additional entry for the Solcast API appears on the HTTP Client
Manager overview at `/admin/config/services/http-client-manager`.

## Submodules — enable only what you need

Solcast ships two optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **API Key** | `solcast_key` | Adds authentication. It ships a Key config item (`solcast_api_key`) and an event subscriber that attaches the `Authorization` header to every request from that Key, so you can call the commands without wiring up separate authenticated requests. Requires the **Key** module. |
| **ECA** | `solcast_eca` | Provides an ECA action for calculating the start of the forecast interval, so no-code ECA models can drive Solcast calls. Requires the **ECA** module. |

For example, to add API-key authentication:

```bash
drush en solcast_key -y
```

Then store your Solcast token in the `solcast_api_key` Key entity rather than in
code or settings — for example via an environment variable and the Key module's
env provider.

## Verify it worked

Visit `/admin/config/services/http-client-manager` as an administrator; you
should see the Solcast API listed among the configured HTTP clients.
