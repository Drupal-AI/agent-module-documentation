# Canvas Fingerprint — manual setup guide

**Canvas Fingerprint** (`canvas_fingerprint`) bundles a browser
canvas‑fingerprinting JavaScript library (the FingerprintJS style of technique)
together with a single demo page that shows the fingerprint your browser
produces. Its purpose is to let you experiment with client‑side device and
browser fingerprinting — it is a demo and starting point, not a finished
analytics or tracking pipeline.

Once enabled, the module adds one page at `/fingerprint`. That page renders a few
placeholders and attaches the module's JavaScript, which computes a fingerprint
entirely in your browser and displays it. There is no server‑side code that
receives, stores, or transmits the fingerprint: nothing is written to the
database, no external calls are made from the server, and no personal data is
persisted by the module itself. To actually collect fingerprints you would have
to add your own JavaScript and an endpoint — this module ships only the demo and
the reusable library.

Please treat this as a privacy‑sensitive tool. Canvas fingerprinting identifies
visitors' browsers without cookies, and deploying it to track real users may
carry consent and data‑protection obligations (for example under the GDPR).
Consider consent‑gating before you build anything on top of it.

This guide is written for a **human** clicking through the site. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Canvas Fingerprint adds no admin menu items and no settings form. Its only
visible surface is the demo page at `/fingerprint` (route `fingerprint.demo`),
which is available to any user with the **View published content** (`access
content`) permission.

## How to use it

Enable the module and visit `/fingerprint`. The page runs the bundled library in
your browser and shows the computed fingerprint (and a small canvas image used to
derive it), along with links to external reference material about the technique.

To reuse the library in your own code, attach the `canvas_fingerprint/lib`
library to a render array. Any collection or storage of the resulting fingerprint
is something you build yourself — the module does not do it for you.
