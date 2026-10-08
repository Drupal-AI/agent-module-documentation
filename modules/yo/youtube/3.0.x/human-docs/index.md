# YouTube Field — manual setup guide

**YouTube Field** (`youtube`) adds a dedicated **YouTube video** field type you can
attach to any content type, user, or other fieldable entity. Editors simply paste a
YouTube URL; the field validates it, extracts the video ID, and stores both. You then
choose how it's displayed — as an embedded player, a thumbnail image, or a plain link.

Three formatters cover the common needs. The **video** formatter embeds a responsive
(or fixed-size) iframe player. The **thumbnail** formatter fetches the video's
thumbnail from YouTube, saves it locally, and renders it — so you can apply a Drupal
image style to crop or resize it. The **URL** formatter outputs the raw URL as text or
a clickable link. Player behaviour is layered: site-wide defaults live in a settings
form, and many options — video size, autoplay, mute, loop, hidden controls, hidden
annotations — can be overridden per display.

A **privacy-enhanced mode** switches embeds to `youtube-nocookie.com`, so no cookies
are set until the visitor actually plays a video — useful for GDPR / cookie-consent
compliance. The module accepts many URL formats (`watch?v=`, `youtu.be/`, `/embed/`,
`/shorts/`, and more), exposes per-field tokens for the video and thumbnail URLs, and
needs only core's **Field**, **Image**, and **File** modules.

Note that this is different from core Media's oEmbed "Remote video": YouTube Field
stores a video as a lightweight **scalar field value** on the host entity, with no
media entity or media library involved. Reach for it when you want a simple per-entity
video field with direct player and thumbnail formatters.

> **Release note:** this 3.0.x release is a **beta** (`3.0.0-beta1`). Test it against
> your site before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the field, choose the player or
   thumbnail formatter, and tune the site-wide player and thumbnail settings.

## Where it lives in the admin menu

- **Add the field** — **Structure → Content types → (your type) → Manage fields → Add
  field**, then choose field type **YouTube video**.
- **Choose a formatter** — on that content type's **Manage display**.
- **Global settings** — **Configuration → Media → YouTube Field**
  (`/admin/config/media/youtube`), gated by the **Administer YouTube** permission.
