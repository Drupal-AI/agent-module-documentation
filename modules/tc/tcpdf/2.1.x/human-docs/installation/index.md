# Installation

## Requirements

- **Drupal 10.6+, 11.3+, or 12** (`core_version_requirement: ^10.6 || ^11.3 || ^12`; the Composer
  constraint on `drupal/core` is the same `^10.6 || ^11.3 || ^12`).
- The **`tecnickcom/tcpdf`** PHP library at **6.11.4 or newer** — this is the actual PDF engine.
  It is declared as a Composer dependency of the module, so installing with Composer (below)
  pulls it in automatically; you do not download it by hand.
- A **writable temporary directory**. The module caches TCPDF working files under
  `temporary://tcpdf/cache`; its runtime requirements check will warn on the status report if
  that directory cannot be created or written.

## Install with Composer

From the project root:

```bash
composer require drupal/tcpdf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as needed —
and it is what pulls in the `tecnickcom/tcpdf` library alongside the Drupal module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/tcpdf -W`, `ddev drush …`. Inside the container (`ddev ssh`) run
> them without the prefix.

## Enable the module

```bash
drush en tcpdf -y
```

After enabling, check **Reports → Status report** (`/admin/reports/status`): the module reports
whether the TCPDF class is available and whether its cache directory is writable.

## Optional: the example submodule

`tcpdf_example` (`tcpdf_example`) adds a permission-gated route that streams a sample PDF —
useful to confirm the library works end-to-end and to read as a worked integration example.
Enable it only while testing or learning:

```bash
drush en tcpdf_example -y
```

It requires the base `tcpdf` module, which is already present once you have installed the above.
Disable it again when you are done. See its own docs under
`modules/tcpdf_example/2.1.x/` for the route and permission.
