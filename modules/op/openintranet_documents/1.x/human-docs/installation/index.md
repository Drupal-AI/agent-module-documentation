# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- Core's **File**, **User**, and **Views** modules (all part of Drupal core;
  enabled automatically as needed).
- The **Alpine.js** module (`alpine_js`) — this provides the JavaScript library
  the document browser's interactive UI relies on. Composer pulls it in as a
  dependency.

This module was built for the Open Intranet distribution and has not been fully
tested on standalone Drupal core installs, so treat a non-Open-Intranet
deployment as unsupported territory and test carefully.

## Install with Composer

From the project root:

```bash
composer require drupal/openintranet_documents -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Alpine.js module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openintranet_documents -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openintranet_documents -y
```

## Set up permissions

This module ships its own permissions for viewing, adding, and managing folders
and documents. Right after enabling it, visit **People → Permissions**
(`/admin/people/permissions`) and grant those permissions deliberately to the
roles that should have them. Because the documents can be confidential, be
conservative: give management rights only to trusted roles, and think about which
roles (if any) may view.

## Verify it worked

Log in as a user with the appropriate permissions and visit **`/documents`**. You
should see the document browser with toolbar icons for creating a folder and
uploading a document. Create a folder, upload a test file into it, and confirm you
can navigate into the folder and download the file. No additional configuration is
required — the module works out of the box.
