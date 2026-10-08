# openAI Images — manual setup guide

**openAI Images** (`openai_images`) generates images from text descriptions using
the OpenAI API (DALL·E) and saves them as **media entities** in your Drupal media
library. You describe what you want, the module asks OpenAI to produce a matching
image, and the result becomes a managed media item you can reuse across articles,
landing pages, and other content. It can also create **variations** of an image.
The goal is to turn textual ideas into ready‑to‑use visuals without leaving
Drupal.

Because generated images land in the media library as regular media entities,
they're easy to find, manage, and reference wherever you'd use any other image.
The module depends on core's **Media** module.

Two practical considerations: the module authenticates with an **OpenAI API key**
that you enter on its settings page — store it securely and keep it out of version
control — and each image you generate is a **paid API call**, so watch usage and
cost, and review OpenAI's pricing and terms before relying on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your OpenAI API key.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → openAI Images settings**
(`/admin/config/media/openai_images_settings`). See
[Configuration](configuration/index.md).

## How to use it

Once your API key is set, use the module's create‑image form to enter a text
description and generate an image, or create a variation of an existing one. The
generated images are saved as media entities in the **media library**, from where
you can insert them into content like any other media item.
