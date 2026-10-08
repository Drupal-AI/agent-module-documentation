# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4||^11`).
- Core's **File** module (`file`) — enabled automatically as a dependency.
- A properly configured **private file system** (a `private://` path in
  `settings.php`), served through Drupal's access-checked file delivery. This is
  essential: File Visibility protects files by moving them into the private scheme,
  which only works if that scheme exists and is served securely.
- To actually compute file usage, either the bundled **`file_visibility_track_usage`**
  submodule plus the contributed **Track Usage** module, or a custom FileVisibility
  plugin. The base module ships no plugin on its own.

Note this is an **alpha** release (`1.0.0-alpha9`); test it thoroughly before
production use.

## Install with Composer

From the project root:

```bash
composer require drupal/file_visibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_visibility -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_visibility -y
```

Enabling the base module alone is not enough to change behavior — it provides the
plugin *type* but no plugin. You need a source of file-usage information (below).

## Submodules

- **`file_visibility_track_usage`** — ships a FileVisibility plugin that computes
  file-to-entity relationships using the contributed **Track Usage** module. Install
  Track Usage, then enable the submodule:

  ```bash
  drush en file_visibility_track_usage -y
  ```

  Configure *which* entity types and fields are tracked in the **Track Usage**
  module's own settings — that is what tells File Visibility how files relate to the
  content that uses them.

If you have your own way of computing file usage, you can instead provide a custom
FileVisibility plugin rather than using this submodule.

## Verify it worked

1. Confirm the private file system is configured (a `private://` path is set) and
   files served from it are access-checked.
2. Attach a file to an entity and take that entity out of public visibility (for
   example, unpublish it) so that no anonymous-visible content uses the file.
3. Confirm the file is moved to the private file system and can no longer be fetched
   by its old public URL.
4. Restore public content that uses the file and confirm it moves back to the public
   file system.
