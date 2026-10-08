# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- The **Contact Storage** module (`contact_storage`) — this is the dependency the
  module extends, and Composer installs it alongside this module. (Contact Storage
  in turn builds on core's Contact module.)

There are no third-party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_storage_dm -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the Contact Storage dependency
and updates any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/contact_storage_dm -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_storage_dm -y
```

Drupal enables Contact Storage too if it isn't already on.

## Verify it worked

Edit a contact form at **Structure → Contact forms** — you should see a new
**Disable Mail Send** option on the form. Tick it, save, then submit a test
message: the submission should be stored by Contact Storage while no notification
email is sent.
