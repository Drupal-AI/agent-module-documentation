# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block**, **REST**, and **Serialization** modules — Drupal enables
  these automatically as dependencies when you turn on Exchange Rate.
- A **free or paid API key** from [ExchangeRate‑API](https://www.exchangerate-api.com/).
  Sign up on their site to obtain one before you configure the module.
- Outbound HTTPS access from your web server to ExchangeRate‑API so the module can
  fetch rates. If your environment restricts egress, allow that host.

## Install with Composer

From the project root:

```bash
composer require drupal/exchangerate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/exchangerate -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en exchangerate -y
```

## Keep your API key out of version control

Treat the ExchangeRate‑API key as a secret. The module reads the key from its own
configuration (`exchangerate.settings`), which you set on the settings form — it
does not read the key from an environment variable or any external secret store.
Because the value lives in configuration, it will appear in an exported
configuration (`drush cex`) unless you take steps to keep it out:

- Enter the key on the settings form per environment and **exclude it from export**
  — for example with the [Config Ignore](https://www.drupal.org/project/config_ignore)
  or [Config Split](https://www.drupal.org/project/config_split) module so
  `exchangerate.settings:api_key` is not written to your sync directory.
- Or set the value per environment straight from the CLI instead of committing it:

  ```bash
  drush cset exchangerate.settings api_key '<your-key>' -y
  drush cr
  ```

You still enter or set the key on each environment; see
[Configuration](../configuration/index.md) for the settings form.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep exchangerate
```

Then head to **Configuration → System → Exchange Rate Settings** to enter your API
key, and place a block from **Structure → Block layout** to see live rates render.
Full details are in [Configuration](../configuration/index.md).
