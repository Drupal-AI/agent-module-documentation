# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No additional PHP extensions and no contributed modules are needed.
- **Mail system compatibility:** this module works with Drupal core's default
  **MailManager**. It is **not compatible with Symfony Mailer, Mailer Plus, or
  DSM+** — if you use one of those, this helper will not add attachments.

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

That's all — there is no configuration step. Once enabled, any mail sent through
the core MailManager whose `params` include an `attachment`/`attachments` entry
will be converted into a multipart message with the file attached.

## Submodule — Email Attachment Demo

The project ships one optional submodule:

- **Email Attachment Demo** (`email_attachment_demo`) — a small example that shows
  how to populate the mail parameters to attach a file. Enable it only if you want
  to study or test the technique; it is not needed in production.

```bash
drush en email_attachment_demo -y
```

## Verify it worked

Because the module has no UI, the way to confirm it works is to send a test mail
with an attachment parameter (for example from the demo submodule, or from your
own code) and inspect the received message — it should arrive as a
`multipart/mixed` email with your file attached. On a local environment, a mail
catcher such as Mailpit (bundled with DDEV) is the easiest way to view the raw
message and confirm the attachment is present.
