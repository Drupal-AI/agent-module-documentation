# Installation

## Requirements

File Download Token needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- No other module dependencies for the base module.
- The **Webform** module — only if you plan to use the
  `file_download_token_webform` submodule.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/file_download_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_download_token -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_download_token -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **File Download Token Webform** | `file_download_token_webform` | Integrates with the Webform module: pick a file under a webform's **Settings → Confirmation** tab (*Download token file*), then drop the `[webform:file-download-token-url]` token into a handler's text to email a fresh, time-limited download link on submission. Requires the Webform module. |

Enable it when you need the Webform integration:

```bash
drush en file_download_token_webform -y
```

## Verify it worked

With the base module enabled, tokenized download links can be minted for files.
If you enabled the Webform submodule, edit a webform, open **Settings →
Confirmation**, and confirm the **Download token file** option is available.

Remember: the resulting `/token-download/{token}` link is a capability — anyone
who receives it can download the file until it expires after 24 hours, so deliver
it over a secure channel.
