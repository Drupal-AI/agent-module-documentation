# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- A multilingual site — core's **Language** and **Content Translation** modules
  configured, with more than one enabled language. Partial Multilingual only does
  useful work when some content is translated and some is not.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/partial_multi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/partial_multi -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

> **Release status:** at the time of writing there is no stable release covered by
> the security advisory policy. Test carefully before relying on it in production.

## Enable the module

```bash
drush en partial_multi -y
```

There is no configuration step.

## Verify it worked

On a site with at least two languages, find a node that is **not** translated into
one of them. Request it in that untranslated language (for example
`/es/node/<id>`). You should be permanently (301) redirected to the content's
source‑language URL (for example, its English alias). A node that *is* translated
into the requested language should load normally with no redirect.
