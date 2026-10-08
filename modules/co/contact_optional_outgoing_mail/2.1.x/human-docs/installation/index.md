# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Contact** module (`contact`) — the only dependency, enabled
  automatically by Drupal.
- Optional but common companion: the **Contact Storage** module, if you want the
  submissions saved when no email is sent.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_optional_outgoing_mail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/contact_optional_outgoing_mail -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_optional_outgoing_mail -y
```

## Verify it worked

Edit a contact form at **Structure → Contact forms** and try saving it with the
**Recipients** field empty. With the module enabled this should now be allowed
(core would previously have required a recipient). Submissions to a recipient-less
form won't be emailed.
