# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The PHP **`xsl` extension** must be installed and enabled. Composer will refuse
  to install the module without it.
- Composer packages `twig/inky-extra`, `twig/cssinliner-extra`, and
  `twig/extra-bundle` — these come in as dependencies when you require the module.

### Enabling the PHP `xsl` extension

On a Debian/Ubuntu-based container the extension is installed like this:

```bash
apt-get update -y
apt-get install -y libxslt1-dev
docker-php-ext-install xsl
```

> **Using DDEV?** DDEV's web image already includes common PHP extensions; if
> `xsl` is missing you can add it via a `webimage_extra_packages`/
> `post-start` customization or a `.ddev` Dockerfile addition, then
> `ddev restart`. Confirm it is active with `ddev exec 'php -m | grep xsl'`.

## Install with Composer

From the project root:

```bash
composer require drupal/inky_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including the Twig extension packages) as needed. If Composer stops
with a message about a missing `ext-xsl`, enable the PHP extension as above and
try again.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inky_integration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inky_integration -y
```

According to the maintainers, once installed it should "just work" — the Twig
extensions and templates are registered automatically, with no settings to
configure.

## Verify it worked

There is no settings page to check. Instead, use the Inky tags and the CSS-inliner
filter in an email body Twig template (see "How to use it" on the
[overview page](../index.md)) and render an email — the semantic Inky markup
should come out as email-safe tables with CSS inlined. If rendering errors mention
XSL, re-check that the PHP `xsl` extension is enabled.

## Maintenance note

Periodically refresh the bundled stylesheet
(`inky_integration/css/foundation-for-emails.css`) from the upstream
Foundation for Emails distribution to pick up fixes.
