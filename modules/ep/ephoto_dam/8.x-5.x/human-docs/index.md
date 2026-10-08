# Ephoto DAM — manual setup guide

**Ephoto DAM** (`ephoto_dam`) connects Drupal to
[Ephoto Dam](https://www.drupal.org/project/ephoto_dam), a digital‑asset‑management
platform that centralises an organisation's media — images, videos, and documents —
in one place. With the module installed, editors can search for and use
Ephoto‑hosted assets directly inside Drupal content, including through a **CKEditor
5** integration, so the media library your communications team maintains in Ephoto
becomes reachable from the editor.

A companion submodule, **Ephoto DAM Field** (`ephoto_dam_field`), adds a field type
so you can attach Ephoto assets to entities as structured field data rather than
only embedding them in body text.

Two things shape how you set it up. First, the only Drupal-side setting is the
**URL of your Ephoto server** — there is no API key or secret to enter in Drupal;
the sign-in with Ephoto happens in the editor's browser against that server.
Second, assets are **hosted and served by Ephoto** (a third party): Drupal
references them rather than necessarily copying them locally, so availability and
delivery depend on Ephoto, and asset requests involve that external service.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and add the field submodule if you need it.
2. [Configuration](configuration/index.md) — setting the Ephoto DAM Server URL,
   plus the CKEditor 5 and egress notes.

## Where it lives in the admin menu

Ephoto DAM is configured under **Configuration**, where you enter the **Server URL**
of your Ephoto DAM software. To let editors
insert assets while writing, you enable the Ephoto DAM button on a text format's
**CKEditor 5** toolbar at **Configuration → Content authoring → Text formats and
editors**. If you enable the field submodule, the Ephoto DAM field type becomes
available when adding fields at **Structure → Content types → *(type)* → Manage
fields**.
