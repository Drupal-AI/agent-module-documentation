# StoryChief — manual setup guide

**StoryChief** (`storychief`) connects your Drupal site to the
[StoryChief](https://storychief.io) content-distribution platform. Authors write
and collaborate on SEO blog posts and social content in StoryChief, then publish to
multiple channels at once — and this module makes Drupal one of those channels.
When a story is published in StoryChief, StoryChief pushes it to your site through a
webhook, and the module turns the incoming payload into Drupal content according to
a field mapping you configure.

The incoming webhook is properly secured. Each request carries an HMAC-SHA256
signature; the module recomputes that signature over the payload using your
configured StoryChief key and compares it in constant time, rejecting anything that
does not match. In other words, a forged request that lacks the shared key cannot
inject content — the right posture for a content-push endpoint. The practical
consequence is that the key *is* the security boundary: store it as a secret, and
treat whoever holds it as able to create content on your site.

To use the module you create a Drupal destination in your StoryChief workspace,
install and enable the module here, save your encryption key and map the StoryChief
fields to your Drupal fields, and then publish from StoryChief. For developers, the
module uses Drupal's annotation-based plugin pattern for field mapping and exposes
hooks (`hook_storychief_node_type_alter()`, `hook_storychief_payload_alter()`,
`hook_storychief_field_handler_info_alter()`) to customise the behaviour.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — save the key and map fields so
   published stories land as Drupal content.

## Where it lives in the admin menu

The module's settings are provided by the `storychief.admin` route in the admin
configuration area, and the module defines its own permissions to control who may
administer it.

## Requirements

You need a StoryChief workspace — if you do not have one, you can sign up on the
StoryChief site. That workspace is where you create the Drupal destination that
points at this site.
