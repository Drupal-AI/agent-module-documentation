# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No other module dependencies, and no additional PHP or library requirements.
- A browser that supports the **Web Speech API** for the dictation to work (be
  aware that in some browsers the audio is sent to the browser vendor for
  recognition — see the [main guide](../index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/speech_to_text -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/speech_to_text -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en speech_to_text -y
```

(You can also enable it from the UI at **Extend** / `/admin/modules`.)

## Verify it worked

Log in as an administrator and visit `/admin/config/systems/speech-to-text`. If
the settings page loads, the module is ready — configure the input selectors there
(see [Configuration](../configuration/index.md)), then open a form containing one
of the targeted fields and confirm a dictation control appears.
