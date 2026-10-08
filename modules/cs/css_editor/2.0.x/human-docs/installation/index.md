# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other module dependencies and no PHP library requirements.
- **Outbound network access** for the in-browser code editor: CodeMirror is loaded
  from a public CDN. If your site can't reach the internet, the editor falls back
  to a plain textarea (or you can tick *Use plain text editor* explicitly).

## Install with Composer

From the project root:

```bash
composer require drupal/css_editor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/css_editor -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en css_editor -y
```

## Permissions

CSS Editor adds no permission of its own. The Custom CSS box appears on the theme
settings form, which is guarded by core's **Administer themes** permission — so any
user who can already administer themes can edit custom CSS. Grant that permission
only to trusted administrators.

## Next steps

Head to **Appearance → Settings** for a theme and open the **Custom CSS** section —
see [Configuration](../configuration/index.md) for what each field does.
