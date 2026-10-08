# Scribit.pro — manual setup guide

**Scribit.pro** (`scribit_pro`) connects Drupal to the external
[Scribit.pro](https://scribit.pro/) accessible-video platform. Editors submit a
YouTube or Vimeo video from a media entity and request accessibility services —
**subtitles**, **audio description**, a **transcript** and **sign language** — and,
once Scribit.pro has processed the video, the module renders the resulting
accessible video player on the front end. The goal is to make your videos comply
with WCAG 2.1 accessibility guidance without building captioning in-house.

Technically, the module adds a field **widget** ("Scribit Pro oEmbed URL") and a
field **formatter** for **Remote Video** media. The widget submits the video and
your chosen services to Scribit.pro over an authenticated API connection; the
formatter displays the accessible player once processing is done. When an editor
saves a Remote Video media entity, the widget sends the request, and there is a
built-in guard against duplicate submissions plus a 30-second timeout on the
outbound call.

Scribit.pro **requires configuration before it does anything**: you supply a Scribit
ID and an API token, and the token is stored securely as a **Key** entity via the
Key module. Setup also involves creating a Remote Video media type and choosing the
Scribit widget and formatter on its form and display. The module depends on
**Field UI**, **Media** and **Key**, needs **PHP 8.1+**, supports **Drupal 9, 10
and 11**, and carries official security-advisory coverage.

There is also a public callback route (`/scribit-pro/callback`) intended for
Scribit.pro's server to call back after processing. In this version that callback
is an **unimplemented stub** — it simply redirects to the front page and changes no
state — so it is effectively inert; the code itself notes that a real
implementation would need to validate the request's origin/signature. Nothing you
configure depends on it today.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.
2. [Configuration](configuration/index.md) — storing the API token as a Key,
   entering your Scribit ID and token, and wiring up a Remote Video media type.

## Where it lives in the admin menu

The module's own settings form is at **Configuration → System → Scribit Pro**
(`/admin/config/system/scribit-pro`, config `scribit_pro.config`), and it is gated
by the module's **Administer Scribit Pro** (`administer scribit pro`) permission.
