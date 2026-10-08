# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **multilingual site** — the enhancements are only meaningful with core Language
  and translation configured.
- The **Webform** module — only if you want to use the per‑language email‑handler
  feature. It is not required just to enable Multilingual plus.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/multilingual_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/multilingual_plus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multilingual_plus -y
```

## Verify it worked

If you plan to use the per‑language email routing, edit a **Webform**, go to its
**Settings → Emails / Handlers**, and add the email handler — you should be able to
set different recipients per language. For the original‑language feature, it becomes
available where you configure the relevant content display. There is no settings
form to check; the features appear in the places described above.
