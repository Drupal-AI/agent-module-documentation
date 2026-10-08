# Podigee — manual setup guide

**Podigee** (`podigee`) lets you play an audio file with the **Podigee** HTML5
podcast player. It provides a **field formatter** for audio (file) fields: instead
of a plain download link or the browser's default audio control, the file is
rendered inside Podigee's player.

Beyond simple playback, the player can show a cover image, title, description and
subtitle for the podcast (pulled from the same media entity using tokens), display
episodes from an RSS feed, offer download and social-sharing controls, and be
styled with one of three available themes. It depends only on core's **File**
module.

One thing to be aware of: the player and its assets load from the **external
Podigee service**, so enabling this formatter means your pages embed third-party
JavaScript from Podigee — trust the provider accordingly. The audio itself is
public content; the module has no access-control role.

This is an alpha release, and at this stage it has known limitations: only **mp3**
files are supported, and each player handles **one episode**. Check the project page
for the current state before relying on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings form** — the module has no configuration page of its
own. You set it up per field on **Manage display**, described in "How to use it"
below.

## Where it lives in the admin menu

Podigee adds no admin page. You use it entirely from **Structure → *(content or
media type)* → Manage display**, where the **Podigee** formatter becomes available
for audio (file) fields.

## How to use it

1. Have an entity (a content type or media type) with an **audio file field** that
   holds your mp3 episodes.
2. Go to that bundle's **Manage display** (**Structure → … → Manage display**).
3. Set the audio field's **Format** to **Podigee**.
4. Configure the formatter's options — choose one of the three themes, and (using
   tokens) point it at the cover image, title, description and subtitle from the
   same entity, plus an RSS feed if you want to list episodes.
5. Save the display. The audio field now renders with the Podigee player, loading
   the player assets from the Podigee service.
