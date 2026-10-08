# CKEditor 5 Premium Features — manual setup guide

**CKEditor 5 Premium Features** (`ckeditor5_premium_features`) brings CKEditor's
commercial add-ons — real-time collaboration, track changes, comments, revision
history, export to and import from Word and PDF, an AI assistant, @-mentions,
merge fields, footnotes, and more — into Drupal's CKEditor 5 editor. This base
module is the shared foundation of the whole suite: on its own it only provides
one central settings form and the license/token authentication plumbing that
every feature reuses. The individual features each ship as their own thin
submodule that you enable on demand, so you turn on only what you actually need.

Because these are CKEditor's *commercial* features, most of them require a
**CKEditor commercial license key** and/or a **CKEditor Cloud Services**
subscription (a free trial is available at orders.ckeditor.com). Enabling the
module alone changes nothing an editor can see — the features only appear once
you enter your credentials on the settings form, enable the relevant feature
submodule, and add that feature's button to a text format's CKEditor 5 toolbar.
It depends on core's **Editor** (`editor`) and **CKEditor 5** (`ckeditor5`)
modules, and some features additionally need PHP libraries pulled in through
Composer (`firebase/php-jwt`, `caxy/php-htmldiff`, `openai-php/client`,
`aws/aws-sdk-php`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the base module with Composer,
   enable it, and pick which feature submodules you need.
2. [Configuration](configuration/index.md) — the license key and Cloud Services
   authorization settings, field by field, plus how to switch a feature on for a
   text format.

## Where it lives in the admin menu

The settings form sits at **Configuration → CKEditor 5 Premium Features**
(`/admin/config/ckeditor5-premium-features/settings`). This is where you enter
your license key and choose an authorization type. The actual editing features
are switched on per text format at **Configuration → Content authoring → Text
formats and editors** (`/admin/config/content/formats`), by dragging the
feature's button into that format's CKEditor 5 toolbar.

## How to use it

There are three steps to getting a premium feature working:

1. **Enter your credentials** on the settings form — your commercial license key,
   and (for cloud features) either an Access key or a Development token URL.
2. **Enable the feature submodule** — for example
   `ckeditor5_premium_features_export_pdf` for PDF export, or
   `ckeditor5_premium_features_realtime_collaboration` for live collaborative
   editing. Enabling the base module by itself provides no editing feature.
3. **Add the feature to a text format** — edit a CKEditor 5 text format and drag
   the feature's button into the active toolbar.
