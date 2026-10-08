# Chosen — manual setup guide

**Chosen** (`chosen`) applies the [Chosen](https://harvesthq.github.io/chosen/)
jQuery library to Drupal's HTML `<select>` boxes, turning long dropdowns and
multi-value lists into searchable, user-friendly widgets. Instead of scrolling a
native list of hundreds of options, your editors and visitors get a type-to-search
box, placeholder text like *"Choose an option"*, and — on multi-selects —
removable, tag-style choices. Chosen works site-wide: once enabled, it attaches
automatically to any `<select>` element that matches a configurable jQuery
selector and has at least the minimum number of options you set.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module and its JavaScript
library to tuning exactly which selects get enhanced. If you are looking for terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Chosen settings page under Configuration → User interface](images/settings.png)

## Where it lives in the admin menu

Everything in this guide sits under a single settings page:
**Configuration → User interface → Chosen**
(`/admin/config/user-interface/chosen`). There are no per-page or per-form screens
to visit — one form controls Chosen's behavior across the whole site.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and obtain the Chosen JavaScript library.
2. [Configuration](configuration/index.md) — set the option thresholds, search
   behavior, widget width, target selectors, and where Chosen runs.
