# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- A running **ONLYOFFICE Docs (Document Server)** that your Drupal site can reach
  over the network — ideally over **HTTPS**. This is a separate service you host
  (or subscribe to); the module is only the connector.
- Drupal's **Media** system for the files you want to edit.
- The `firebase/php-jwt` library for verifying the Document Server's tokens is
  pulled in automatically when you install the module with Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/onlyoffice -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/onlyoffice -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en onlyoffice -y
```

## Submodule — PDF forms

`onlyoffice_form` adds the PDF‑form workflow (create, upload, publish, and collect
filled‑out forms). Enable it only if you need forms:

```bash
drush en onlyoffice_form -y
```

## Network and egress

Because Drupal and the Document Server talk to each other over the network,
make sure:

- Drupal can reach the Document Server URL you will configure, and
- the Document Server can reach your site's public callback URL
  (`/onlyoffice-callback/{key}`) to save edits.

If your environment restricts outbound traffic, allow egress to the Document
Server host.

## Verify it worked

Confirm the module is enabled on the **Extend** page, then open its settings form
(`onlyoffice.settings_form`) and complete the [Configuration](../configuration/index.md)
— Document Server URL and JWT secret. After that, open an office file under
**Content → Media**, choose **Edit in ONLYOFFICE**, make a change, and confirm it
saves back to the file (which exercises the secured callback end to end).
