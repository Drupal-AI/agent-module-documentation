# Installation

## Requirements

Mailer Plus builds on the Symfony Mailer component and a few libraries:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Filter** module (`filter`) and the bundled **Mailer Transport** submodule
  (`mailer_transport`) — both are dependencies and are enabled with the module.
- Three **Composer libraries**, installed automatically with the module:
  `symfony/mailer` (the mail engine), `html2text/html2text` (generates the plain‑text
  alternative), and `tijsverkoyen/css-to-inline-styles` (inlines your CSS so styled
  email renders in mail clients).

There are no other third‑party requirements. To actually deliver mail off the server
you'll typically configure an SMTP transport (or a DSN) in the Mailer Transport
submodule — see [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/symfony_mailer -W
```

The `-W` (`--with-all-dependencies`) flag is important — it lets Composer pull in the
Symfony Mailer and CSS/HTML libraries and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/symfony_mailer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en symfony_mailer -y
```

This enables the base module and its required **Mailer Transport** submodule. Once
enabled, visit **Configuration → System → Mailer Plus** to verify that mail works.

## Submodules — enable what you need

Mailer Plus splits its configuration across three submodules:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Mailer Transport** | `mailer_transport` | *How* mail is sent — SMTP, Sendmail, DSN string, native, or null transports, managed at `/admin/config/system/mailer/transport`. This is a **required** dependency and is enabled automatically. |
| **Mailer Policy** | `mailer_policy` | *What emails look like and who they go to* — configurable policy rules (EmailAdjuster plugins: From/To, subject, theme, inline CSS, convert to plain text, skip sending, choose transport, and more), keyed by email type, at `/admin/config/system/mailer/policy`. |
| **Mailer Override** | `mailer_override` | Transparently redirects legacy core `hook_mail` emails into the Mailer Plus pipeline, configured at `/admin/config/system/mailer/override`. |

Enable the optional ones as needed, for example:

```bash
drush en mailer_policy mailer_override -y
```

Most sites will want **Mailer Policy** at minimum, so they can set the site‑wide From
address and theme their emails.
