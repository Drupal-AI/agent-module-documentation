# Synlang — manual setup guide

**Synlang** (`synlang`) is a small language-related field and utility module from
the Synatix module family. It provides language-oriented field functionality along
with a set of Drush commands, and it builds on Drupal core's Field module.

Because Synlang is a vendor/utility module, its behaviour is specific to the context
it was built for rather than being a general-purpose end-user feature. The public
documentation is minimal, so exactly what the field does and what the Drush commands
cover is best confirmed against the module in your own environment. It has no
documented access-control role. There are no submodules, and core Field is the only
listed dependency.

This guide is written for a **human** setting the module up through the admin UI and
command line. If you are an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Synlang does not register an admin settings page (its `configure` route is null).
It surfaces as a language-related field you can add where the Synatix functionality
is needed, plus Drush commands you run from the command line — run `drush list`
after enabling to see the commands it registers. Since the module is
lightly documented publicly, review its actual behaviour in your own context before
relying on it.
