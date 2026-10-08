# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contributed-module dependencies.
- The **Ace Editor** (version 1.36.5, BSD 3-Clause) is bundled with the module and
  loaded lazily for syntax highlighting — you do not install it separately.

## Install with Composer

From the project root:

```bash
composer require drupal/stylify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/stylify -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en stylify -y
```

## Grant the editor permissions

Enabling the module is not enough — the on-page editor only appears for users who
hold one of Stylify's permissions, and **all of them are marked *restrict
access***, meaning they carry real security weight. Go to **People → Permissions**
(`/admin/people/permissions`) and grant only what each role genuinely needs:

| Permission | Lets a user… |
|------------|--------------|
| **Edit global stylify CSS** (`edit global stylify css`) | Edit the site-wide front-end stylesheet. |
| **Edit admin stylify CSS** (`edit admin stylify css`) | Edit CSS for the administrative interface. |
| **Edit entity stylify CSS** (`edit entity stylify css`) | Edit CSS scoped to entities and content types. |
| **Access stylify CSS editor** (`access stylify css editor`) | A break-glass permission granting broad editor access — reserve for administrators. |
| **Manage stylify settings** (`manage stylify settings`) | Reach the central management and settings screens. |

Grant the narrowest permission that fits the role: `edit entity stylify css` for
content editors, `edit global stylify css` for site-wide front-end CSS, `edit admin
stylify css` for admin-area CSS. Because the CSS a user writes is served to every
visitor of the matching page, treat these grants like handing out deployment
rights.

## Verify it worked

Log in as a user who holds one of the editor permissions and open any page. A
**CSS Editor** button should appear in the bottom-right corner. Administrators
should also find **Configuration → System → Stylify stylesheets** and **Stylify
Settings**. Continue with [Configuration](../configuration/index.md).
