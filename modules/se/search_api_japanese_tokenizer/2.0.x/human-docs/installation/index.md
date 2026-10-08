# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Search API** module (`search_api`).
- The **JNLP** (Japanese Natural Language Processing) module — in the 2.x series
  this is a required dependency that does the actual text analysis. Install the
  JNLP submodule that matches the tokenizer you want to use.
- For the **MeCab** and **Sudachi** tokenizers only: the corresponding analyzer
  must be available on the server, and its path is set in `settings.php` (see
  Configuration). The **TinySegmenter** and **Igo-php** tokenizers are pure PHP
  and need nothing installed on the server.

There are no third-party Composer library requirements for the base module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_japanese_tokenizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_japanese_tokenizer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module together with the tokenizer submodule you have chosen. For
example, to use the zero-install TinySegmenter tokenizer:

```bash
drush en search_api_japanese_tokenizer search_api_tinysegmenter -y
```

## Tokenizer submodules — enable exactly one

This module ships four tokenizer submodules. Enable **one** of them (do not enable
more than one Japanese tokenizer on the same index):

| Submodule | Machine name | Tokenizer | Server install needed? |
|-----------|--------------|-----------|------------------------|
| TinySegmenter | `search_api_tinysegmenter` | Machine-learning, pure PHP. The only tokenizer that can exclude tokens by character type. | No |
| Igo-php | `search_api_igo_php` | Morphological analysis, pure PHP. | No |
| MeCab | `search_api_mecab` | Morphological analysis via the MeCab engine. | Yes — set the analyzer path in `settings.php`. |
| Sudachi | `search_api_sudachi` | Morphological analysis via the Sudachi engine. | Yes — set the analyzer path in `settings.php`. |

A tokenizer is hidden from the index form whenever its analyzer is not available
on the server, so if a choice is missing, that engine isn't installed.

> **Upgrading from 1.x?** JNLP is now a required dependency, and the analyzer
> paths for MeCab and Sudachi have moved out of the processor settings into
> `settings.php`. Read the project's README for the full upgrade procedure before
> running database updates.

## Verify it worked

Edit a search index, open its **Processors** tab, and confirm your chosen Japanese
tokenizer appears in the list. If it does, continue to
[Configuration](../configuration/index.md).
