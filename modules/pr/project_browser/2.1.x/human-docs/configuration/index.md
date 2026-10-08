# Configuration

Go to **Configuration → Development → Project Browser**
(`/admin/config/development/project_browser`). This form requires the core
**Administer site configuration** permission, and its values are stored as
exportable configuration.

## Sources

Project Browser draws its listings from one or more **sources**. On the settings
form you enable the sources you want, order them (the order is their display
order on the Browse page), and pick which one opens first.

- **Default source** — the source shown when the Browse page first opens (defaults
  to the Drupal.org contrib source). This cannot be left blank.
- **Enabled sources** — which sources are active. At least one must stay enabled.
  The built‑in sources are:
  - **Drupal.org contrib** (`drupalorg_jsonapi`) — contrib modules from
    Drupal.org via its JSON:API. Has an option to also filter by **development
    status**.
  - **Drupal core** (`drupal_core`) — core modules.
  - **Recipes** (`recipes`) — recipes found in the local code base; you can point
    it at additional directories.
  - **Local modules** (`local_modules`) — modules already installed on the site.
  - **Recommended** (`recommended`) — a curated list fetched from a URL you
    configure, with a cache lifetime (TTL).

Each source may add its own tab on the Browse page, and some sources expose extra
per‑source settings (like the recommended source's URL, or the recipes source's
extra directories).

## In‑UI installation (experimental)

- **Allow installing via UI** *(off by default)* — turns on the experimental
  ability to install a project straight from the Browse page. For this to actually
  install, Drupal core's **Package Manager** module must also be enabled; the
  install routes only exist when it is present. When installation runs, Package
  Manager performs the Composer download and apply steps in a sandbox, then
  Project Browser enables the module (or applies the recipe).

  With Package Manager absent, or this option off, the Browse page instead shows
  the `composer require` command for you to run yourself.

If an in‑UI installation gets stuck, there is an unlock action to clear the
sandbox, and an **Actions** form
(`/admin/config/development/project_browser/actions`) that offers a "Clear
storage" action — the same as the `drush pb-sc` command.

## Access and permissions

Project Browser defines **no permissions of its own**. Instead:

- Browsing the catalog and installing projects use the core **Administer modules**
  permission.
- The settings and actions forms use the core **Administer site configuration**
  permission.

Grant these core permissions to the roles that should manage modules.
