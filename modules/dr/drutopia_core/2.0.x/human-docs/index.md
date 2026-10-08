# Drutopia Core — manual setup guide

**Drutopia Core** (`drutopia_core`) is the foundational base *feature* module of
the [Drutopia](https://www.drupal.org/project/drutopia) distribution. Its job is
to assemble and configure the shared components that the rest of the distribution
assumes are present — media handling, image cropping, Display Suite, Metatag,
Pathauto, Search API, Paragraphs and more — so that the content features built on
top of it (Article, Blog, Campaign, Event, Comment and the rest) have a
consistent base to rely on.

It carries no controllers or services of its own. Instead it declares a large set
of dependencies and ships the default configuration those components need.
Dependencies include core `ckeditor5`, `media`, `media_library`, `image`,
`responsive_image` and `taxonomy`, plus contrib `automated_crop`, `crop`,
`focal_point`, `image_widget_crop` and the media-crop adapters, `ds` (Display
Suite), `exclude_node_title`, `faqfield`, `metatag`, `paragraphs`, `pathauto`,
`search_api` (with `search_api_db`), `video_embed_field` and `config_perms`.

The only executable code is `drutopia_core.install`, whose update hooks
progressively install newly added dependencies when an existing site is upgraded
from an older Drutopia release. There are no routes, permissions or services, so
it adds no independent access surface — its security posture is core's. Setup is
simply enabling it (the Drutopia install profile does this first) so downstream
features have their components in place.

Because it is the base of the whole suite, the other Drutopia feature guides in
this knowledge base cross-reference this page — for example
[Drutopia Article](../../drutopia_article/2.0.x/human-docs/index.md),
[Drutopia Blog](../../drutopia_blog/2.0.x/human-docs/index.md),
[Drutopia Campaign](../../drutopia_campaign/2.0.x/human-docs/index.md),
[Drutopia Comment](../../drutopia_comment/2.0.x/human-docs/index.md) and
[Drutopia Event](../../drutopia_event/2.0.x/human-docs/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   base feature and its dependencies.

There is **no dedicated configuration page** for this module — it ships
configuration and dependencies rather than a settings form. Each component it
brings in (Media, Metatag, Pathauto, Search API, Display Suite and so on) is
configured through that component's own admin pages.

## Where it lives in the admin menu

Drutopia Core adds no settings page of its own. What it installs is configured
through the admin pages of the components it provides — for example **Structure →
Media types**, **Configuration → Media → Crop**, **Configuration → Search and
metadata → Metatag**, **Configuration → Search and metadata → URL aliases**
(Pathauto), and the Search API pages under **Configuration → Search and
metadata**.

## How to use it

In normal use you don't interact with Drutopia Core directly — you enable it (or,
more usually, let the Drutopia install profile enable it first) and then add the
Drutopia content features you need. It guarantees the shared components and their
default configuration are present so those features work consistently. When you
upgrade a site from an older Drutopia release, its update hooks install any newer
dependencies automatically.
