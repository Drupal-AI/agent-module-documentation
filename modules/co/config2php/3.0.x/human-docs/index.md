# Config2PHP — manual setup guide

**Config2PHP** (`config2php`) is a developer utility that exports a piece of
Drupal configuration as **PHP code**. Drupal core can export configuration, but
only as YAML — which you then have to translate by hand before you can use it in
PHP, for example inside an `hook_install()` or `hook_update_N()` update hook.
Config2PHP does that translation for you: pick a configuration type and a specific
element, and it generates a properly formatted PHP associative array that is ready
to paste into code.

It handles the fiddly formatting details automatically — wrapping array keys,
turning YAML colons into PHP `=>` arrows, adding trailing commas, and so on — so
the output drops straight into a module. It depends on core's **Configuration**
module and provides its own permission that gates the export interface.

A security note worth keeping in mind: exported PHP can contain **configuration
values that are secrets** (API keys, tokens, credentials) if they happen to live
in the config you export. Review and redact anything sensitive before pasting or
committing it — never hard-code secrets into module code. Keep the export
interface restricted to developers. The module has no content or access-control
role beyond its permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where things live

- **Export tool** — a **Single item to PHP** tab on the core single-export page,
  at *Administration → Configuration → Development → Configuration synchronization
  → Export → Single item to PHP*. This is where you pick a config item and copy
  its PHP array. It is gated by the core *Export configuration* permission.
- **Settings** — *Administration → Configuration → Development → Config Export to
  PHP array* (gated by the *Administer Config Export to PHP array* permission).
  Two options: **Replace the default tab** (when enabled, the core **Export**
  menu link/tab opens this module's PHP export page instead of the YAML archive
  page) and **Excluded keys** (one key per line; these top-level configuration
  keys are stripped from the generated output — defaults: `_core`,
  `dependencies`, `langcode`, `status`, `uuid`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)) and grant its
   export permission to trusted developers.
2. Open the **Single item to PHP** tab (see above) as a user who holds the
   *Export configuration* permission.
3. **Select the configuration type** and then the **specific element** you want.
4. Config2PHP generates the equivalent PHP array. Copy it into your install/update
   hook or module code.
5. **Review the output for secrets** (API keys, passwords, tokens) and redact them
   before committing — reference secrets from environment variables or a Key
   entity instead.
