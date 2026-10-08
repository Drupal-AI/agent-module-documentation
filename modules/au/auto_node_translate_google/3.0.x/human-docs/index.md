# Auto Node Translate Google — manual setup guide

**Auto Node Translate Google** (`auto_node_translate_google`) is a translation
*provider* for the Auto Node Translate module. It lets Auto Node Translate
machine-translate your node content using the **Google Cloud Translation v3
API**, with optional glossary support so a controlled vocabulary is honoured.

Where Auto Node Translate handles the workflow of creating and filling in
translations, this module supplies the Google backend. It authenticates with a
Google Cloud **service-account credentials JSON** file that you upload through
its settings form, along with your Google Cloud project id and location. Long
text is split into chunks (over 20,000 characters) and translated in pieces, and
if you configure a glossary id for a language, translations respect that
glossary.

**Where your content goes, and how the credentials are handled.** When you
translate a node, its field text is sent to Google's Cloud Translation service —
so content leaves your site for translation. The module's credential handling is
sound: the uploaded service-account JSON is stored via a managed-file element in
the **private filesystem** (`private://`), not a web-accessible directory, and
only files with a `.json` extension are accepted. Translation calls go through
the official Google Cloud PHP SDK, which handles TLS. Because the credentials
live in the private filesystem, make sure that filesystem is correctly protected
on your server.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm its dependencies.
2. [Configuration](configuration/index.md) — set up your Google Cloud project,
   upload the credentials, and (optionally) configure glossaries.

## Where it lives in the admin menu

The settings form is at **Configuration → Regional and language → Google**
(`/admin/config/regional/google`). It is protected by the core **Administer site
configuration** permission.

## How to use it

1. Install and enable this module alongside Auto Node Translate (see
   [Installation](installation/index.md)).
2. Create a Google Cloud project, enable the Cloud Translation API, and generate
   a service-account credentials JSON — then upload it and set your project id
   and location (see [Configuration](configuration/index.md)).
3. Select **Google** as the provider for Auto Node Translate, then translate
   node content as usual — the fields are translated through the Google Cloud
   Translation API.
