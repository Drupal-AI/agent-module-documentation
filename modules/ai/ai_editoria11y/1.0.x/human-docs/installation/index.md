# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Editoria11y** module (`editoria11y`) — the accessibility checker this
  module extends.
- The **AI** module (`ai`) with a configured provider — supplies the model.
- The **AI CKEditor** module (`ai_ckeditor`, part of the AI project) and core
  **CKEditor 5** (`ckeditor5`) — used to apply AI fixes in the editor.
- A configured AI **provider** whose API key is stored as a **Key** entity (see
  below).

This is a beta release (1.0.0-beta1), so test it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_editoria11y -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Editoria11y,
AI, AI CKEditor and CKEditor 5 dependencies and update shared packages as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_editoria11y -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_editoria11y -y
```

This also enables Editoria11y, the AI module, AI CKEditor and core CKEditor 5 if
they are not already on.

## After enabling

Grant the module's "Fix with AI" permission to the editors who should use it, and
make sure the AI provider's API key is stored securely — save it in an
environment variable, wrap it in a **Key** entity, and point your AI provider at
that key. See [How to use it](../index.md#how-to-use-it) in the overview.
