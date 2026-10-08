# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.1 or later.** The `proc_open` function is recommended so the module can
  enforce the configured conversion timeout (it falls back to `shell_exec` only
  when `proc_open` is unavailable).
- Core's **File** (`file`) and **Text** (`text`) modules — both ship with Drupal
  and are enabled automatically as dependencies.
- **LibreOffice installed on the same environment where Drupal's PHP runs.** This
  is the key external requirement: Drupal executes LibreOffice from the command
  line to perform the conversion. You should be able to run `libreoffice --version`
  or `soffice --version` from a shell on that machine without errors.

## Install with Composer

From the project root:

```bash
composer require drupal/doc_to_html -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/doc_to_html -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Install LibreOffice

LibreOffice is not a Composer package — it must be present as a system binary on
the environment where Drupal runs.

With **DDEV**, you can install it inside the web container by adding it as an extra
package in `.ddev/config.yaml`:

```yaml
webimage_extra_packages:
  - libreoffice
```

Then run `ddev restart` so DDEV rebuilds the web container with LibreOffice
available. On a traditional server, install LibreOffice through your operating
system's package manager instead.

## Enable the module

```bash
drush en doc_to_html -y
```

## Verify it worked

Once LibreOffice is installed and the module is enabled, go to
[Configuration](../configuration/index.md), point the **LibreOffice settings** at
the binary, and run the **Test Wizard** with a sample DOCX file. If the wizard
shows converted HTML, everything is wired up correctly and you can add the widget
to a field.
