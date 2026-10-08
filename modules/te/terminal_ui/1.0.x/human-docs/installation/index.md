# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`). The project notes
  Drupal core 11.x as its target.
- The **Token** module (`token`), a required dependency used to substitute tokens
  like `[site:name]` into your configured text. Composer pulls it in automatically.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/terminal_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — this is what brings in the Token module. The Composer
package name (`drupal/terminal_ui`) matches the module's machine name
(`terminal_ui`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/terminal_ui -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en terminal_ui -y
```

The module installs with no default content, so nothing changes yet — head to
[Configuration](../configuration/index.md) to build your terminal view. You will
need the *Administer Terminal UI* permission, which the administrator role has by
default.

## Verify it worked

Once you have configured and saved a terminal view, open a terminal and run:

```bash
curl https://yourdomain.com/
```

You should see your styled, terminal‑formatted homepage. Visiting the same URL in
a browser shows your site as normal — the module only intercepts requests whose
User‑Agent contains `curl`.
