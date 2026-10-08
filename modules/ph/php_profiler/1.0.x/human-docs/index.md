# PHP Profiler — manual setup guide

**PHP Profiler** (`php_profiler`) profiles your Drupal site with **XHProf** and
uploads the results to an **XHGui** instance, where you can browse call graphs,
timings and memory use to find performance bottlenecks. Concretely, it adds an
"XHGui Upload" storage backend to the [XHProf](https://www.drupal.org/project/xhprof)
module (using the `perftools/php-profiler` package under the hood), so profiling
data captured for a request is sent to XHGui for analysis.

This is a **development and diagnostics** tool, not a production feature. Profiling
data is detailed and potentially sensitive — it can reveal code paths and, depending
on configuration, arguments and queries — and it is sent over the network to your
XHGui server. Profiling also adds runtime overhead. So keep it to
**non‑production/development environments**, point it at a **trusted,
access‑controlled** XHGui instance, gate its permission to developers, and disable it
in production. It depends on the XHProf module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with its XHProf dependency).

There is **no dedicated settings page of its own** — you configure it from the
XHProf configuration form, described in "How to use it" below.

## How to use it

1. Install and enable this module and the XHProf module (see
   [Installation](installation/index.md)).
2. Stand up an XHGui instance to receive the data. You can use the official Docker
   image (`xhgui/xhgui`) or run your own — make sure it is on a trusted, private,
   access‑controlled host.
3. Open the **XHProf configuration form** in Drupal and select **XHGui Upload** as
   the storage option.
4. Set the **base URL** of your XHGui instance. Do **not** include the
   `/run/import` path — the module appends that automatically.
5. Save. Profiling data captured by XHProf is now uploaded to XHGui for you to
   analyse there.

> **Keep it dev‑only.** Because profiling captures sensitive runtime detail, sends
> it off‑box, and adds overhead, disable this in production and never send profiling
> data to an untrusted host.
