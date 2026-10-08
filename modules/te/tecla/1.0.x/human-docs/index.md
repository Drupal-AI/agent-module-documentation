# Tecla — manual setup guide

**Tecla** — *Test Classmap Cleanup for PHPUnit Tests* (`tecla`) — is a small
developer/testing helper that makes your PHPUnit runs behave more like production.
When Drupal discovers tests, it registers PSR‑4 class‑map entries for **all**
extensions it finds, including modules that are disabled or uninstalled. That means
a class from a module that is switched off can still be autoloaded during a test —
which can quietly hide autoloading bugs and let a test pass when it should not.

Tecla fixes that. Through a service provider that runs while the container is being
built, it reflects into the kernel's class loader and removes any
`Drupal\<module>\` PSR‑4 prefix whose module is not actually installed, while
keeping core's own namespaces (`Drupal\Core\`, `Drupal\Driver\`,
`Drupal\Component\`). The result is a test class loader that only knows about the
modules that are really enabled, so your kernel and functional tests exercise more
realistic autoloading. It uses reflection, which carries a small performance cost,
but the payoff is catching "this class shouldn't be loadable here" problems.

The module is strictly **test‑only and self‑defending**: it throws a
`LogicException` if it detects it is running outside a valid test environment, so
it cannot run on a live site. It has **no configuration, routes, permissions, or
services** beyond that one service provider — you install it, enable it in your
test setup, and there is nothing to configure. It supports Drupal 9, 10 and 11.

This guide is written for a **human** developer. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install as a dev dependency and enable
   it for tests.

## How to use it

There is nothing to configure. Install Tecla as a development dependency and enable
it in the module set your tests run with (for example in your test site profile or
CI test setup). From then on, kernel and functional tests run with the disabled
modules' PSR‑4 mappings stripped out, giving you more realistic autoloading — handy
for surfacing class‑availability bugs, reproducing production scoping in kernel
tests, and diagnosing tests that behave differently under Drush versus CI. Because
it refuses to run outside a test user‑agent, there is no risk of it affecting a
live site.
