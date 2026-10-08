# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Key** module (`drupal/key`, `^1.13`) — Loqate stores your API key as a
  Key entity rather than in plain config. It is a Composer dependency and is
  installed automatically.
- A **Loqate account and API key**, ideally restricted to your site's domain(s)
  because the key is used client‑side.
- The optional **PCA Address** submodule additionally needs core's **Address**
  module; the optional **PCA Webform** submodule needs the **Webform** module.

## Install with Composer

From the project root:

```bash
composer require drupal/loqate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module
and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/loqate -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en loqate -y
```

Drupal enables the Key module at the same time as a dependency.

## Submodules — enable only what you need

Loqate ships two optional submodules; enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **PCA Address** | `pca_address` | A field widget and element that adds Loqate autocomplete to an Address‑module `address` field. Requires the core **Address** module. |
| **PCA Webform** | `pca_webform` | A composite Loqate address element for Webform. **Deprecated** in this version — prefer the PCA Address approach where you can. Requires the **Webform** module. |

For example, to add the Address‑field widget:

```bash
drush en pca_address -y
```

## After enabling — store your key

Put your Loqate key in an environment variable and create a Key entity that reads
it (or use the Key module's config provider), then select that Key on the
settings form. For example, using an environment variable named
`LOQATE_API_KEY`:

```bash
ddev drush key:save loqate_api_key --label='Loqate API key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"LOQATE_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Then head to [Configuration](../configuration/index.md) to select this key and
map the address fields. Never hard‑code or commit the key.
