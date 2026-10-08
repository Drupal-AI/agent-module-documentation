# CL Devel — manual setup guide

**CL Devel** (`cl_devel`) is a **development helper for people building components**
— Single Directory Components (SDC) and the wider `cl_*` component family. Its main
feature is **audit pages** that surface what the component system actually sees for
each component: which files and features a component uses, its schema, and how it
resolves. That turns a frustrating guessing game into something you can read.

Component development has a feedback-loop problem: a component is defined in YAML
with a schema, rendered by a Twig template, and consumed somewhere else — so when
it does not appear, the cause could be in any of the three. CL Devel exists to make
that visible. It has no other module dependencies.

**This is a development module — keep it out of production.** Like other dev tools
(for example Devel or `ckeditor5_dev`), it exposes internals that should not be
enabled on a live site, and it is exactly the sort of module a production audit
should flag. Enable it locally while you work, and disable it before you deploy.

One planning note: the component tooling landscape has moved quickly, and core SDC
has absorbed much of what the `cl_*` family and UI Patterns were originally built
for. Pick the version to match your component solution — use **1.x** with CL
Components, and **2.x** (this line) with SDC, including core SDC. Decide which
component layer you are actually building on before adding tools around it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (locally).

There is **no configuration page** for this module — it has no settings form. You
use it entirely through its audit pages, described below.

## Where it lives in the admin menu

CL Devel has no settings form. It provides **audit pages** that report on your
components (files, features, and schema each component uses) so you can debug why a
component is or is not rendering. Browse to a component's audit page to inspect what
the component system resolves for it. Because this is a development aid, restrict
its use to local and staging environments.
