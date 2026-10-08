# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **Domain** (`domain`) — the Domain Access module. Composer accepts
  `drupal/domain ^2.0 || ^3.0`. This is what provides the domain records the
  logos attach to.
- Core's **File** module (`file`), which handles the uploaded logo images. Drupal
  enables it as a dependency.
- No separate PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_access_logo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in the Domain module if it is not
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/domain_access_logo -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_access_logo -y
```

Make sure the Domain module is set up first — you need domain records to exist
before there is anything to attach logos to.

## Grant the permission

Logo management has its own permission, **Administer domains access logos**
(`administer domains access logos`), deliberately separate from "administer site
configuration". Go to **People → Permissions** (`/admin/people/permissions`) and
grant it to whichever role should manage per-domain logos.

## Upgrading from 1.x

Logo storage changed between the 1.x and 2.x releases. If you are upgrading an
existing site rather than installing fresh, run the module's database updates
(`drush updatedb`) and confirm your existing logos still resolve before going
live.

## Verify it worked

Go to **Configuration → Domain → Domain Access Logo**
(`/admin/config/domain/domain_access_logo`). You should see a form listing your
domains, each with its own logo upload. Set a logo, save, and load that domain in
a browser — the domain-specific logo should appear regardless of the active theme.
See [Configuration](../configuration/index.md) for a walkthrough of the form.
