# Config Merge — manual setup guide

**Config Merge** (`config_merge`) solves a specific configuration-management
headache: how do you accept a new version of configuration shipped by a module or
distribution *without* throwing away the tweaks your own site has made to that
same configuration?

The usual choices are blunt — either overwrite (and lose your customizations) or
skip (and never get the upstream improvements). Config Merge offers a third,
smarter option: a **git-style three-way merge**. It looks at three versions of a
configuration item — the last snapshot the extension provided (`previous`), the
new version it now provides (`current`), and what is actually in your site's
active configuration (`active`, possibly customized) — and reconciles them item
by item. Where you never touched a value, it takes the upstream change; where you
customized a value, it keeps yours. Every decision is recorded in a log so you
can audit exactly what was updated, ignored, or substituted.

At heart this is a developer library. The work is done by a single stateless
helper class whose merge method returns the reconciled configuration, plus an
event other modules can subscribe to after a merge runs. The parent module has
**no admin page, no settings, no permissions, and no Drush commands** — you
either call it from code (for example an update hook during a deployment) or you
let another module drive it.

The bundled **Config Merge Filter** submodule (`config_merge_filter`) is what
makes it useful without writing code: it plugs the merger into the
[Config Filter](https://www.drupal.org/project/config_filter) pipeline so that
configuration imports automatically merge with your active configuration instead
of overwriting it.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent — including the `ConfigMerger` class, its merge rules, the
log format, and the post-merge event — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and decide whether you need the Config Merge Filter submodule.

## Where it lives in the admin menu

Nowhere — there is no menu item and no settings page. Config Merge is a library
and an event, consumed in code. If you enable the **Config Merge Filter**
submodule, it participates automatically in the Config Filter import pipeline;
there is still no dedicated configuration form for it.

## How to use it

There are two ways to put Config Merge to work:

- **Automatically, during config import.** Enable the **Config Merge Filter**
  submodule (see [Installation](installation/index.md)). With Config Filter in
  place, configuration imports will merge incoming changes against your active
  configuration rather than clobbering your customizations.
- **From code.** Call
  `\Drupal\config_merge\ConfigMerger::mergeConfigItemStates($previous, $current, $active)`
  to get the merged result, and read `ConfigMerger::getLogs()` to see which
  properties were updated, ignored, or substituted. Other modules can subscribe
  to the post-merge event to react once a merge completes. The exact method
  signatures, merge rules, and event details are in the
  [`agent/`](../agent/start.md) references.
