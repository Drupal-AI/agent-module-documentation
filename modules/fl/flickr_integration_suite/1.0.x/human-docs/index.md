# Flickr Integration Suite — manual setup guide

**Flickr Integration Suite** (`flickr_integration_suite`) connects your Drupal
site to Flickr and gives you three different ways to put Flickr photos on a page:
a configurable **block**, a **field**, and a text-format **filter** (with a
Colorbox lightbox variant of the filter). The base module holds the Flickr API
connection and exposes it as a Drupal service; each display method lives in its own
submodule so you enable only the one(s) you actually use.

The reason to point at Flickr rather than copy photos into Drupal's media library
is that Flickr is often where an organisation's photography already lives —
museums, councils, clubs, community groups with archives that predate the site.
Pointing at Flickr keeps a single source of truth and avoids duplicating storage
and rights management. The three placement options exist because the right one
depends on *who* is placing the photos: a **block** suits a site builder, a
**field** suits a content model, and a **filter** suits an editor writing prose who
wants a photoset inline.

Credential handling here is done the right way: the **Key** module is a hard
dependency, and your Flickr API credentials are stored as a **Key entity** rather
than in configuration — so the value can come from an environment variable and
never lands in a config export. Two practical notes: the Flickr API is
rate-limited, so cache pages that render many photosets rather than fetching per
request; and photo licensing on Flickr varies per image, so displaying someone
else's photostream is a rights question the module cannot answer for you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   base module, and choose the placement submodules you need.
2. [Configuration](configuration/index.md) — enter your Flickr API credentials as
   a Key, then use the block/field/filter.

## Where it lives in the admin menu

The API settings form is registered as `flickr_integration_suite.settings_form`
and lives at **Configuration → System → Flickr Integration Suite** — this is where
you provide your Flickr API credentials.
