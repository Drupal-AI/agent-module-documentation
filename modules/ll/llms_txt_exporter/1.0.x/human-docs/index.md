# LLMs txt Exporter — manual setup guide

**LLMs txt Exporter** (`llms_txt_exporter`) generates a dynamic `llms.txt` file
that gives large language models a structured summary of your site — its name, URL,
description, and recent content — so tools like ChatGPT and Bard can better
understand your structure and topics. Unlike AI‑powered generators, this one takes
the straightforward "exporter" approach: it derives the file directly from your
content, with **no AI** involved.

It exposes a `/llms.txt` endpoint whose plain‑text summary is built from your site's
name and URL, a description (from Metatag or your site slogan), and recent items
from the content types you select. You decide which content types to include and how
many recent items to show per type, and you can add custom keywords and extra
information for LLMs. It integrates with the Metatag module for richer metadata.

Because the resulting file is **published for LLM crawlers** and lists your content,
include only content you intend to be publicly discoverable, and review what gets
exposed. The module plays no access‑control role beyond its own permission.

It targets Drupal 9, 10, and 11, and works best alongside the Metatag module
(required for site metadata) and, optionally, Pathauto for cleaner URLs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose content types, set item counts,
   and add keywords and extra info.

## Where it lives in the admin menu

The settings live at **Configuration → LLMs.txt Exporter Settings**
(`/admin/config/llms-txt-exporter`). After configuring, the generated file is served
at `yoursite.com/llms.txt`.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. At `/admin/config/llms-txt-exporter`, select the content types to include, set
   the number of recent items per type, and optionally add keywords and extra
   information.
3. Save, then visit `/llms.txt` to see the generated file.
