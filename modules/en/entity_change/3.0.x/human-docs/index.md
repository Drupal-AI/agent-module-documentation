# Entity Change — manual setup guide

**Entity Change** (`entity_change`) provides a **plugin framework for detecting
changes on content entities**. It gives other modules a common API for asking, when
a content entity is saved, whether some specific aspect of it has changed — and to
react accordingly. The comparison is possible because content entities carry their
"original" version through the update hooks, letting a plugin compare fields in an
arbitrary way.

Importantly, **this module does nothing on its own.** It is a developer/framework
module: it ships the plugin system plus example node-change plugins, and other
modules build change-tracking or notification features on top of it. The plugins
work only on **content** entities (nodes, terms, users, and so on), because those
are the entities that have an original attached during an update. Each plugin
declares precisely which entity types it deals with.

There is nothing to configure through the UI. You install it as a dependency of a
module that uses the framework, or as a base for your own change-detection plugins.
It requires **Drupal 10 or 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — this is a framework module with no settings
form and no admin UI of its own.

## Where it lives

Entity Change adds no admin menu item. It is a developer framework: its value is the
plugin API and the example plugins it provides for other code to build on.

## How to use it

- If you are installing a module that lists Entity Change as a dependency, simply
  enable it (Composer/Drush will usually handle this for you).
- If you are a developer, study the example node-change plugins that ship with the
  module, then write your own change plugin declaring the entity types it handles and
  the comparison logic it performs.
