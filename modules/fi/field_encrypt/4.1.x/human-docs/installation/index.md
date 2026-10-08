# Installation

## Requirements

Field Encrypt builds on the Encrypt module and core's Field API. It needs:

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`, and it requires
  `drupal/core: ^11.3`). This 4.1.x branch is Drupal 11 only.
- The **Encrypt** module (`drupal/encrypt`, `^3.0@dev`) — it provides the encryption
  profiles Field Encrypt uses. This is a hard dependency and is installed with it.
- Core's **Field** module (`field`) — on by default in a standard Drupal install.
- In practice, the **Key** module (`drupal/key`) too. Encrypt profiles reference a
  Key entity for the actual key material, and keeping keys out of the codebase is
  the whole point — so you'll almost always want Key as well.

## Install with Composer

From the project root, require Field Encrypt (Composer will pull in Encrypt as a
dependency):

```bash
composer require drupal/field_encrypt -W
```

If Key isn't already present, add it too:

```bash
composer require drupal/key -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_encrypt -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en key encrypt field_encrypt -y
```

(You can omit `key` if it's already enabled; `encrypt` is required and will be
enabled with Field Encrypt if you don't list it.)

## Before you encrypt anything

Enabling the module does **not** start encrypting data. Two things must happen first,
both covered in [Configuration](../configuration/index.md):

1. **Create an encryption profile** (an Encrypt‑module entity that pairs an
   encryption method with a Key). Field Encrypt defines no keys or profiles itself —
   it only *uses* one you provide.
2. **Select that profile** on the Field Encrypt settings page. The **Encrypt field**
   checkbox does not even appear on field forms until a profile is chosen.

> ⚠️ **Back up your key before you encrypt.** Losing the key behind your encryption
> profile means losing the encrypted data permanently. Store the key outside the
> database and codebase (a Key file or environment‑variable provider), back it up
> securely in more than one place, and include it in your disaster‑recovery plan.
> See the caveat on the [overview page](../index.md).
