# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Field Group** module (`field_group`) — provides the field group system
  this formatter plugs into.
- The **EU Cookie Compliance** module (`eu_cookie_compliance`) — provides the
  cookie categories and the consent cookie this formatter reads.

Both are separate contributed modules; install them alongside this one. There
are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_group_eu_cookie_compliance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Field Group and EU Cookie Compliance dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_group_eu_cookie_compliance -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_group_eu_cookie_compliance -y
```

This also enables Field Group and EU Cookie Compliance if they aren't already
on.

## Required cache settings

Because the formatter varies its output by the visitor's accepted cookie
categories, you must adjust caching so consent variation is respected:

1. **Disable the core Internal Page Cache module** (`page_cache`) — an anonymous
   page cache would serve one cached copy to everyone regardless of consent.

   ```bash
   drush pmu page_cache -y
   ```

2. **Add the cookies cache context** to your site's required cache contexts. The
   project ships a `services_example.yml` you can copy from; add
   `cookies:cookie-agreed-categories` to `required_cache_contexts` in your
   site's `services.yml`, then rebuild caches:

   ```bash
   drush cr
   ```

Skipping these steps can cause a cached page to show the wrong (pre‑ or
post‑consent) version to a visitor.

## Verify it worked

On any entity's **Manage display**, add a field group and open its format
dropdown — you should see **EU Cookie Compliance** listed among the available
formats. Assign it, choose a required cookie category, move a field into the
group, and view the entity both before and after accepting that category to
confirm the field appears only once consent is given.
