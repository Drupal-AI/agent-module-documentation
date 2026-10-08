# Diboo signature pad — manual setup guide

**Diboo signature pad** (`diboo_signature_pad`) is an add-on for the **Diboo core**
module that provides a drawing tool for the Diboo game. It configures a
signature-pad widget so contributors can draw a picture — a chain link's image
contribution — directly on a canvas in the browser. It is the first Diboo module
that enables drawing.

The module glues the third-party **Signature Pad** module into the Diboo
ecosystem: when it's enabled, image chain links automatically use the signature
pad widget for drawing. It depends on both **Diboo core** and the **Signature
Pad** module, and supports Drupal 10 and 11.

There is nothing to configure — once the module is enabled, image chain links use
the signature pad widget automatically. (The maintainers note that in future this
module may become optional as more drawing tools are added.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it, along with its dependencies.

There is **no configuration page** for this module — image chain links use the
signature pad widget as soon as the module is enabled.

## Where it lives in the admin menu

Diboo signature pad adds no settings page. Its effect appears wherever a Diboo
image chain link is drawn: the signature pad widget is used automatically.
