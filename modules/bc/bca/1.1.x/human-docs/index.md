# Bundle Class Annotations — manual setup guide

**Bundle Class Annotations** (`bca`) is a developer tool. It lets a Drupal
*bundle class* declare which bundle it serves with a PHP attribute written
directly on the class, instead of registering that association in a hook in a
`.module` file somewhere else.

A bit of background: since Drupal 9.3 you can give each bundle its own PHP class,
so — for example — an Article node can be an `Article` object with an
`Article::getByline()` method rather than a generic `Node`. Normally you tell
Drupal which class goes with which bundle inside
`hook_entity_bundle_info_alter()`, which means the link between the class and its
bundle lives far away from the class itself and is easy to forget when you add a
new bundle. This module flips that around: the class says what it is for with an
attribute, the module discovers those declarations, and it performs the
registration for you. Adding a bundle class becomes a single file, and deleting
that file removes its registration too.

This is about developer ergonomics, not new capability — once registered, the
bundle classes behave exactly as they would the old way. The payoff grows with
the number of bundles you have, where the hook-based registration otherwise
becomes a list nobody maintains. The module and the hook can coexist, so you can
convert an existing codebase one bundle at a time.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including which classes do the
discovery and registration — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Bundle Class Annotations has no routes, no permissions and no settings
page. It is a code-level facility used entirely from within your custom modules.

## How to use it

Once the module is enabled, add the module's attribute to a bundle class to
declare the entity type and bundle it serves, in place of registering it via
`hook_entity_bundle_info_alter()`. The module discovers the attribute and
registers the class automatically. Attributes require PHP 8.1, which is why the
module requires that version; an annotation form also exists for compatibility,
but attributes are the intended style on a modern codebase. See the
[`agent/`](../agent/start.md) docs for the exact class and attribute names.
