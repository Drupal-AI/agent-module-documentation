# ArcGIS StoryMaps — manual setup guide

**ArcGIS StoryMaps** (`storymaps`) embeds Esri ArcGIS StoryMaps — interactive,
map-based narratives — into your Drupal site. You point the module at a published
StoryMap, and it outputs the embed so the interactive story appears on your pages.
It is a content-display integration: it has no access-control role of its own and
stores no content, it simply renders a third-party embed.

The module works through a small admin settings page plus a **custom block**. On
the settings page you supply the **Story ID** of the StoryMap you want to show and
a **root node selector**; the block then outputs the ArcGIS StoryMaps embed script
using those values. You place the block through Drupal's block layout, or reference
it in your content types (for example with the Block Field module).

One thing to be aware of: the embed loads assets directly from Esri's servers, so
the interactive map is third-party content served from ArcGIS. Keep your site's
privacy and cookie-consent obligations in mind, since visitors' browsers will
contact Esri when the StoryMap loads. Note also that the module is **not covered**
by Drupal's security advisory policy. It supports Drupal 10.1 and newer, including
Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the Story ID and root node
   selector, then place the block.

## Where it lives in the admin menu

The settings page sits at **Configuration → Web services → ArcGIS StoryMaps**
(`/admin/config/services/arcgis-storymaps`).

## How to use it

1. Enable the module.
2. On the settings page, enter your **Story ID** and **root node selector**.
3. Place the module's block via **Structure → Block layout**, or reference it in a
   content type (e.g. with the Block Field module). The StoryMap embed then renders
   wherever you place the block.
