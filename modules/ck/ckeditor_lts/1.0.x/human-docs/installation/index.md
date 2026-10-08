# Installation

> **This module installs a little differently from most contrib modules.** It
> replaces the CKEditor module (machine name `ckeditor`) that used to live in
> Drupal core, swapping in the LTS build of CKEditor 4. If you already run
> CKEditor 4, read this whole page before downloading, and read the project's own
> installation guide for edge cases (especially on Drupal 7).

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **Editor** module (`editor`), which Drupal enables as a dependency.
- A **CKSource Extended Support Model (ESM) license key**. CKEditor 4 reached end
  of life in June 2023; the LTS build (4.23.0‑LTS and later) is published under
  commercial terms and requires this key to initialize the editor. If you do not
  already hold an ESM license, contact CKSource sales before adopting the module.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_lts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_lts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_lts -y
```

Because this module provides the `ckeditor` editor, enabling it makes CKEditor 4
available (or, if you were already using the open‑source CKEditor 4, overrides it
with the LTS build).

## Enter your license key

The LTS build will not initialize the editor without a valid ESM license key.
Enter the key your organization received from CKSource as part of setting up the
editor. Keep the key out of version control; if you manage it as a secret, store
it in an environment variable and reference it rather than hard‑coding it.

## A note on security

CKEditor 4 no longer receives free security patches. Only the ESM covers ongoing
fixes. Regardless, keep Drupal's server‑side **text‑format filtering** in place as
your primary defense against malicious markup, and plan your migration to
CKEditor 5 — this module is a bridge to buy time, not a permanent home.

## Verify it worked

Open a text format that uses CKEditor 4 at **Configuration → Content authoring →
Text formats and editors**, edit a content field that uses it, and confirm the
CKEditor 4 toolbar loads. If the editor fails to initialize, the most common
cause is a missing or invalid ESM license key.
