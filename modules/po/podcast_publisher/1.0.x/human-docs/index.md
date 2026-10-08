# Podcast Publisher — manual setup guide

**Podcast Publisher** (`podcast_publisher`) is a plug-and-play way to create and
publish your own podcast feed from a Drupal site. It aims to give site builders a
simple, easily configurable solution for hosting and publishing podcasts without
having to model everything themselves.

When you enable it, the module provides three ready-made pieces: a new **Podcast**
content type, a new **Podcast Episode** media type (holding the episode's audio
file and metadata), and a **View** that renders the podcast feed. Together these
let you add episodes as content and expose a standard podcast feed that listeners'
apps can subscribe to. Episodes are ordinary Drupal content, governed by the normal
entity-access system.

An optional **Podcast Analytics** submodule (`podcast_publisher_analytics`) tracks
per-episode metrics. If you enable it, be mindful of what listener data it records
and how that fits your site's privacy commitments.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally add the analytics submodule.

This module has **no dedicated settings form**. Its "configuration" is the content
type, media type and feed View it installs, which you work with through Drupal's
normal content and structure screens — see "How to use it" below.

## Where it lives in the admin menu

Podcast Publisher does not add a central settings page. You manage your podcast
through the standard admin areas: the **Podcast** content type and **Podcast
Episode** media type appear under **Structure**, and you create podcasts and
episodes from the **Content** section.

## How to use it

1. After enabling the module, go to **Content → Add content → Podcast** to create a
   podcast (its title, description and other feed-level metadata).
2. Add episodes as **Podcast Episode** media items — upload the audio file and fill
   in the episode metadata and links.
3. Visit the podcast's feed (rendered by the bundled View) and use that feed URL in
   podcast directories or share it with subscribers.
4. If you want episode metrics, also enable the **Podcast Analytics** submodule (see
   Installation) and review what it records against your privacy needs.

If your site already has a rich data model and you need more flexibility, the
maintainers note that the **Podcast (Using Views)** module is a more flexible
alternative.
