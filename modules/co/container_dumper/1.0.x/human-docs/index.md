# Container Dumper — manual setup guide

**Container Dumper** (`container_dumper`) is a **developer tool** that writes
Drupal's compiled Symfony **service container** to an XML file after each cache
rebuild. Static analysers and IDEs can then read that file to understand which
services your site defines, their classes, and their arguments — which helps tools
like PHPStan or Psalm resolve Drupal's dependency‑injection types that they
otherwise can't see. It depends only on core's System module.

Under the hood it registers a compiler pass that runs during container compilation.
When you've set a dump path, the pass serialises the container with Symfony's
`XmlDumper` and writes it to that path (creating the directory if needed). Because
this happens at compile time — that is, on a cache rebuild — there is **no
per‑request overhead**. If no path is configured, nothing is written at all, so the
module is inert until you point it somewhere.

One important safety note: the dumped XML describes your **entire service
container**, which can reveal internal structure you would not want exposed. The
dump path you choose is relative to the Drupal root, so **always point it at a
location that is not web‑accessible** (a private/analysis directory outside the
webroot). Treat this as a developer / CI tool — **it is not for production** with a
web‑reachable dump path. The only route it adds is a permission‑gated settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the (non‑public) dump path.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Container Dumper**
(`/admin/config/development/container-dumper`), behind the **"administer container
dumper settings"** permission.
