# Lingotek Copy Target — manual setup guide

**Lingotek Copy Target** (`lingotek_copy_target`) solves a narrow but real problem
for multilingual sites that use [Lingotek / Ray Enterprise
Translation](../../../lingotek/11.0.x/human-docs/index.md): when two of your locales
should hold the *same* translation — for example regional variants like
`es-ES` and `es-MX`, or `en-GB` and `en-AU` — you don't want to pay to translate
the same text twice. This module lets you **copy a downloaded Lingotek translation
from one locale into one or more other locales automatically**.

You define mappings of *original locale → copy locale* on a small configuration
form. Then, whenever Lingotek downloads a translation for a mapped original locale,
the module hooks into Lingotek's content and configuration translation presave
events and saves the very same downloaded data into each mapped target locale —
using Lingotek's own translation‑save services, so the data is stored exactly the
way Lingotek would store it. It makes no external HTTP calls of its own; it simply
mirrors what Lingotek already downloaded.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it requires Lingotek).
2. [Configuration](configuration/index.md) — map original locales to the locales
   they should be copied into.

## Where it lives in the admin menu

The mapping form is provided by this module (route
`lingotek_copy_target.config`) and is linked from the **language edit form**, so
you configure a copy target from the language you are editing. Managing mappings is
gated by the **Configure lingotek copy target** permission.
