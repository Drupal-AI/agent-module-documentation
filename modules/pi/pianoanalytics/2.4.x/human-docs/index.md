# Piano Analytics — manual setup guide

**Piano Analytics** (`pianoanalytics`) integrates **AT Internet / Piano
Analytics** tracking with Drupal. Once configured, it adds Piano's analytics
tracker to your pages so page views and events are recorded in your Piano
Analytics account. It ships in the *Statistics* package, provides its own
permissions, and includes an optional **opt‑out block** (version 2.2+) so visitors
can decline tracking.

There are two ways it can send data. The main module loads **Piano's third‑party
JavaScript** tracker in the browser (client‑side tracking). The bundled
**Piano Analytics Server** submodule (`pianoanalytics_server`) instead sends
events **server‑side** to Piano's Collection API, which is more resilient to ad
blockers and lets other modules queue events. You can use either or both.

Because this module enables **visitor tracking** and shares data with a
third‑party service, treat it as a privacy‑sensitive integration: it is a GDPR /
consent consideration, so pair it with your consent‑management tooling and the
built‑in opt‑out block so tracking respects the visitor's choice. Any Piano API
credentials used for server‑side tracking are secrets and must be stored as such —
see [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) the server‑side submodule.
2. [Configuration](configuration/index.md) — enter your Piano Analytics site ID
   and collection settings, handle credentials for server‑side tracking, and
   place the opt‑out block.

## Where it lives in the admin menu

The Piano Analytics settings form is reached from the module's **Configure** link
on the **Extend** page (or under **Configuration**). See
[Configuration](configuration/index.md) for the field‑by‑field walk‑through.
