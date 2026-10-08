# CKEditor 5 Word Count — manual setup guide

**CKEditor 5 Word Count** (`ckeditor5_wordcount`) shows a live word and character
count below CKEditor 5 text areas as an editor types, with optional configurable
limits and visual warnings. It is aimed at content workflows that need length
control — blog posts with a target word count, news headlines and teasers with
character caps, or templates that must stay a consistent length.

The counter appears automatically below any CKEditor 5 field once the module is
enabled — there is no toolbar button to add. It supports separate word *and*
character limits, and gives smart visual feedback: the editor background turns
yellow as a count approaches its limit (a configurable warning threshold) and red
once it is exceeded. The system is non-blocking — editors can go over a limit but
get a clear warning — and counting is Unicode-aware for accurate results with
international content. Settings changes take effect immediately, without a full
cache clear.

It depends only on core's CKEditor 5 and needs PHP 8.0 or newer. The module has a
small global settings form where you set the limits and the warning threshold —
see [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the word/character limits and
   warning threshold.

## Where it lives in the admin menu

The settings form sits at **Configuration → Content authoring → CKEditor 5 Word
Count Settings** (`/admin/config/content/ckeditor5-wordcount`). The counter
itself needs no per-field setup — it appears automatically below CKEditor 5
editors once the module is enabled.
