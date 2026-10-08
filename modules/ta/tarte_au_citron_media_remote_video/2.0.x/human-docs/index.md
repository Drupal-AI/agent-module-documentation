# Tarte au citron Media Remote Videos — manual setup guide

**Tarte au citron Media Remote Videos** (`tarte_au_citron_media_remote_video`)
connects Drupal's core **Media** remote videos to the **Tarte au citron**
cookie-consent manager. Remote videos added through core media — YouTube, Vimeo and
similar oEmbed embeds — normally load their third-party player (and set the
provider's cookies and trackers) the moment the page renders. This module holds
that back so an embedded remote video only loads *after* the visitor has given the
matching Tarte au citron consent, keeping those embeds GDPR-compliant.

It depends on core **Media** and the **Tarte au citron** module, and lives in the
GDPR package. It adds no settings, routes, or permissions of its own — it provides
a Remote Videos service plugin for Tarte au citron, and all the consent handling
and any service configuration are managed in the parent Tarte au citron module.
Because of that, it does its work as soon as it is enabled.

This is a privacy/consent feature rather than an access-control one: its value is
that it prevents third-party video embeds from loading, setting cookies, or
contacting the provider until the visitor consents.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and its Media and Tarte au citron dependencies.

## How to use it

Enable the module with core Media and Tarte au citron already in place. From then
on, remote video embeds wait for consent automatically. To control how the video
service appears in the consent banner, use the Tarte au citron services
configuration in the parent module — there is nothing to configure on this add-on
directly.
