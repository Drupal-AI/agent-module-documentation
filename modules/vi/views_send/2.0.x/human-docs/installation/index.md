# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Views** module (`views`) — the only hard dependency, and it is on by
  default in a standard Drupal install.

There are no third‑party Composer or PHP library requirements.

### Optional integrations

Views Send works on its own, but three optional modules extend it:

- **Mime Mail** (`drupal/mimemail`) — send HTML messages and file attachments.
- **Token** (`drupal/token`) — insert site / global context tokens into the
  subject and body (per‑row tokens already work without it).
- **Rules** (`drupal/rules`) — react when messages are sent or spooled.

## Install with Composer

From the project root:

```bash
composer require drupal/views_send -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Add any optional integration the same way, for example
`composer require drupal/mimemail`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_send -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_send -y
```

There are no submodules.

## Grant permissions

Views Send adds three permissions — assign them under **People → Permissions**:

- **Administer views_send** — change the global settings form.
- **Mass mailing with views_send** — the "can actually send bulk email"
  permission. This is high‑impact; grant it only to trusted roles.
- **Attachments with views_send** — allow attaching files (needs Mime Mail to
  take effect).

Next, build a sending View — see [Configuration](../configuration/index.md).
