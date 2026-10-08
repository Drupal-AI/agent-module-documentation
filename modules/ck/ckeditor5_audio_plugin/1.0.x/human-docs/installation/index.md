# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_audio_plugin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_audio_plugin -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_audio_plugin -y
```

## Verify it worked

Edit a CKEditor 5 text format at **Configuration → Content authoring → Text
formats and editors**, add the **Audio** button to the toolbar, and save. Then
open any content edit form using that format — clicking the Audio button should
let you upload an audio file or embed one from a link, and the clip appears
playable in the editor.
