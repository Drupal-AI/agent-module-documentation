# CKEditor Braille — manual setup guide

**CKEditor Braille** (`ckeditor_braille`) lets editors write Braille directly
inside CKEditor 5. Standard keyboard key combinations (the classic `f d s j k l`
Braille keys, pressed alone or together) are mapped to Braille Unicode
characters, and a toolbar toggle switches Braille input on and off. It also
supports transliteration between regular text and Braille, formatted text mixed
with Braille, and Braille math operations — and it bundles a **practice
exercise** page and quiz for learners.

The module has three parts: a **CKEditor 5 plugin** you add to a text format's
toolbar; a text-format **filter** (`BraillePreview`) that renders Braille in the
output; and an **Exercise** page at `/ckeditor-braille/exercise` offering practice
challenges. The letter-to-Braille mappings are configured in each text format's
settings, so different formats can use different mappings. It depends only on
core's CKEditor 5 and ships with prebuilt JavaScript assets, so there is no build
step needed to use it.

A couple of things to know. There is **no central admin configuration page** — all
the settings live on the text-format configuration once you add the Braille
toolbar item (see [Configuration](configuration/index.md)). The Exercise page is a
read-only practice page available to anyone who can *access content*; it performs
no changes. The module can also fetch challenge data from an external endpoint for
the practice feature — a network egress worth being aware of on locked-down sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the toolbar item and set the
   letter mappings and the API/UI/Speech options per text format.

## Where it lives in the admin menu

There is no standalone admin page. You set the module up per text format at
**Administration → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) — see [Configuration](configuration/index.md).
The learner-facing practice page is at `/ckeditor-braille/exercise`.
