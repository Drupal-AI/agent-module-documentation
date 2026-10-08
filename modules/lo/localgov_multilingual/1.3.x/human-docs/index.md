# LocalGov Multilingual — manual setup guide

**LocalGov Multilingual** (`localgov_multilingual`) adds multilingual support to
sites built on the **LocalGov Drupal** distribution — the UK local‑government
platform. Rather than asking you to configure content translation by hand for
every LocalGov content type, it ships the translation configuration ready‑made,
and lets you switch it on for exactly the content types you publish in more than
one language.

The base module carries the shared configuration; the day‑to‑day choice is *which*
content types you want translatable. That is what the submodules are for — each one
turns on multilingual for a specific LocalGov content type (services, guides, news,
events, directories, step‑by‑step, alert banners, subsites, blogs). Enable only the
ones you need. Originally built by Tipperary County Council for Irish, it supports
Irish and Welsh translation out of the box and works with any language you add.

Translations respect the same access rules as the original content — this module
configures translation, it does not change who can see what.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and pick the per‑content‑type submodules you need.

This module has **no settings form of its own**. You configure it by enabling the
right submodules (below) and then adding languages and translating content through
Drupal's standard multilingual tools at **Configuration → Regional and language**.

## Where it lives in the admin menu

LocalGov Multilingual adds no dedicated admin page. Once enabled it configures the
core **Content Translation** system for LocalGov content types. You add languages
at **Configuration → Regional and language → Languages**
(`/admin/config/regional/language`) and translate individual nodes from the
**Translate** tab that appears on each translatable content item.

## How to use it

1. Enable the base module and the submodule(s) for the content types you translate
   (see [Installation](installation/index.md)).
2. Add the languages you publish in at **Configuration → Regional and language →
   Languages** — Irish and Welsh are supported directly, and you can add any other.
3. Open a piece of content of an enabled type and use its **Translate** tab to add
   a translation in each language.

Because this module targets the LocalGov Drupal distribution, it expects the
LocalGov content types (services, guides, news, and so on) to be present — it is
meant to run as part of a LocalGov site rather than on bare Drupal core.
