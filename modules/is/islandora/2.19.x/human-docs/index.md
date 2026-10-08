# Islandora — manual setup guide

**Islandora** (`islandora`, the "Islandora Core" module) is the Drupal foundation of
the Islandora digital-repository framework. It turns ordinary Drupal nodes, media,
and taxonomy into a linked-data repository, and wires that content to a stack of
external services — derivative generation, full-text search indexing, and
(optionally) a Fedora repository — through a message broker and the Context module.
It is a large suite, not a single-purpose module: expect to set up infrastructure
beyond Drupal to get the full experience.

Here is the mental model. A repository **object** is a Drupal node; objects are
linked into parent/child hierarchies by a `field_member_of` field and typed by a
`field_model` taxonomy (Image, Video, Audio, Paged Content, and so on). The actual
binary files are **media** entities, tagged by a `field_media_use` taxonomy (Original
File, Service File, Thumbnail, …). Rather than hardcoding "when an image is added,
make a thumbnail," Islandora is **Context-driven**: administrators build Contexts out
of **Conditions** ("when a node is an Image") and **Reactions** ("generate a
derivative", "index it", "delete it"), and those Reactions fire Islandora **Actions**
that publish events to a message broker (ActiveMQ over STOMP/AMQP by default) for
microservices to act on, or push content into Search API.

On top of that, Islandora exposes your content as **JSON-LD** with configurable RDF
mappings, can mirror it into a **Fedora 6** repository as linked data, adds
batch wizards for adding child objects and media to a node, and provides REST-ish
endpoints (authenticated by basic auth, session cookie, or short-lived JWTs) that let
microservices attach or replace media files. Optional submodules add the actual
image/audio/video/OCR derivative pipelines, IIIF support, breadcrumbs, and more.

This guide focuses on the **Drupal side** of setup — installing the module and
configuring the core settings. Standing up the full repository (Fedora, the message
broker, the microservices/Alpaca, Solr) is done outside Drupal and is documented by
the [Islandora project](https://islandora.github.io/documentation/); this guide points
to where those pieces plug in.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## What's new in 2.19.x

Version 2.19.0 is a maintenance minor over the 2.18 line. The most visible change for
site builders is that the long-deprecated **Advanced Search** submodule
(`islandora_advanced_search`) has been **removed** — if you had it enabled, uninstall
it before or during the update. Other changes are internal: IIIF manifests now target
IIIF Image API v3, node deletion reports failures more clearly, the file-checksum view
gained display extenders (and an old Matomo extender was dropped), and the module was
updated for Drupal 11.4. There are no new settings, permissions, or menu items.

## Contents

1. [Installation](installation/index.md) — install with Composer, understand the
   large dependency set, enable the module, and choose submodules.
2. [Configuration](configuration/index.md) — the core settings form (broker, JWT,
   Fedora, uploads), plus how the Context → Reaction → Action automation engine fits
   together.

## Where it lives in the admin menu

Islandora adds a hub at **Configuration → Islandora** (`/admin/config/islandora`),
with the core settings at **Configuration → Islandora → Core Settings**
(`/admin/config/islandora/core`). The automation engine is configured under
**Structure → Contexts** (`/admin/structure/context`). An RDF-mappings report lives at
**Reports → Islandora RDF Mappings** (`/admin/reports/islandora/rdf_mappings`).

## How to use it

At a high level: install and enable Islandora (plus the derivative submodules you
need), point it at your message broker and, optionally, Fedora on the core settings
form, then create the taxonomy terms and Contexts that describe how your objects
behave. The Drupal-side steps are in [Configuration](configuration/index.md); the
external services must be running for emitted events to actually be processed.
