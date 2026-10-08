# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 | ^10 | ^11`).
- No module dependencies.

There are no additional PHP requirements. Be aware that the SCEditor JavaScript
library is loaded from an external CDN (jsDelivr) pinned to `@latest`, so the
exact frontend version is not locked by the module. If you need a fixed version or
must avoid third‑party CDN requests, plan to override the library definition to
self‑host it.

## Install with Composer

From the project root:

```bash
composer require drupal/sceditor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sceditor -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sceditor -y
```

## Assign it to a text format

There is no separate settings page. To start using SCEditor, go to
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), edit (or add) a text format, and choose
**SCEditor** as the text editor. Keep an appropriate sanitising filter enabled on
that format, since the editor is not XSS‑safe.

## Verify it worked

Edit a node or comment whose field uses the format you configured — the SCEditor
toolbar should appear on the textarea. Confirm the format still has a sanitising
filter enabled for any roles that are not fully trusted.
