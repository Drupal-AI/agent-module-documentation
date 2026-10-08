# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Symfony Mailer** (`symfony/mailer`), which Composer resolves for you.
- Some optional extension submodules need extra libraries: **Postoffice Html2Text** needs
  `soundasleep/html2text`, and **Postoffice Inline Styles** needs
  `tijsverkoyen/css-to-inline-styles`. Install those only if you enable the corresponding
  submodule.

## Install with Composer

From the project root:

```bash
composer require drupal/postoffice -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/postoffice -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en postoffice -y
```

## Extension submodules — enable only what you need

Postoffice ships several optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Compat** | `postoffice_compat` | Mail plugins that route core's **user** and **contact** emails through Postoffice, e.g. `drush config:set system.mail interface.user postoffice_user_mail`. |
| **Compat Theme** | `postoffice_compat_theme` | Forces mail sent via the core mail manager to render using the Postoffice mail theme. |
| **Skel** | `postoffice_skel` | Wraps HTML mails in a complete HTML document. |
| **Html2Text** | `postoffice_html2text` | Auto‑generates a plain‑text part from the HTML (needs `soundasleep/html2text`). |
| **Inline Styles** | `postoffice_inline_styles` | Inlines CSS from referenced libraries into the markup (needs `tijsverkoyen/css-to-inline-styles`). |
| **Twig** | `postoffice_twig` | Adds the `postoffice_subject` and `postoffice_text_body` Twig helpers. |
| **Image** | `postoffice_image` | Adds the `postoffice_image_embed` Twig helper (optionally applying an image style). |
| **File** | `postoffice_file` | Adds `postoffice_file_attach_entity` / `postoffice_file_attach_uri` Twig helpers for attachments. |

For example:

```bash
drush en postoffice_compat -y
```

## Verify it worked

1. Visit **`/admin/config/system/postoffice`** — you should see the Postoffice settings form.
2. Set the transport DSN and mail theme (see [Configuration](../configuration/index.md)) and
   send a test message through the `postoffice.mailer` service, or enable **Compat** and route
   a core email (such as a password reset) through Postoffice.
