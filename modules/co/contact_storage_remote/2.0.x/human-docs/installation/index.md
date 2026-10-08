# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Contact** module (`contact`) — the only dependency, enabled
  automatically as needed.
- A **transport plugin** to actually deliver submissions. The base module ships
  none of its own; install a companion module such as
  `contact_storage_remote_webhook` (an example that POSTs message fields to a URL)
  or write your own.

There are no additional PHP libraries required by the base module. This project is
**not covered by Drupal's security advisory policy** — and because the outbound
connection is handled by a transport plugin, review that plugin's TLS and
credential handling before trusting it with real data.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_storage_remote -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contact_storage_remote -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_storage_remote -y
```

If the transport you need lives in a submodule or companion module (for example
`contact_storage_remote_webhook`), enable that too:

```bash
drush en contact_storage_remote_webhook -y
```

## Verify it worked

Edit any contact form under **Structure → Contact forms → Manage**. A **Contact
Storage Remote** tab should now appear on the form. Users need the **"manage
contact_storage_remote contact_form settings"** permission to see and use it — see
[Configuration](../configuration/index.md).
