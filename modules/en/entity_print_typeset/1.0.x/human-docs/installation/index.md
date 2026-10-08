# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Entity Print** module (`entity_print`) — a hard dependency that provides
  the print links, routes, and access control.
- A **valid typeset.sh subscription** and the **`typesetsh/typesetsh`** library.
  This is a **paid, commercial** dependency and is *not* installed automatically:
  the *Typeset.sh* engine only appears once the `Typesetsh\HtmlToPdf` class is
  available.

## Install the paid typeset.sh library first

Follow typeset.sh's own documentation, which involves:

1. Adding the **`packages.typeset.sh`** Composer repository to your project's
   `composer.json`, authenticated with your typeset.sh access token (store the
   token in Composer's auth config, not in a file you commit).
2. Requiring the library:

   ```bash
   composer require typesetsh/typesetsh
   ```

Refer to the module's README and the typeset.sh documentation for the exact
repository and credential details, as these are managed by typeset.sh.

## Install this module with Composer

From the project root:

```bash
composer require drupal/entity_print_typeset -W
```

The `-W` (`--with-all-dependencies`) flag pulls in Entity Print and any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_print_typeset -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable this module together with Entity Print:

```bash
drush en entity_print entity_print_typeset -y
```

## Verify it worked

Go to **Configuration → Content authoring → Entity Print**
(`/admin/config/content/entityprint`). If the typeset.sh library is correctly
installed, **Typeset.sh** will be selectable as the PDF engine. Select it,
generate a PDF from an Entity Print print link, and confirm you get an A4
document rendered by typeset.sh. If the engine does not appear, the
`typesetsh/typesetsh` library is not installed or not found — revisit the library
installation step above.
