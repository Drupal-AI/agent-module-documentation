# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drupal core only** — no additional modules, no external JavaScript libraries.
- Recording uses the browser's native MediaRecorder API, supported by all modern
  browsers (Chrome/Edge 49+, Firefox 25+, Safari 14+, Opera 36+). Because the
  microphone is involved, browsers require the site to be served over **HTTPS**
  for recording to work.

## Install with Composer

From the project root:

```bash
composer require drupal/name_pronunciation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/name_pronunciation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en name_pronunciation -y
```

## Verify it worked

Go to **Structure → Content types → *(a content type)* → Manage fields → Add
field**. In the field‑type list you should now see **Name Pronunciation**. Add it
to a bundle, then create or edit a piece of content and confirm you can record or
upload a pronunciation, preview it, and hear it play back on the rendered page.

For the full field setup, see [How to use it](../index.md#how-to-use-it).
