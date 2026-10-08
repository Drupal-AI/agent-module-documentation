# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** and **Field** modules (both part of Drupal core).
- The contrib **Key** module (`key/key`), used to store the ORCID Client Secret
  securely.
- An **ORCID application** (Client ID and Client Secret) created in the ORCID
  Developer Portal.

## Install with Composer

From the project root:

```bash
composer require drupal/link_orcid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/link_orcid -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_orcid -y
```

If the Key module is not already enabled, enable it too:

```bash
drush en key -y
```

## Register an ORCID application and store the secret

1. In the [ORCID Developer Portal](https://orcid.org/developer-tools), create a
   new application to obtain your **Client ID** and **Client Secret**.
2. Set the application's **Redirect URI** to
   `https://your.site.com/link-orcid/callback` (use your real domain).
3. Store the **Client Secret** as a **Key** entity — an environment‑backed key is
   recommended so the raw secret never lands in configuration. You will select
   this Key on the settings form.

## Create the storage field

Add a **plain text** field to the **User** entity (at **Configuration → People →
Account settings → Manage fields**) to hold the ORCID iD. You will point the
module at this field during configuration; it will then be disabled for manual
editing and set only through the Link ORCID button.

## Verify it worked

Visit **Configuration → People → Link an ORCID settings**
(`/admin/config/people/link-orcid`) and confirm the settings form loads. Once you
have completed [Configuration](../configuration/index.md) and granted the **Link
own ORCID** permission, a user's own profile edit form should show a **Link
ORCID** button next to the configured field.
