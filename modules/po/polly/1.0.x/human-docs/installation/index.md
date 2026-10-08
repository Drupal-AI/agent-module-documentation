# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Datetime** (`datetime`), **File** (`file`), **Link** (`link`) and
  **Options** (`options`) modules.
- The contrib **AWS** (`aws`) module, which manages the connection to Amazon Web
  Services and your credentials.
- An **AWS account** with access to Amazon Polly, and the network egress for your
  site to reach the AWS API. Amazon Polly is a paid service — usage incurs AWS
  charges.

Note this is a beta release (version 1.0.0-beta2) and is **not covered by Drupal's
security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/polly -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the **AWS** module and the core
dependencies and updates shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/polly -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en polly -y
```

Then enable the submodule(s) that give you the actual functionality you need:

## Submodules

| Submodule | What it adds |
|-----------|--------------|
| **Polly Synthesis Task** | A content entity that stores Polly synthesis tasks and processes them on cron — queue text, get audio back in the background. |
| **Polly Media** | A media source based on a synthesis-task entity; can adapt media widgets so editors synthesize speech instead of uploading an audio file. |

Enable them with `drush en`, for example:

```bash
drush en polly_synthesis_task polly_media -y
```

(Confirm the exact submodule machine names with `drush pm:list | grep polly` after
installing, as they may differ slightly.)

## Verify it worked

1. Configure your AWS credentials and Polly preferences (see
   [Configuration](../configuration/index.md)).
2. If you enabled **Polly Synthesis Task**, create a synthesis task and run cron
   (`drush cron`), then confirm the audio file is generated.
