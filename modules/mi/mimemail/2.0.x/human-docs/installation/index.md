# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **Mail System** module (`drupal/mailsystem` `^4`) — a hard dependency. Mime
  Mail is a mail *component* that Mail System wires into Drupal's mail pipeline;
  it can't act as your mailer without it. Composer pulls it in for you.
- No third‑party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/mimemail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Mail System and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mimemail -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mimemail -y
```

Drupal enables **Mail System** automatically as a dependency. Enabling the module
is not enough on its own — you still need to select Mime Mail as the mailer in
Mail System and set your options. See [Configuration](../configuration/index.md).

## Submodule — the example

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Mime Mail Example** | `mimemail_example` | A demonstration module showing how to send HTML email through Mime Mail from custom code. Useful for developers learning the integration pattern; not needed in production. |

```bash
drush en mimemail_example -y
```

It requires the base Mime Mail module, which is already present once you've
installed it above.
