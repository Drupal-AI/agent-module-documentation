# Acquia Personalization (Perz) — manual setup guide

**Acquia Personalization (Perz)** (`acquia_perz`) connects your Drupal site to
Acquia's Personalization service, formerly known as Acquia Lift, which is built
on the Content Index Engine (CIS). Once connected, the module renders selected
pieces of your content and makes them available to the service, which can then
serve personalized, segment-targeted variations to your visitors and collect
anonymous visitor data for analytics and A/B testing.

The module relies on the **Acquia Connector** module for your Acquia
subscription and credentials — it does not ask you to type an API key into its
own form. Instead you configure things like the API region, how visitors are
identified, and which Drupal fields map to Acquia's segmentation and User
Defined Field (UDF) slots. Separately, on each content type's *Manage display*
screen, you opt individual view modes in or out of personalization and choose
how each one is rendered before export.

An important detail: the base module on its own only fires a lightweight
"decision webhook" when content is saved or deleted. The actual export of your
content to the service is handled by the bundled **acquia_perz_push** submodule,
which you must also enable for personalization to receive any content. If it is
missing, Drupal's status report will flag the configuration as incomplete.

Because this module talks to a paid Acquia service, keep any credentials it needs
in environment variables rather than committing them — the Acquia Connector
subscription details are what authenticate the connection.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   base module and the `acquia_perz_push` submodule, and confirm the Acquia
   Connector prerequisites.
2. [Configuration](configuration/index.md) — the global settings form and the
   per-bundle personalization opt-in, field by field.

## Where it lives in the admin menu

The global settings form sits at **Configuration → Web services → Acquia
Personalization → Settings**
(`/admin/config/services/acquia-perz/settings`). The per-bundle opt-in is not a
page of its own — it appears as an **Acquia Personalization** section on each
content type's *Manage display* form under **Structure**.

## How to use it

Once installed and connected, the typical flow is: enable both the base module
and `acquia_perz_push`, set your API region and Site ID on the settings form,
then visit a content type's *Manage display* screen and tick **Make … available**
for the view mode you want to personalize (for example the Article "full" view
mode). Only entities that can be published (nodes, taxonomy terms, custom blocks)
can be personalized. From there the service serves personalized variations, and
`acquia_perz_push` keeps the exported content in sync as you publish, update, or
unpublish entities.
