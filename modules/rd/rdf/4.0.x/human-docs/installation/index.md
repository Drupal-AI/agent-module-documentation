# Installation

## Requirements

- **Drupal core 11.3 or 12** (`core_version_requirement: ^11.3 || ^12`). This 4.x
  branch does not run on older core; use the 2.x/3.x branches for Drupal 10.
- No contributed module dependencies. (Tests use the `sweetrdf/easyrdf` library as
  a dev-only dependency to parse RDFa output; it is not needed at runtime.)

## Install with Composer

From the project root:

```bash
composer require drupal/rdf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rdf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rdf -y
```

Enabling RDF immediately starts adding RDFa metadata to output for the bundles it
has default mappings for (article, page, forum, user, tags, comment). There is no
required configuration.

## Verify it worked

Visit any article or page on the front end and view the page source. You should see
RDFa attributes such as `typeof`, `property`, and `rel` woven into the node's
markup. That confirms the module is active and emitting semantic metadata.

To describe a custom content type, or to change what's emitted for a core bundle,
edit the relevant `rdf.mapping.*` configuration entity (in code/config) — there is
no admin form for this.
