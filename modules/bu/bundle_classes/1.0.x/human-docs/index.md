# Bundle Classes — manual setup guide

**Bundle Classes** (`bundle_classes`) is an **example/reference module** for
developers. It demonstrates how to use Drupal's entity *bundle classes* — the
pattern where each bundle of an entity (for example each node content type) gets
its own PHP class — built on top of the
[BCA (Bundle Class Assistant)](https://www.drupal.org/project/bca) module.

It exists to teach the technique. The code is meant to be read and copied as a
starting point when you implement per-bundle entity classes in your own project.
It is **explicitly not intended for production use** — treat it as learning
material, not a feature you run on a live site.

Because it is a developer example, it has no content of its own, no admin
screens, and no access-control role. It depends on the `bca` module and runs on
Drupal 10.5+, 11.2+, and 12.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (on a development site).

## Where it lives in the admin menu

Nowhere — Bundle Classes adds no admin pages, settings, or menu items. Its value
is in its source code.

## How to use it

Install it on a **development or learning environment**, enable it, and read
through its source to see how per-bundle entity classes are declared and wired up
via the BCA module. Use what you learn to write your own bundle classes in your
project's custom code, then remove this example module. Do not leave it enabled on
a production site.
