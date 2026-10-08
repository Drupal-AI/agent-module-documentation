# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Basic Auth** (`basic_auth`) and **File** (`file`) modules — both part of Drupal
  core. Drupal enables Basic Auth as a dependency when you turn on POST File.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/postfile -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/postfile -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en postfile -y
```

Core's Basic Auth module is enabled automatically as a dependency.

## Verify it worked

1. Create an API user and grant it the **POST file** permission on **People → Permissions**.
2. Configure the target directory and allowed extensions (see the
   [manual setup guide](../index.md)).
3. From a trusted client, send an authenticated `POST` to
   **`https://your-site/postfile/upload`** over HTTPS with a `file` form field. A file whose
   extension is on the allowlist should be stored; an anonymous or disallowed request should be
   rejected.
