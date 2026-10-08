# Paragraph Instances — manual setup guide

**Paragraph Instances** (`paragraph_instances`) answers a question that Drupal
doesn't answer on its own: *"Where is this paragraph type actually used?"* It finds
and lists every place a given paragraph type appears across all your nodes, so
before you change or remove a paragraph type you can see exactly which content would
be affected.

That makes it an auditing and planning tool. If you are about to restructure your
component library — renaming a paragraph type, retiring one, or reworking its
fields — Paragraph Instances lets you see the footprint first, so you don't discover
after the fact that the type you deleted was still in use on dozens of pages.

It is purely informational: it reads content to build the usage report and surfaces
what the viewer is entitled to see. It has **no access‑control role** — it doesn't
change who can view or edit anything — and it provides its own permission so you can
decide who is allowed to run the report. Note that this module is marked *Minimally
maintained* (maintenance fixes only).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant its permission.

There is **no settings form** for this module — it is a report you run, not a
feature you configure.

## Where it lives in the admin menu

Paragraph Instances adds a usage report rather than a settings page. Grant its
permission (see [Installation](installation/index.md)) and open the report as an
administrator to look up where a paragraph type is used.

## How to use it

1. Install and enable the module, and grant its permission to the roles that should
   be able to run the report (see [Installation](installation/index.md)).
2. Open the report and choose the paragraph type you're interested in.
3. Review the list of nodes that use that type before you change or remove it — this
   is your impact assessment.
