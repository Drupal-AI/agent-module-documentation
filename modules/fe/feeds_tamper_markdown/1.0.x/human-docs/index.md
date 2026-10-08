# Tamper Markdown — manual setup guide

**Tamper Markdown** (`feeds_tamper_markdown`) provides a
[Tamper](https://www.drupal.org/project/tamper) plugin that converts Markdown to
HTML during a Feeds import. If your source delivers a field as Markdown but you
want stored, renderable HTML, this tamper does the conversion on the way in.

Under the hood it uses the well-known
[league/commonmark](https://commonmark.thephpleague.com/) PHP libraries to do the
conversion, it supports CommonMark extensions, and it gives you control over how
the conversion behaves. In the Tamper UI it shows up as **Convert Markdown to
HTML** under the **Text** group of plugins.

A Tamper plugin transforms one source value as it flows through the import, so you
add this plugin to the specific field that carries Markdown and configure it there
— it has no settings page of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Tamper and Feeds Tamper.

There is **no site-wide configuration page** for this module — it has no settings
form of its own. The conversion options are set per tamper instance on a Feed type,
as described below.

## Where it lives in the admin menu

The plugin adds no admin page of its own. You use it from a Feed type's **Tamper**
tab at **Structure → Feed types** (`/admin/structure/feeds`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Create or edit a Feed type and map the source key that carries Markdown to its
   target (usually a formatted long-text) field.
3. Open the Feed type's **Tamper** tab. On that field, click **Add plugin**, then
   from the list choose **Text → Convert Markdown to HTML**.
4. Configure the plugin to suit your needs. For details on the conversion options
   and extensions, see the
   [league/commonmark documentation](https://commonmark.thephpleague.com/).
5. Create a feed of that type and import — the Markdown is converted to HTML before
   it is saved.
