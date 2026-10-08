# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No hard module dependencies. Integration with the **Security Kit (SecKit)**
  module is optional but recommended if you already use SecKit to manage your CSP —
  install SecKit separately if you want the "merge with SecKit" mode.

There are no third-party PHP or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/seckit_csp_nonce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/seckit_csp_nonce -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seckit_csp_nonce -y
```

## Verify it worked

After enabling, open the module's settings and confirm you can choose an
operation mode — see [Configuration](../configuration/index.md). Once configured,
load any page and view source (or the browser dev-tools network panel): inline
`<script>` tags should carry a `nonce="…"` attribute, and the response's CSP
header should list the same nonce under `script-src`. If your browser console
shows "Refused to execute inline script" errors, some inline scripts are not
receiving the nonce — revisit the configuration and make sure the relevant script
sources are covered.

> **Note on release coverage:** this module is not covered by Drupal's security
> advisory policy. It is itself a security-hardening tool, but that coverage note
> is worth knowing when deciding whether to rely on it.
