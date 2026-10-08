# jQuery UI (jq_ui) — manual setup guide

**jQuery UI** (`jq_ui`) provides the **jQuery UI asset library** to modules and
themes that still depend on it. Drupal core removed jQuery UI as a bundled API, and
this module fills that gap — it's a **drop‑in replacement for the older `jquery_ui`
module**, achieved through Composer's `replace` directive plus a repaired copy of the
library. It also bundles an important localization fix and a newer version of the
jQuery UI library than the module it forks from.

It's a utility module: on its own it does nothing visible. Its job is to make the
jQuery UI asset libraries (Accordion, Autocomplete, Datepicker, Dialog, Draggable,
Effects, Slider, Tooltip, and the rest) available so that other code can attach
them. A notable use case is the **jQuery UI datepicker**, whose language follows the
page/CMS language rather than the browser or OS — which matters for bilingual and
official‑language compliance where native HTML5 date inputs fall short.

A word of caution: **jQuery UI is no longer actively maintained upstream.** Use this
module for **legacy compatibility** with code that still needs jQuery UI, and prefer
modern alternatives for anything new.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (including replacing the old `jquery_ui` module).

This module has **no configuration page** — it provides asset libraries only, with
nothing to configure. Modules and themes attach the libraries they need in their own
code.

## Where it lives in the admin menu

jq_ui adds no admin page. It simply makes the jQuery UI asset libraries available for
other modules and themes to attach.
