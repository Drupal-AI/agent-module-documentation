# Installation

## Requirements

- **Drupal 11.3 or newer, or Drupal 12** (`core_version_requirement: ^11.3 || ^12`). Drupal 9 and 10
  are no longer supported — stay on the 2.x branch if you need them.
- The **`tecnickcom/tcpdf`** PHP library at **7.0.15 or newer** — this is the actual PDF engine, and
  it pulls in the `tecnickcom/tc-lib-pdf` 8.x component family. It is declared as a Composer dependency
  of the module, so installing with Composer (below) pulls it in automatically; you do not download it
  by hand.
- **Built font files.** TCPDF 7 reads fonts from `tecnickcom/tc-lib-pdf-font`, which does **not** ship
  them — they must be built once (see below). The runtime requirements check reports an error on the
  status page until the fonts are found.

## Install with Composer

From the project root:

```bash
composer require drupal/tcpdf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as needed —
and it is what pulls in the `tecnickcom/tcpdf` library (and its `tc-lib-pdf` components) alongside
the Drupal module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/tcpdf -W`, `ddev drush …`. Inside the container (`ddev ssh`) run
> them without the prefix.

## Build the fonts

TCPDF cannot create a PDF without font files. The build downloads roughly 120 MB of font sources and
writes about 42 MB of fonts.

**Inside `vendor/`** — TCPDF finds them with no configuration, but Composer deletes them on every
update of the font package:

```bash
php vendor/tecnickcom/tc-lib-pdf-font/util/build_fonts.php
```

To rebuild automatically, add that command to the `post-install-cmd` / `post-update-cmd` scripts in
your project's `composer.json`.

**Outside `vendor/`** — survives Composer updates. Build into a directory of your choice and point
settings at it:

```bash
composer install --no-dev --working-dir=vendor/tecnickcom/tc-lib-pdf-font/util
php vendor/tecnickcom/tc-lib-pdf-font/util/bulk_convert.php --outpath="$PWD/private/tcpdf-fonts/"
rm -rf vendor/tecnickcom/tc-lib-pdf-font/util/vendor
```

```php
// settings.php
$settings['tcpdf_fonts_path'] = $app_root . '/../private/tcpdf-fonts';
```

## Enable the module

```bash
drush en tcpdf -y
```

After enabling, check **Reports → Status report** (`/admin/reports/status`): the module reports
whether the TCPDF class is available and whether the fonts were found (with the resolved path when
they are).

## Embedding local files and images

TCPDF 7 only reads local files from a short list of trusted directories (the system temporary
directory, the working directory, and a few library directories), and downloads remote images only
from hosts listed in `K_ALLOWED_HOSTS`. To embed files from elsewhere (for example the private file
system), pass a real path and add its directory to `K_ALLOWED_PATHS` in `settings.php`:

```php
define('K_ALLOWED_PATHS', [$app_root . '/../private/pdf-images']);
```

Only add directories whose files may legitimately end up in a generated PDF.

## Optional: the example submodule

`tcpdf_example` (`tcpdf_example`) adds a permission-gated route that streams a sample PDF —
useful to confirm the library works end-to-end and to read as a worked integration example.
Enable it only while testing or learning:

```bash
drush en tcpdf_example -y
```

It requires the base `tcpdf` module, which is already present once you have installed the above.
Disable it again when you are done. See its own docs under
`modules/tcpdf_example/3.0.x/` for the route, permission, and a runnability note.
