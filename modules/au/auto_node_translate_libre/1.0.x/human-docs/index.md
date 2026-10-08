# Auto Node Translate Libre — manual setup guide

**Auto Node Translate Libre** (`auto_node_translate_libre`) is a translation
*provider* for the Auto Node Translate module that uses **LibreTranslate** — a
free, open-source, self-hostable machine-translation engine — to translate node
content between languages. Where Auto Node Translate handles the workflow of
creating and filling in translations, this module supplies the LibreTranslate
backend.

It is attractive when you want to avoid a commercial translation API, either to
save cost or to keep your content on a translation server you control. You point
it at a LibreTranslate endpoint (self-hosted or hosted) and, if that server
requires one, an API key. Those are configured on its settings form (route
`auto_node_translate_libre.settings`).

**Where your content goes.** When a node is translated, its field text is sent
to the LibreTranslate endpoint you configure. If you run LibreTranslate
yourself, the content stays on your own infrastructure; if you point at a hosted
LibreTranslate, the content is sent to that third party. Treat any API key for a
hosted endpoint as a secret (see [Configuration](configuration/index.md) for how
to handle it), and choose your endpoint with the sensitivity of your content in
mind.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm its dependencies.
2. [Configuration](configuration/index.md) — set the LibreTranslate endpoint and
   API key, and handle that key as a secret.

## Where it lives in the admin menu

The settings form is provided at route `auto_node_translate_libre.settings`,
where you set the LibreTranslate endpoint and any API key.

## How to use it

1. Install and enable this module alongside Auto Node Translate (see
   [Installation](installation/index.md)).
2. Point it at your LibreTranslate endpoint and provide an API key if the server
   needs one (see [Configuration](configuration/index.md)).
3. Select **LibreTranslate** as the provider for Auto Node Translate, then
   translate node content as usual — the fields are translated through your
   LibreTranslate server.
