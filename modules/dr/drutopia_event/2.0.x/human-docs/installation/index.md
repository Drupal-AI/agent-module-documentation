# Installation

## Requirements

- **Drupal 10.2, 11 or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- This is a Drutopia feature and pulls in a substantial dependency stack, all of
  which Composer/Drush will resolve for you:
  - **Drutopia Core** (`drutopia_core`) and **Drutopia SEO** (`drutopia_seo`).
  - **Core:** Datetime (`datetime`), Datetime Range (`datetime_range`), Media
    (`media`), Node (`node`), Taxonomy (`taxonomy`), Views (`views`).
  - **Contrib:** Display Suite (`ds`), Paragraphs (`paragraphs`), Facets
    (`facets`), Search API (`search_api`), Focal Point (`focal_point`), Field
    Group (`field_group`), Metatag (`metatag`), Pathauto (`pathauto`), Entity
    Reference Revisions (`entity_reference_revisions`) and Block Visibility
    Groups (`block_visibility_groups`).

There are no PHP library requirements. It is normally installed as part of a full
Drutopia site rather than in isolation.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_event -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer
pull in Drutopia Core, Drutopia SEO and the rest of the dependency stack.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drutopia_event -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_event -y
```

Enabling it also enables its dependencies and installs the bundled configuration —
the `event` content type with its date-range field, the `event_type` vocabulary,
the view displays, the Search API index and facets, the listing view, the Pathauto
patterns, the Metatag defaults and the block visibility group.

## Verify it worked

- Go to **Structure → Content types** (`/admin/structure/types`) and confirm an
  **Event** type is present, with an event date (range) field.
- Go to **Content → Add content** (`/node/add`) and confirm **Event** is an
  option, then create a test event with a start and end date.
- Check that the event listing shows your new event, that facets by type/topics
  appear, and that the event received an SEO-friendly URL alias.
