<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cansvas Fingerprint

## What it is / when to use

- Bundles a browser canvas-fingerprinting JS library (FingerprintJS-style) and a demo page showing the computed fingerprint.
- Use to experiment with client-side device/browser fingerprinting.
- Primarily a demo/utility rather than a production analytics pipeline.

---

## Install & configure

- Enable the module; it attaches the `canvas_fingerprint/lib` and `canvas_fingerprint/init` libraries.
- Visit `/fingerprint` (route `fingerprint.demo`, permission `access content`) to see the demo output.
- Fingerprint assets live under the module's `assets/` directory.

---

## Usage & API notes

- The only route is a demo controller (`PageDemo::page`) that renders placeholders (`#fingerprint`, `#fingerimage`, `#fingerdata`) and attaches the JS.
- Fingerprint computation happens entirely client-side in the browser via the attached library.
- There is NO server-side controller/endpoint that receives or stores the fingerprint — no PII is persisted by the module.
- The demo links to external reference pages (browserleaks, FingerprintJS, a research PDF) as documentation.
- No configuration form or settings object is provided.
- No permissions are declared beyond the route's `access content`.
- To actually collect fingerprints you would add your own JS/endpoint — the module ships only the demo.
- Canvas fingerprinting is a privacy-sensitive technique; using it may carry GDPR/consent obligations.
- The library can be reused by attaching `canvas_fingerprint/lib` in your own render arrays.
- No external network calls are made from the server side.
- The controller returns a render array (`colors` + `simple` markup with attached library).
- Nothing is written to the database.
- Package classification is "Stat".
- Consider consent gating before deploying tracking based on this library.
- Suitable for demos, research, or as a starting point for custom fingerprint collection.
- No cron, queue, or webhook behaviour.
