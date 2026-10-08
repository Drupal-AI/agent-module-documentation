# R — manual setup guide

**R** (`r`) is a text‑format filter that runs **R** statistical code embedded in your
content and inserts the resulting output — text and plots — into the rendered page.
Wrap R code in `[R]…[/R]` brackets in a node or block body, and when the page is
displayed the filter executes that code with the R interpreter on your server and
shows the results inline.

It is aimed at web publishers and bloggers who write instructional R material or
discuss statistical literature using R. To keep things fast, output is **cached**, so
the same code block is never executed twice. Displaying output requires that R be
installed on the server and that the module know the path to the local R binary.

> **Security — read this before enabling.** Executing R code on your server is
> inherently powerful. Anyone who can write in a text format that has this filter
> enabled can run R code on your server. Enable the filter **only** on text formats
> restricted to trusted roles, and **never** on a format available to untrusted or
> anonymous users. Grant filter access with care.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

This module has **no dedicated settings section** of its own — you set it up through
Drupal's Text formats and editors screen, as described below.

## How to use it

1. Install R itself on the server (the operating‑system package, not this module),
   and note the full path to the `R`/`Rscript` binary.
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a format that only **trusted** roles
   can use.
3. Enable the R filter for that format, and set the **path to the local R binary**
   in the filter's settings — output cannot be displayed until this path is correct.
4. In content using that format, wrap R code in `[R]…[/R]`. When the page renders,
   the code runs and its output (text or a plot) is embedded in place. The result is
   cached so the same block is not run again.
