# Qtools Profiler v2 — manual setup guide

**Qtools Profiler v2** (`qtools_profiler`) is a **performance profiler** for Drupal
requests, aimed at developers who want to see performance data **on the same page
they are viewing**, in real time, instead of digging through logs or a separate
reporting back-office. It instruments both the main page request and any **AJAX
requests** made on the page, grouping results per request/call — which makes it
especially handy for profiling a specific AJAX call in a front-end app even on a
busy site. It also does its best to carry results across **redirects**, so after a
form submission you can still see the stats for the POST request on the page you
land on.

Out of the box it collects the essentials: request execution **time**, **memory**
consumption, and time spent on **database queries**. It is built around plugins, so
it can be extended to collect project-specific data, and it bundles support for
deeper PHP profiling via **Tideways xhprof** (recommended) and **Blackfire.io**
(only if you already use it) — those require you to install the corresponding PHP
extensions yourself. A bundled **Chrome extension** can output the information to
the browser's developer toolbar instead of the page, which is useful when you need
to profile on a live site without disturbing regular visitors.

The module also includes an auto-login/impersonation helper for profiling a given
user's experience. This reuses Drupal core's one-time-login hash validation (which
cannot be forged without the user's credentials and the site secret), so it is
**not** an authentication bypass. It depends on **Qtools Common** and supports
Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and its Qtools Common dependency, and (optionally) add a PHP profiling
   extension.

This module has **no standard settings form** in the admin UI — its configuration
steps are documented in the project's `README.md`, and the optional PHP profilers
are enabled by installing their PHP extensions (see Installation).

## How to use it

Once installed and enabled, browse your site as a developer: the profiler shows
timing, memory, and query stats for the page and its AJAX calls directly on the
page. For deeper PHP-level profiling, install the Tideways xhprof (recommended) or
Blackfire PHP extension. To profile without affecting the page layout — for example
on a live site — use the bundled Chrome extension to route the output to your
browser's developer toolbar.
