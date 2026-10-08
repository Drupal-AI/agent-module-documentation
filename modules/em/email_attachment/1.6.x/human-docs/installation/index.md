# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No other module dependencies and no third-party Composer libraries.
- Emails must be sent through the core **MailManager** (`plugin.manager.mail`) — the
  standard Drupal mail path — for the attachment conversion to run.

## Install with Composer

From the project root:

```bash
composer require drupal/email_attachment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_attachment -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_attachment -y
```

That's all the setup there is — no configuration and no permissions. From now on,
any mail sent through the core MailManager with an `attachment` / `attachments`
entry in its `params` is converted to a `multipart/mixed` message with the file(s)
attached (see the [overview](../index.md) for the `params` structure).

## Optional: the demo submodule

The package includes **`email_attachment_demo`**, a worked example that attaches a
file to the core contact form's email so you can see the pattern in action. Enable it
only if you want that demonstration:

```bash
drush en email_attachment_demo -y
```

It requires the base Email Attachment Helper module, which is already present once
you've installed it above. Leave it disabled on production sites unless you
specifically want the demo behavior.
