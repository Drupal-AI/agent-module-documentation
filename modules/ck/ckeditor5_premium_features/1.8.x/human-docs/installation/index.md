# Installation

## Requirements

- **Drupal 10.3, or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.0 or newer**, with the `dom` and `libxml` extensions (both are standard
  on almost every Drupal-capable PHP install).
- Core's **Editor** (`editor`) and **CKEditor 5** (`ckeditor5`) modules — Drupal
  enables these automatically as dependencies.
- A **CKEditor commercial license key** and/or a **CKEditor Cloud Services**
  subscription for most features (a free trial is available at
  orders.ckeditor.com). The module installs without them, but the features stay
  dormant until you enter credentials.

Some individual features also need a PHP library, pulled in through Composer's
optional "suggests":

- `firebase/php-jwt` — real-time collaboration and the document converters.
- `caxy/php-htmldiff` — asynchronous collaboration and notifications.
- `openai-php/client` — the OpenAI and Azure AI providers for the AI Assistant.
- `aws/aws-sdk-php` — the AWS Bedrock provider for the AI Assistant.

Install these only if you enable the feature that needs them, for example
`composer require firebase/php-jwt`.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_premium_features -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_premium_features -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_premium_features -y
```

Enabling the base module gives you the settings form and the authentication
plumbing, but no editing feature yet — for that you enable the feature submodules
below.

## Submodules — enable only what you need

The real features live in around 20 submodules. Enable individually with
`drush en`. A few of the most common:

| Submodule | What it adds |
|-----------|--------------|
| `ckeditor5_premium_features_export_pdf` | Export a field's content to PDF |
| `ckeditor5_premium_features_export_word` | Export content to Word (`.docx`) |
| `ckeditor5_premium_features_import_word` | Import Word documents into the editor |
| `ckeditor5_premium_features_realtime_collaboration` | Live collaborative editing (needs Cloud Services auth) |
| `ckeditor5_premium_features_collaboration` | Track changes and inline comments |
| `ckeditor5_premium_features_notifications` | Notify users of mentions, replies, and accepted/rejected suggestions |
| `ckeditor5_premium_features_ai` / `_ai_assistant` | An in-editor AI assistant (OpenAI / Azure / AWS Bedrock) |
| `ckeditor5_premium_features_mentions` | Let editors @-mention other users |
| `ckeditor5_premium_features_merge_fields` | Insert dynamic merge fields / placeholders |
| `ckeditor5_premium_features_footnotes` | Add footnotes to long-form content |
| `ckeditor5_premium_features_fullscreen` | A maximise / full-screen editing mode (free to use) |
| `ckeditor5_premium_features_productivity_pack` | Formatting, templates, and editing shortcuts |
| `ckeditor5_premium_features_wproofreader` | WProofreader spelling and grammar checking |
| `ckeditor5_premium_features_multi_level_lists` | Multi-level lists |
| `ckeditor5_premium_features_source_editing_enhanced` | Enhanced source editing |
| `ckeditor5_premium_features_line_height` | Line-height control |
| `ckeditor5_premium_features_email_editing` | Email editing tools |
| `ckeditor5_premium_features_version_override` | Pin the CKEditor library version |

For example, to add PDF export:

```bash
drush en ckeditor5_premium_features_export_pdf -y
```

Each submodule requires the base module, which is already present once you have
installed it above.

## Verify it worked

After enabling, go to **Configuration → CKEditor 5 Premium Features** and confirm
the settings form loads. Once you enter your license key and add a feature's
button to a text format's toolbar, that feature will appear in the CKEditor 5
editor. See [Configuration](../configuration/index.md) for the details.
