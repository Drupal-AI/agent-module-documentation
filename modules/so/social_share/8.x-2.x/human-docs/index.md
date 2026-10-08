# Social Share — manual setup guide

**Social Share** (`social_share`) provides social-share buttons that can be
configured to suit their context, so visitors can share your content to the major
networks. It is a front-end feature and depends on the Typed Data module
(`typed_data`), running on Drupal 8 through 11.

The point of "contextually configurable" is that the buttons adapt to where they
are used rather than being a single fixed widget. Share buttons for the major
networks are a standard content feature, and this module supplies them in a form
you can shape per context.

One thing to confirm for your own privacy posture: share buttons come in two
flavours. Some load a network's own SDK script, which can track visitors on sight
and typically needs cookie consent; others are simple share links (plain share
URLs) that load nothing third-party. Where visitor tracking is a concern, prefer
plain share URLs, and check which approach a given configuration uses before you
put it live. This release is a beta (8.x-2.0-beta9), so test it before relying on
it in production.

This guide is written for a **human** setting the buttons up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, Social Share lets you add configurable share buttons to your
content and choose which networks appear. Enable it where sharing helps, keep it
off elsewhere, and restrict who can administer the configuration. Because the
module can be set up to share in different ways, verify on your own site which
mechanism a configuration uses — plain share URLs versus a network SDK — so it
matches your theme and your privacy requirements. Review the configuration again
after upgrades, as sharing endpoints and network requirements change over time.
