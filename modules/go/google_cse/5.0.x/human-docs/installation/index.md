# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Search** module (`search`) enabled — this is the only dependency, and
  Drupal enables it automatically when you turn on Google Programmable Search.
- No third-party Composer libraries, no PHP extensions, and **no Google API key**.

You will also need a **Google account** to register a Programmable Search Engine
(free) — that is done on Google's website, not in Drupal, and is covered in
[Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/google_cse -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/google_cse -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_cse -y
```

This makes the *Google Programmable Search* search plugin and the `google_cse`
block available. There is no configuration form of the module's own — the next
step is to create a search page, described in
[Configuration](../configuration/index.md).

## Grant the search permission

The module adds a **View Google Programmable Search** permission
(`search Google CSE`) that controls who may run searches. Grant it to the roles
that should be able to search (for example *Anonymous user* and *Authenticated
user*) at **People → Permissions** (`/admin/people/permissions`).

## Verify it worked

Go to **Configuration → Search and metadata → Search pages**
(`/admin/config/search/pages`) and click **Add search page**. If *Google
Programmable Search* appears in the list of available search plugins, the module
is installed correctly. Continue with [Configuration](../configuration/index.md)
to finish the setup.
