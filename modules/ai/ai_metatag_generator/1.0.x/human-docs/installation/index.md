# Installation

## Requirements

AI Metatag Generator is a thin add-on, so its requirements are really its two
dependencies:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **AI** module (`ai`) — enabled and already configured with at least one
  working AI provider, because that is what drafts the metadata.
- The **Metatag** module (`metatag`) — this stores and outputs the generated
  tags.

There are no extra PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_metatag_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies such as the AI and Metatag modules as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_metatag_generator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_metatag_generator -y
```

Drupal enables the `ai` and `metatag` modules as dependencies if they are not
already on.

## After enabling

1. Make sure the **AI** module has a provider configured with a working API key
   (stored as a secret via the Key module, per this project's conventions).
2. Grant the **Use AI Metatag Generator** permission (`use ai metatag
   generator`) to the roles that should be allowed to trigger generation, and
   **Administer AI Metatag Generator** to administrators.

There is no dedicated settings page for this module — once the dependencies are
in place, editors generate metadata from the node edit form.
