# Bring Back jQuery.once() — manual setup guide

**Bring Back jQuery.once()** (`jquery_once`) restores the `core/jquery.once`
JavaScript library (and a bundled jQuery 3.7.1) that Drupal 10 removed. If you
have legacy JavaScript — in a theme, a contrib module, or your own custom
behaviours — that still calls `$(selector).once('id')`, that code broke when core
dropped `jquery.once` in favour of the newer, framework-agnostic `core/once`
(`Drupal.once`). This module puts the old library back so that legacy code keeps
working.

It is a bridge, not a replacement. It does **not** touch Drupal 10/11's modern
`core/once` API — both coexist on the same page — so the intended use is to keep
older code running while you migrate call sites from `$.fn.once()` to the modern
`once()` over time. Common reasons to reach for it include unblocking a Drupal 11
upgrade held up by an unmaintained module that still declares `core/jquery.once`,
buying time to port custom behaviours, or fixing a "`$(...).once is not a
function`" error that appears right after an upgrade.

The module is genuinely zero-configuration: **no settings form, no permissions,
no services and nothing to set up**. Installing it and clearing caches is the
whole process. When you have migrated every `$.fn.once()` call to the modern API,
you can simply uninstall it — there is no configuration to unwind.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — the module has no admin pages, settings or menu items. It works purely
by re-registering JavaScript libraries behind the scenes.

## How to use it

For most sites, there is nothing to do beyond enabling the module and clearing
caches (`drush cr`): the moment `core/jquery.once` exists again, any code that
declares it as a dependency starts working. The restored `$.fn.once()`,
`.findOnce()` and `.removeOnce()` methods behave exactly as they did in Drupal 9,
so a behaviour like this works again:

```js
(function ($, Drupal) {
  Drupal.behaviors.myLegacyThing = {
    attach(context) {
      $('.thing', context).once('my-legacy-thing').each(function () {
        // runs once per element
      });
    },
  };
})(jQuery, Drupal);
```

If you are writing or maintaining a library definition that needs the old API,
depend on **`core/jquery.once`** (preferred, since that is what existing legacy
code already declares) or on this module's own `jquery_once/jquery.once` — both
resolve to the same restored library.

### Confirming it is active

After enabling and clearing caches, you can verify the library reports the
restored version (2.2.3) from the command line:

```bash
drush php:eval '
  $o = \Drupal::service("library.discovery")->getLibraryByName("core", "jquery.once");
  print $o["version"] . "\n";'
# 2.2.3
```
