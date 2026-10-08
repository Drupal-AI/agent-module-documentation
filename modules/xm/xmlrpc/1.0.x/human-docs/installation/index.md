# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1.6 or newer** (`php: >=8.1.6`).
- No module dependencies and no third-party PHP libraries.

## A word before you install

XML-RPC is a legacy protocol and the server endpoint it provides at `/xmlrpc` is
**unauthenticated and open by design**. Only install and enable this module if you
have a real need for XML-RPC interoperability (typically a legacy integration
carried over from Drupal 7). If you add or enable any XML-RPC server methods, make
sure each method does its own access control. See the
[overview](../index.md) for the full security picture.

## Install with Composer

From the project root:

```bash
composer require drupal/xmlrpc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/xmlrpc -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en xmlrpc -y
```

Once enabled, the client function `xmlrpc()` is available to code and the server
route `/xmlrpc` is live (answering only the built-in `system.*` introspection
methods until a module registers more).

## Optional: the example submodule

The bundled **XML-RPC Example** submodule shows a working client and server
implementation — useful as a reference or for integration tests:

```bash
drush en xmlrpc_example -y
```

It requires the base XML-RPC module, which is already present once you have
installed it above.
