# Schema.org SocialMediaPosting — manual setup guide

**Schema.org SocialMediaPosting** (`schema_social_media_posting`) adds the
Schema.org [`SocialMediaPosting`](https://schema.org/SocialMediaPosting) family of
types to the JSON‑LD structured data your site outputs. It is an add‑on for the
**Schema.org Metatag** framework, aimed at content that represents social‑media
posts and similar short‑form publishing. In one package it provides
`SocialMediaPosting`, `BlogPosting`, and `DiscussionForumPosting`, and it ships a
companion submodule for `LiveBlogPosting`.

Structured data is invisible markup that tells search engines and AI assistants
exactly what a page is — here, "this page is a social‑media post" (or a blog post,
forum posting, or live blog). Once Schema.org Metatag is in place, this module
contributes those vocabularies; you map your fields onto them through Metatag's
settings screens, and the module writes the matching JSON‑LD into the page head at
render time. It only reflects content already on the page.

The module has no settings form of its own and no content or access role. It
becomes useful as soon as you enable it alongside Schema.org Metatag. It depends on
`schema_article` (a component of Schema.org Metatag) and requires **Schema.org
Metatag 2.x or higher**; it supports Drupal 8 through 11.

This guide is for a **human** working through the admin UI. An AI coding agent
should read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) the LiveBlogPosting submodule.
2. [Configuration](configuration/index.md) — where the SocialMediaPosting fields
   appear and how to map your content onto them.

## How to use it

Once enabled, the SocialMediaPosting types are available inside Schema.org
Metatag. You configure them under **Configuration → Search and metadata → Metatag**
(`/admin/config/search/metatag`), by adding or editing default meta tags for the
content type you want to describe and filling in the **Schema.org:
SocialMediaPosting** fieldset. See [Configuration](configuration/index.md).
