# IntelligenceBank DAM — manual setup guide

**IntelligenceBank DAM** (machine name `ib_dam`) is the bridge between the
**IntelligenceBank** digital asset management platform and Drupal. With it,
editors can browse the assets held in your organisation's IntelligenceBank DAM and
use them directly in Drupal — pulling approved images and files into content
without re‑uploading them by hand.

There are two ways to bring an asset in: you can **create a local copy** of the
asset in Drupal's media storage, or you can **embed a public CDN link** to the
asset as it lives in IntelligenceBank. Two optional submodules extend where you can
do this: **IB DAM Media** (`ib_dam_media`) integrates with Drupal's core Media
Library, and **IB DAM WYSIWYG** (`ib_dam_wysiwyg`) lets editors insert DAM assets
straight into the rich‑text editor.

Setup has two parts: install the module (note that the Composer package is
`drupal/intelligencebank` but the module you enable is `ib_dam`), then connect it
to your IntelligenceBank account on its settings form. Because the connection uses
IntelligenceBank credentials, keep those out of plain configuration and treat them
as secrets.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — connect Drupal to your
   IntelligenceBank account.

## Where it lives in the admin menu

The module's connection settings are managed on its own settings form, guarded by
the **administer intelligencebank configuration** permission. Once connected and
with the submodules enabled, you use the DAM from the **Media Library** (via
`ib_dam_media`) and from the rich‑text editor (via `ib_dam_wysiwyg`). See
[Configuration](configuration/index.md).

> **Note on nested modals:** IntelligenceBank's single‑modal mode inside the Media
> Library can conflict on sites that use a lot of Layout Builder modals. If you hit
> that, it's a known limitation of Media Library/Form API nested modals rather than
> a misconfiguration.
