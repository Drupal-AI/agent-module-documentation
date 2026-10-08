# Configuration Update Base — manual setup guide

**Configuration Update Base** (`config_update`) is an **API-only** module that
compares a site's *active* configuration against the *default* configuration a
module, theme, or install profile originally shipped — and can revert or
re-import individual config items. It provides no end-user interface itself; it is
the engine that the **Configuration Update Reports** submodule and other projects
(such as Features) build their user-facing tools on top of.

Drupal core can import a whole configuration set at once, but it has no built-in
way to compare a *single* config item against the default a module provided, nor
to revert just that one item. Configuration Update Base fills that gap with three
reusable services: a **config lister** that enumerates config types and tells you
which extension provides each item, a **config differ** that normalizes and diffs
two config arrays, and a **config reverter** that reads the shipped defaults from
an extension's `config/install` and `config/optional` storage and writes them back
into active storage. The reverter distinguishes *import* (bring in a config item
that's currently missing) from *revert* (overwrite an existing item with the
shipped default), and it dispatches events so other code can react to or alter
each operation.

Everything works on **base configuration only** — without `settings.php`
overrides or translations. Because it depends on nothing but core's Configuration
Manager (`config`), it's safe and lightweight for other contrib modules to depend
on. If you want an actual UI — screens that list changed config and give you
"revert to default" buttons — enable the bundled **`config_update_ui`** submodule,
which builds exactly that on top of these services.

This guide is written for a **human**. Note that because this is a developer API
module, most of the day-to-day value comes from the submodule (or from Features).
If you want terse, token-cheap references for an AI coding agent — including how to
call the lister, differ, and reverter services in code — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and turn on the reports submodule if you want a UI.

## Where it lives in the admin menu

The base module adds **no menu items and no settings page** — it exposes services
for other code to call, nothing to click. The user-facing part comes from the
**Configuration Update Reports** submodule (`config_update_ui`): once enabled, it
adds configuration-report and revert screens under **Configuration →
Development**, where you can see which config items differ from their shipped
defaults and revert or import them individually. See
[Installation](installation/index.md) for enabling it.
