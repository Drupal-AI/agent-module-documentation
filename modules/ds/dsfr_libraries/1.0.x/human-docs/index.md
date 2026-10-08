# DSFR libraries — manual setup guide

**DSFR libraries** (`dsfr_libraries`) makes the assets of the DSFR — *Système de
Design de l'État français*, the French State Design System — available to Drupal
as attachable **asset libraries**. The DSFR distribution ships as built CSS/JS
(a `core` bundle, a `utility` bundle, and one folder per UI component); this
module declares all of them as Drupal libraries so your theme and modules can
attach them by name, without hand‑writing a `*.libraries.yml` entry for every
component.

It works in two parts. A static declaration provides the **core** library
(`core.min.css` plus the module/nomodule JS variants) and a **utility** CSS
library. Then, at runtime, the module scans the DSFR distribution's
`component/*` folders and **automatically registers one library per component**
(attaching that component's minified CSS and JS variants and depending on
`dsfr_libraries/core`). Add a new component folder to the distribution and its
library appears automatically.

This is a **developer‑oriented** module: it has no routes, permissions, services,
blocks, or configuration — it only declares libraries. You attach them from a
render array or as a dependency of your own library, for example:

```php
$build['#attached']['library'][] = 'dsfr_libraries/core';
$build['#attached']['library'][] = 'dsfr_libraries/button';
```

```yaml
# my_theme.libraries.yml
my-component:
  dependencies:
    - dsfr_libraries/checkbox
```

One requirement stands out: the module does **not bundle the DSFR itself**. You
must place the DSFR distribution at `web/libraries/dsfr/` separately (see
[Installation](installation/index.md)). If it is missing, the module's
`hook_requirements()` reports an error on the status report. Note the module is
marked *Minimally maintained*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the DSFR distribution into
   `libraries/`, then install and enable this module.

There is **no configuration page** for this module — it only declares asset
libraries for you to attach from your theme or modules.

## Where it lives in the admin menu

DSFR libraries adds no admin page. You use it entirely from code: attach its
libraries (for example `dsfr_libraries/core`, `dsfr_libraries/button`) from your
theme's or module's render arrays and `*.libraries.yml` dependencies. The one
place it surfaces in the UI is the **status report** (`/admin/reports/status`),
which flags a missing `libraries/dsfr/` install.
