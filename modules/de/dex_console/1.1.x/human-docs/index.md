# Dex Console — manual setup guide

**Dex Console** (`dex_console`) gives Drupal its own command-line binary called
`dex`. When you run `vendor/bin/dex`, it boots a full Drupal environment and then
runs any Symfony Console commands it discovers across your modules — without
relying on Drush's command system. It's a lightweight, Drush-independent way for
module authors to expose CLI commands using nothing but standard Symfony Console
classes and the `#[AsCommand]` attribute.

The idea is deliberately simple: drop a command class into a module's
`src/Command/` directory, mark it with `#[AsCommand(name: 'mymodule:thing')]`,
clear the cache, and run it with `vendor/bin/dex mymodule:thing`. Dex handles
discovery, autowiring (so you can inject Drupal services into your command's
constructor), and lazy loading. This project was created to demonstrate a
proposal for a native Drupal console, so it is intentionally small in scope.

Dex Console is a **developer and deployment tool**. It runs only under the CLI —
there are no web routes, no permissions, and no configuration UI. Anyone who can
execute the binary runs Drupal with full site privileges, exactly like Drush, so
protect access to the binary the same way you protect Drush.

> **Important:** Do not enable Dex Console at the same time as the equivalent
> Drupal core console patch. The module deliberately refuses to load if the
> core `DexCompilerPass` class is present — use one or the other, never both.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and run your first command.

There is **no configuration page** — Dex Console is a CLI framework with no
settings form. Writing and running commands is covered in the module's
[`agent/drush/commands.md`](../agent/drush/commands.md) reference and the
project README.

## Where it lives in the admin menu

Dex Console adds no admin page. You interact with it entirely from the command
line via `vendor/bin/dex`.

## How to use it

- List every discovered command: `vendor/bin/dex` (or `vendor/bin/dex list`).
- Get help for one command: `vendor/bin/dex help <command>`.
- Run a command: `vendor/bin/dex mymodule:command [args] [--options]`.

To add your own command, create a class under your module's `src/Command/`
directory that extends `Symfony\Component\Console\Command\Command`, annotate it
with `#[AsCommand(name: 'mymodule:hello', description: '…')]`, then clear the
cache (`drush cr`) so the container re-scans for it.
