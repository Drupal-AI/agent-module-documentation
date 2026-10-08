# Search kint — manual setup guide

**Search kint** (`search_kint`) adds a search box to **Kint's** variable dumps, so
finding one key inside a Drupal render array or a loaded entity stops meaning
scrolling through thousands of collapsed nodes. It is a small developer
convenience built on top of Devel's `kint()` output, heavily based on the older
`search_krumo` module.

Devel's `kint()` is the standard way to inspect a variable in Drupal, and it works
well until the variable is a render array or a loaded node — structures nested
dozens of levels deep with hundreds of keys, where the thing you want is somewhere
inside and Kint's collapsed tree gives you no way to find it except expanding
branches one at a time. This module adds the missing search: it filters the dump
as you type, and — its genuinely useful half — it shows the **path to a match**.
Knowing that a key exists matters less than knowing how to reach it in code, and
it can copy that path for you; when the path points at a field attached to an
entity, it even returns the getter code, for example
`$account->get('field_first_name')->value;`.

It is otherwise four small files (JavaScript and CSS) with **no routes,
permissions, or configuration** — it works as soon as it is enabled. It depends on
**Devel** (`^5.1`) and the **kint-php/kint** library (`^5.0 | ^6.0`), and requires
**Drupal 10 or 11**. Note the release is a beta (2.0.0-beta2).

Because it is a companion to Devel, this is a **development-only** module. Devel
itself should not be enabled in production, and Search kint inherits that
restriction entirely — enable it only in your local or development environment.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   pull in Devel and Kint, and enable it in a development environment.

## How to use it

There is nothing to configure. With the module enabled in a development
environment, use Devel's `kint()` to dump a variable as you normally would — a
search box appears above the dump. Type to filter, and follow the match trail to
copy the path (or the entity getter code) to the value you are after.
