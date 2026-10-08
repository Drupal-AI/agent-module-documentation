# Installation

## This module can no longer be installed

PatchInfo has reached the **obsolete** lifecycle state. Its `info.yml` declares:

```yaml
lifecycle: obsolete
lifecycle_link: 'https://www.drupal.org/project/patchinfo/issues/3566867'
```

Drupal enforces that flag. If you try to enable the module you will get an error
rather than a working feature:

```bash
drush en patchinfo -y
# Unable to install modules: module 'patchinfo' is obsolete.
```

There is no version of the 8.x-2.x branch you can turn on. Do not add it to a new
site, and if you are auditing an inherited site that still lists it, plan to
remove it.

## Requirements (historical)

For the record, when it did run PatchInfo needed:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Update Manager** module (`update`) — the only dependency.

It shipped three optional patch-source submodules: `patchinfo_source_composer`
(read patches from Composer's patch list), `patchinfo_source_info` (read them
from `info.yml` annotations), and `patchinfo_drupalorg` (resolve drupal.org issue
references). None of these can be enabled either, since they all require the
obsolete base module.

## The replacement

Install and use the Composer patches plugin instead — this is the standard,
supported way to apply and track patches on a Drupal site:

```bash
composer require cweagans/composer-patches -W
```

> **Using DDEV?** Prefix Composer with `ddev` when you run from your host
> machine — `ddev composer require cweagans/composer-patches -W`. Inside the
> container (`ddev ssh`) run it without the prefix.

Then declare each patch in `composer.json`, with an issue URL and a short note so
the record survives future updates. Review that list every time you update core
or contrib — that habit replaces everything PatchInfo used to show you on the
update report.

## Verify it worked

There is nothing to verify for PatchInfo itself — a successful setup here means
you have **not** enabled it, and instead have a documented `extra.patches`
section in `composer.json` that reapplies cleanly on `composer install`.
