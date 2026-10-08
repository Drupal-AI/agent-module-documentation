# Installation

## Requirements

File encrypt needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **File** module (`file`).
- The contributed **Encrypt** module (`encrypt`) for key management — Composer
  pulls it in. Encrypt in turn works with the **Key** module to store the
  encryption key outside the database.
- An encryption method to generate a key with — for example the **Real AES**
  module (`real_aes`).

> **This is an alpha release** (`2.0.0-alpha1`) of a module whose failure mode is
> unreadable files. Test it end-to-end on non-critical data before you rely on it.

## Install with Composer

From the project root:

```bash
composer require drupal/file_encrypt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Encrypt (and
Key) dependencies and update any shared packages as needed. If you intend to use
AES encryption, add the encryption method module too, for example:

```bash
composer require drupal/real_aes -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_encrypt -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_encrypt -y
```

Drupal enables the Encrypt and File dependencies at the same time. Also enable
your chosen encryption method module (for example `drush en real_aes -y`) and the
Key module if it is not already on.

## Verify it worked

Once you have completed the [Configuration](../configuration/index.md) steps —
set the encrypted-file path in `settings.php`, created a key and an encryption
profile, and selected "Encrypted files" as a field's upload destination — upload a
file to that field and confirm it downloads normally for an authorised user while
being stored encrypted on disk.
