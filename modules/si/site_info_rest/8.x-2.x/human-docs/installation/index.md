# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **RESTful Web Services** module (`rest`), which the module depends on; Drupal
  enables it for you.
- Optional but recommended: the contributed **REST UI** module
  (`drupal/restui`), which gives you a UI for turning REST resources on and setting
  their formats and authentication instead of editing configuration by hand.

There are no third-party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/site_info_rest -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site_info_rest -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_info_rest -y
```

## Turn on the REST resource

The site-info resource is a core REST resource, so it must be enabled before it will
respond. The simplest route is the **REST UI** module: install and enable it
(`drush en restui -y`), go to **Configuration → Web services → REST**
(`/admin/config/services/rest`), find the **Site info** resource, and enable it —
choosing the `json` format and the authentication you want. Grant the **`restful get`**
permission to the roles or consumers that should be allowed to read it.

## Verify it worked

Request the endpoint:

```bash
curl '/site/info?_format=json'
```

(using your site's full base URL). A successful response returns JSON containing the
site name, slogan, logo, and favicon.
