# Dialog Native — manual setup guide

**Dialog Native** (`dialog_native`) modernizes Drupal's modal and dialog system by
providing a new `dialogNative` JavaScript library that uses the browser's native
HTML `<dialog>` element instead of the jQuery UI based `dialog.js` that Drupal
core has traditionally shipped. The goal is a lighter, more standards-based dialog
system with the jQuery UI Dialog dependency removed.

To ease the transition, the module also implements a `dialogAdapter` library that
bridges existing `Drupal.dialog()` calls onto the new native implementation, so
current dialogs keep working while the ecosystem moves over. Drupal's Dialog /
Modal API and AJAX dialog boxes remain available — this module simply changes what
renders them under the hood.

This is a frontend/JavaScript enhancement with no content, blocks, or admin
settings to manage. It supports Drupal 10 and 11.

> **Work in progress:** The maintainers describe this module as heavy WIP and not
> yet production-ready. It exists partly to push the effort to get the native
> `<dialog>` element into Drupal core. Evaluate it carefully before using it on a
> production site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it provides JavaScript
libraries rather than a settings form. Enabling it (and the adapter) is all the
setup there is.

## Where it lives in the admin menu

Dialog Native adds no admin page. It works at the JavaScript-library level: once
enabled, its `dialogNative` and `dialogAdapter` libraries are available to Drupal's
dialog system.
