# Importer — manual setup guide

**Importer** (`importer`) is a framework for turning uploaded files into Drupal
content through configurable **extract / transform / save** pipelines. A content
editor provides a file — a PDF, for example — and the pipeline extracts its
content, transforms it into the shape your site needs, and saves it as a node (with
paragraphs), leaving the editor a draft they can refine. The idea is to spare
editors a lot of copy‑and‑paste and tedious formatting.

It is aimed at **one‑off imports by content editors** throughout a site's
lifecycle, not at large automated migrations — for those, Drupal's Migrate system
is the right tool. Importer was spun out of the LocalGov Publications Importer
project, which imports HTML publications into LocalGov Drupal sites, and it
generalizes that pipeline idea so other modules can build their own import types on
top of it. Each pipeline is made of pluggable extract, transform, and save steps.

Because Importer is a **framework**, most of the real work happens in code and
configuration provided by the modules that build on it, or by pipelines you define
for your site. It depends on core's Node and Views modules and on the Paragraphs
module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its dependencies.

This module is a framework and does not ship a single central settings form of its
own; import pipelines are defined by the modules that build on Importer. There is no
standalone configuration page to document here.

## Where it lives in the admin menu

Importer provides its own permissions and integrates with Views, so import
pipelines and their results appear where the building modules place them (typically
under **Content** or a dedicated import screen). Enabling Importer by itself adds
the framework; the visible import UI comes from the pipeline definitions you or a
building module supply.
