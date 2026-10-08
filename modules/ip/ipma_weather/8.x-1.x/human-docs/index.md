# IPMA Weather — manual setup guide

**IPMA Weather** (`ipma_weather`) provides a **block that displays weather
information** using data from IPMA — the *Instituto Português do Mar e da
Atmosfera*, Portugal's official meteorological service. Place the block in a region
of your theme and it shows the current conditions and forecast for a location you
choose.

On the block's settings you pick the **location** and decide which of the fields
that IPMA's API returns you want to **show or hide**, so you can keep the block as
compact or as detailed as your design needs. The data comes from IPMA's public API,
so there are **no API keys or credentials** to manage — and the weather it shows is
public information, not access-controlled content.

The only dependency is Drupal core's **Block** module, and it works on Drupal 8
through 11. It is a display/integration helper aimed at Portuguese sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — place the block and choose its
   location and which fields to display.

## Where it lives in the admin menu

IPMA Weather has no central settings page. You configure it entirely by placing and
editing its block under **Structure → Block layout**
(`/admin/structure/block`) — see [Configuration](configuration/index.md).
