# D-ID AI Provider — manual setup guide

**D-ID AI Provider** (`did_ai_provider`) connects the **D-ID** talking-head video
service to Drupal's **AI** module and its **AI Automators** framework. Give it an
audio clip plus either a still image or a chosen D-ID presenter, and it generates a
talking-head style video — the kind where a portrait or avatar appears to speak
your audio — and stores the finished MP4 back in a Drupal file field.

It registers a new AI Automator type ("Image + Audio → Video", and a
presenter-based variant) that site builders wire onto a file field. You map which
field holds the audio and which holds the image (or pick a built-in presenter and
choose "No image"), optionally select a facial expression (neutral, happy,
surprised, serious, angry, sad), and then generation runs automatically when
content is saved. Behind the scenes the module uploads the assets to D-ID, creates
the talk, polls until the result is ready, and saves the video to
`public://did_videos`. It's a modern replacement for the older D-ID module, which
was built on the now-deprecated AI Interpolator system.

Setup has two security-and-cost dimensions worth understanding up front. The D-ID
API credential is stored through the **Key** module rather than hardcoded. And
because every generation is a **paid**, potentially long-running (up to ~10
minutes) call to an external service, you should restrict who can trigger the
automators. It requires Drupal 10+, the AI module, the Key module, and a D-ID API
account.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer and enable it.
2. [Configuration](configuration/index.md) — store the D-ID key, select it on the
   provider settings form, and enable the automator on a file field.

## Where it lives in the admin menu

The provider's settings form is at **Configuration → AI → D-ID Provider settings**
(`/admin/config/ai/di-ai-provider`), gated by the **administer ai providers**
permission. The automator itself is configured per field under **Manage fields**
on your content type.
