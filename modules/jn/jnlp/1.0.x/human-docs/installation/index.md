# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Additional requirements **depend on the analyzer you choose** (see Submodules
  below):
  - **MeCab** — the MeCab binary and a dictionary installed on the server (e.g.
    `apt-get install mecab mecab-ipadic-utf8`).
  - **Sudachi** — a Java Runtime Environment, the Sudachi JAR, and a Sudachi
    dictionary.
  - **Igo‑php** — the `logue/igo-php` Composer package (bundled IPA dictionary).
  - **TinySegmenter** — the `u7aro/tinysegmenter-php` Composer package.

## Install with Composer

From the project root:

```bash
composer require drupal/jnlp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jnlp -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jnlp -y
```

## Submodules — enable the analyzer(s) you want

The base `jnlp` module defines the API; the actual analysis comes from enabling one
or more analyzer submodules. Pick based on what your server can support:

| Submodule | Machine name | Analyzer | Needs |
|-----------|--------------|----------|-------|
| JNLP MeCab | `jnlp_mecab` | MeCab (fast, widely used) | MeCab binary + dictionary on the server |
| JNLP Sudachi | `jnlp_sudachi` | Sudachi (normalization, split modes A/B/C) | Java runtime, Sudachi JAR + dictionary |
| JNLP Igo‑php | `jnlp_igo_php` | Igo (pure PHP) | `logue/igo-php` Composer package (no binaries) |
| JNLP TinySegmenter | `jnlp_tinysegmenter` | TinySegmenter (pure PHP, ML) | `u7aro/tinysegmenter-php` Composer package |

If you want a setup with **no server binaries or Java**, choose **Igo‑php** or
**TinySegmenter**. For example:

```bash
drush en jnlp_igo_php -y
```

Each submodule requires the base `jnlp` module, which is already present once you've
installed it above.

## Verify it worked

Go to **Configuration → Region and language → Japanese Natural Language
Processing** (`/admin/config/regional/jnlp`), enter some Japanese text into the test
form for the analyzer you enabled, and confirm it returns tokens. For MeCab and
Sudachi you'll need to set the paths described in
[Configuration](../configuration/index.md) first.
