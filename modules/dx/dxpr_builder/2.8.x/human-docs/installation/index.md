# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core modules **Field**, **Field UI**, **Views**, **Image**, and **Block** — all
  are dependencies and are enabled automatically as needed.
- A valid **DXPR Builder licence key** (a JWT/API key) from DXPR for the live
  editor to work. See "Store your licence key" below.
- Recommended: the **Key** module (`drupal/key`) so the licence key can be stored
  as a Key entity rather than in plain configuration.

There are no third-party PHP library requirements declared, but note this is a
**commercial product** distributed under DXPR's terms
(<https://dxpr.com/legal/terms>), not GPL.

## Install with Composer

DXPR Builder is published under the `dxpr/dxpr_builder` Composer namespace (not
`drupal/…`). From the project root:

```bash
composer require dxpr/dxpr_builder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Depending on your licence, you may need to configure DXPR's
Composer package repository and authentication first — follow the instructions
DXPR provides with your subscription.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require dxpr/dxpr_builder -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dxpr_builder -y
```

### Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **DXPR Builder Page** | `dxpr_builder_page` | A ready-made drag-and-drop landing-page content type. |
| **DXPR Builder Block** | `dxpr_builder_block` | A drag-and-drop custom block type for reusable page components. |
| **DXPR Builder Media** | `dxpr_builder_media` | A media-library / entity-browser image picker inside the builder. |

For example:

```bash
drush en dxpr_builder_page -y
```

## Store your licence key securely

The live editor needs your DXPR licence key (a JWT). **Never hard-code or commit a
key.** The recommended approach is an environment variable feeding a Key entity:

1. Save the value into your environment. With DDEV:

   ```bash
   ddev dotenv set .ddev/.env --dxpr-jwt=<your-key>
   ddev restart
   ```

   (Keep `.ddev/.env` out of version control.) The flag `--dxpr-jwt` becomes the
   variable `DXPR_JWT`.

2. Make sure the **Key** module is enabled:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ```

3. Create a Key that reads the environment variable (confirm the variable is
   present first — `ddev exec 'test -n "$DXPR_JWT"'`, exit status 0 means it's set):

   ```bash
   ddev drush key:save dxpr_jwt --label='DXPR Builder JWT' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"DXPR_JWT","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

4. In DXPR Builder's settings, choose to store the key in a **Key entity** and pick
   the key you just created (see [Configuration](../configuration/index.md)).

Alternatively you can paste the key straight into the settings form, which stores
it in plain configuration — simpler, but less secure, and it will be exported with
your config. Prefer the Key-entity approach for real sites.

After the licence key is in place, continue to
[Configuration](../configuration/index.md) to set up profiles, templates, and
turn the builder on for a field.
