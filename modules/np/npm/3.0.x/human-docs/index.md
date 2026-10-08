# Node Package Manager — manual setup guide

**Node Package Manager** (`npm`) provides tools to interact with **npm** from
within Drupal — requiring npm packages, running npm scripts, and similar actions
— for build and tooling workflows, such as compiling front‑end assets. It is a
**developer module** in the *Javascript* package: it exposes a service and a
plugin type for other code to use, and does nothing on its own.

The way it works is through an executable plugin: a plugin manager
(`plugin.manager.npm_executable`) returns the first available executable, and
custom code calls it to run npm actions. At present **Yarn** is the only supported
executable, though others can be added by implementing additional
`NpmExecutable` plugins (each plugin has a weight for priority and an
`isAvailable()` check).

> **Important — this is a dangerous capability by design.** Requiring a package
> or running a script invokes npm **on the server**, which is effectively **code
> execution**: npm package installs run arbitrary third‑party install/build
> scripts as the web or CLI user. Anyone who can trigger these actions can
> effectively run code on your server. Treat this strictly as a
> **development/build‑time tool**: restrict its actions to trusted administrators
> or CLI use only, **never expose npm actions to untrusted users**, and be very
> cautious about running it on a production server. It has no content‑access role,
> but its capability is severe — use it only in controlled build contexts.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no configuration form** in the admin UI (`configure` is null).
It is used from code, so setup is limited to installation plus making sure a
supported executable (Yarn) is available on the server.

## How to use it

With the module enabled and Yarn installed on the server, custom code obtains the
executable and runs npm actions through it:

```php
/** @var \Drupal\npm\Plugin\NpmExecutableInterface $npmExecutable */
$npmExecutable = \Drupal::service('plugin.manager.npm_executable')->getExecutable();
```

Keep in mind the security note above: these actions run real commands on the
server, so only trusted, controlled callers should ever reach this code.
