# Musica — manual setup guide

**Musica** (`musica`) provides a unified **API for various music‑streaming
services**. Its goal is to make third‑party music data accessible to other Drupal
modules through one consistent interface — you query multiple providers (searching
tracks, fetching metadata) without each module needing to learn each provider's
own API. It also ships some complementary **Views** for demonstration or practical
use. It currently integrates with **Spotify**, **Last.fm** (legacy API), and
**MusicBrainz** (discovery API).

Under the hood it uses the industry‑standard **OpenAPI** specification to define
which third‑party data is available, and it leans on API Platform's Schema
Generator to produce predictable data‑transfer‑object entities — a design choice
that keeps maintenance low and lets the module track upstream schema changes more
easily. All of its external dependencies are installed and managed automatically
through Composer.

Musica is primarily a **developer tool / web‑services layer**: you build on the
client interface it exposes. Each provider you want to use needs its own **API
access** — typically a private/public key pair you obtain from that service — and
those credentials should be stored securely (backed by environment variables) and
never committed to version control. The module provides its own permission(s), so
gate access appropriately. It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings screen documented** for this module — its real
setup is obtaining each provider's API keys and supplying them securely,
described in "How to use it" below.

## How to use it

1. **Get API access** for each service you intend to use — Spotify, Last.fm,
   and/or MusicBrainz — *before* you rely on the module. This usually means
   registering an app and receiving a private/public access key pair.
2. Install and enable the module (see [Installation](installation/index.md)).
3. **Supply your access keys** to the module. Store them **securely** — backed by
   environment variables, injected per environment — and never commit them to
   version control. (See the note below on the recommended DDEV + Key pattern.)
4. Build on the module's client layer (or use the bundled **Views**) to query the
   providers — searching tracks and fetching metadata through the single
   interface.

> **Storing credentials safely.** Keep each provider's secret in an environment
> variable rather than in code or exported config. With DDEV you can set one with
> `ddev dotenv set .ddev/.env --spotify-secret=<value>` and restart, then
> consume it from the site. Where a provider integration supports a **Key**
> entity, prefer that (backed by the environment‑variable key provider) so the
> secret never lands in the database or configuration exports.
