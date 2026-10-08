# Auto Recommend Content Tags — manual setup guide

**Auto Recommend Content Tags** (`auto_recommended_tags`) suggests taxonomy tags
to editors in real time as they type in the content form. It does this by
sending the content text to an **Apache Stanbol** server — a semantic
enhancement engine that extracts entities and keywords — over a WebSocket
connection, and streaming the suggestions back into the editing screen.

It is a content-editing / integrations feature aimed at speeding up consistent
tagging of articles or knowledge-base content. Suggestions are advisory: the
editor decides which of them to accept into the taxonomy reference field. It
depends on core **Taxonomy**.

**This module needs an external service.** A running Apache Stanbol server (with
its enhancement engines) must be reachable, and the browser/site needs network
access to it over the WebSocket bridge you configure. Without a Stanbol server to
talk to, the module has nothing to get suggestions from.

The module ships front-end JavaScript (built from SCSS via a gulp toolchain) that
opens the WebSocket and renders the suggestion UI, plus a settings form where you
point it at your Stanbol host.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — point the module at your Apache
   Stanbol server and set who may configure it.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Auto Recommended Tags**
(`/admin/config/services/auto_recommended_tags`). It is protected by the
**`administer auto recommended tags settings`** permission.

## How to use it

1. Install and enable the module, and have an Apache Stanbol server available
   (see [Installation](installation/index.md)).
2. Configure the Stanbol / WebSocket connection (see
   [Configuration](configuration/index.md)).
3. When an editor types into a content form, recommended tags appear in real
   time; the editor clicks the ones to apply, populating the taxonomy reference
   field. This works best with a curated taxonomy vocabulary.
