# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **IMCE** module (`imce`) — this module extends it, so IMCE must be installed
  and you should have at least one IMCE profile configured.
- A **secure context (HTTPS)** for the clipboard copy to work reliably in the
  browser — see the note in the [overview](../index.md).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/imce_copylink -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including IMCE if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imce_copylink -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imce_copylink -y
```

This also enables IMCE if it is not already on.

## Verify it worked

Go to **Configuration → Media → IMCE** (`/admin/config/media/imce`), edit a
profile, and confirm a **Copy link** permission checkbox now appears against your
directories. Enable it, save, then open IMCE — the **Copy link** button should
appear in the toolbar. See "How to set it up" in the [overview](../index.md).

> **If the copy seems to do nothing**, check that you are on an HTTPS site.
> Browsers block clipboard access on plain HTTP, so the button can fail silently
> on a non-TLS local environment even though the module is working.
