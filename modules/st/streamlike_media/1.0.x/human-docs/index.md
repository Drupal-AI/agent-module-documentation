# Streamlike Media — manual setup guide

**Streamlike Media** (`streamlike_media`) adds a **"Streamlike Media" field type**
to Drupal so you can embed videos from the
[Streamlike](https://www.streamlike.com) enterprise video platform simply by
storing a Streamlike media ID. Streamlike is a SaaS platform for live and on-demand
streaming; this module lets an editor paste a media ID into a field and have the
Streamlike player rendered in the content — the video stays hosted on Streamlike,
while Drupal just embeds it.

The module ships three matching pieces: the **field type**
(`streamlike_media_field`, which stores a single media ID and carries a per-field
default CDN setting), a **field widget** (`streamlike_media_field_widget`, the input
where editors type the media ID), and a **field formatter**
(`streamlike_media_field_formatter`, which renders the Streamlike player pointing at
the configured CDN). It depends only on core's **Field** module.

There is no admin settings page and nothing to configure globally — everything is
done through Drupal's standard **Field UI**. You add a Streamlike Media field to
whatever entity you like (a content type, a taxonomy vocabulary, users, and so on),
set the CDN if it differs from the default, and editors then enter one media ID per
item. Because the player loads client-side from the Streamlike CDN and the media ID
is entered by trusted editors, the module itself performs no server-side fetch and
exposes no anonymous or mutating endpoints.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Go to the **Manage fields** screen of the entity you want to add video to (for
   example a content type at **Structure → Content types → *Type* → Manage
   fields**).
2. Add a new field of type **Streamlike Media**.
3. In the field's settings, set the **Default Streamlike CDN** if it should differ
   from the default `cdn.streamlike.com`.
4. On **Manage form display**, confirm the Streamlike Media widget is used so
   editors get the media-ID input; on **Manage display**, confirm the Streamlike
   Media formatter is used so the player renders.
5. Editors then paste a **Streamlike media ID** into the field on each entity, and
   the player appears wherever the field is displayed. You can reuse the field
   across bundles, show it in different view modes, and use it in Views as a
   rendered field.
