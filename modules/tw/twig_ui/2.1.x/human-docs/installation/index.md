# Installation

## Requirements

Twig UI Templates needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are **no other module dependencies**. One optional integration improves the
editing experience:

- **CodeMirror Editor** (`drupal/codemirror_editor`) — when installed, the template
  code field renders with the CodeMirror editor (syntax highlighting, line
  numbers).

## Install with Composer

From the project root:

```bash
composer require drupal/twig_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To add the optional code editor as well:

```bash
composer require drupal/twig_ui drupal/codemirror_editor -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/twig_ui -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twig_ui -y
```

## Grant the permissions — carefully

Twig UI ships three **restricted** permissions. Because holding **Administer Twig
templates** effectively lets someone write markup the site renders, grant these
only to trusted, developer‑level roles at **People → Permissions**
(`/admin/people/permissions`):

| Permission | What it allows |
|-----------|----------------|
| **Administer Twig templates** | Full control of templates: the list at `/admin/structure/templates`, and the add/edit/delete/clone forms. This is the powerful one — treat it like theme/Git access. |
| **Administer Twig UI templates settings** | The global settings form (`/admin/config/system/twig_ui`) — which themes are selectable and CodeMirror options. |
| **Load Twig templates from file system** | The helper that loads an existing file‑based template's code into the editor as a starting point. |

## Templates directory

The module writes template files under a protected directory in your public files
(`public://twig_ui`, guarded by an `.htaccess`). Drupal's status report warns you
if that directory is missing or unprotected and offers a link to (re)create it. On
non‑Apache servers, make sure `public://twig_ui` is not web‑accessible.

Once enabled, head to [Configuration](../configuration/index.md) to create your
first template.
