# Config Translation PO — manual setup guide

**Config Translation PO** (`config_translation_po`) lets you export your site's
translatable **configuration** strings to a standard Gettext `.po` file, hand it
to translators, and then import the translated `.po` back into Drupal's
configuration translations. It's the config-text counterpart to Drupal's
interface-translation `.po` workflow.

Configuration text is everywhere: menu link titles, view display names, field
labels, block text, and more. Normally you translate these by clicking through the
per-config translation forms one object at a time. This module replaces that with
a single round-trip file: export one `.po` per language, translate it offline in a
CAT tool like Poedit, Weblate, or memoQ, and import it to populate all those
configuration translations at once.

It adds two tabs — **Export** and **Import** — under Drupal's existing
Configuration translation page, and reuses Drupal's own locale machinery. It
defines no permissions of its own; both tabs use core's **Translate interface**
permission, the same trust level as core's interface-translation import/export.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Locale and Configuration Translation.
2. [Configuration](configuration/index.md) — using the Export and Import tabs.

## Where it lives in the admin menu

The module adds two tabs to the core configuration-translation screen at
**Configuration → Regional and language → Configuration translation**
(`/admin/config/regional/config-translation`):

- **Export** (`/export`) — download a language's config strings as a `.po` file.
- **Import** (`/import`) — upload a translated `.po` file.

Both require the **Translate interface** permission.
