# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- Core's **File** module (`file`), which core enables as a dependency.
- The **exiftool binary** installed on the server and available on the system path.
  This is the one requirement that is not handled by Composer — see below.

## Install exiftool

Metadata Sanitizer shells out to the exiftool binary, so it must be present on the
server:

- **Debian/Ubuntu:** `sudo apt-get install -y libimage-exiftool-perl`
- **RHEL/Rocky/Alma:** `sudo dnf install -y perl-Image-ExifTool`
- **macOS:** `brew install exiftool`
- **DDEV:** add `libimage-exiftool-perl` to `webimage_extra_packages` in
  `.ddev/config.yaml`, then `ddev restart`.

The module verifies exiftool's availability at runtime, so if the binary is missing
it will tell you rather than fail silently.

## Install with Composer

From the project root:

```bash
composer require drupal/metadata_sanitizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/metadata_sanitizer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en metadata_sanitizer -y
```

Then grant the **administer metadata sanitizer** permission to the roles that
should manage it — it is not assigned to anyone by default.

## Submodules — optional AI integration

Metadata Sanitizer ships two optional submodules that integrate with the Drupal AI
ecosystem:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **AI Agents** | `metadata_sanitizer_ai_agents` | An AI advisor tab under the module's settings. The bundled AI agent can check your environment, profile your managed files, recommend settings, estimate bulk-clean scope, preview metadata, generate a conservative Drush command, and perform confirmed bulk cleaning through natural language. |
| **Tool API** | `metadata_sanitizer_tool_api` | Exposes the module's operations as Tool-API-aligned plugins, so Tool-API connectors (such as `tool_ai_connector`) can discover and invoke them. |

Enable them only if you use the Drupal AI modules, for example:

```bash
drush en metadata_sanitizer_ai_agents -y
```

## Verify it worked

Go to **Configuration → Media → Metadata Sanitizer** and confirm the settings form
loads and reports exiftool as available. Upload a photo that you know contains GPS
or EXIF data, then inspect the stored file — the metadata should be gone.
