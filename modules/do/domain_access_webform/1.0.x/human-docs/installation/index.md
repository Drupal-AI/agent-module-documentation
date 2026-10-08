# Installation

## Requirements

- **Drupal 9.5 or 10** (`core_version_requirement: ^9.5 || ^10`).
- **Domain** (`domain`) — the Domain Access module, which provides the domain
  records and the user domain-assignment fields the restrictions rely on.
- **Webform** (`webform`) — the module whose forms and submissions this scopes
  per domain.
- No separate PHP library requirements.

Make sure Domain Access is fully set up — including users having their
`field_domain_access` / `field_domain_admin` assignments — before you rely on the
restrictions, or non-bypass users will resolve to zero allowed domains.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_access_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Domain and Webform if they are not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/domain_access_webform -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_access_webform -y
```

## Grant the bypass permission

The module adds one permission, **bypass domain access webform restrictions**.
Users who hold it ignore the per-domain limits entirely — they can see and submit
across all domains. Go to **People → Permissions** and grant it only to trusted
roles, then keep an eye on who has it, since it is the single escalation path.

## Bulk-assigning existing forms (optional)

If you already have webforms and submissions that predate this module, the
project ships a **Domain Webform Mapper** submodule that can map existing
webforms and submissions to domains in bulk, rather than editing each one by hand.

## Verify it worked

Open **Structure → Webforms**. The list should now show a **Domain** column and a
domain filter. Edit a webform, go to **Settings → Form**, and confirm you can
choose the domains it is available on. Then, as a non-bypass user assigned to one
domain, confirm you only see that domain's submissions in the submissions list.
Clear caches after changing a webform's domains so the changes take effect.
