# JSON:API Extras Text Field Enhancer — manual setup guide

**JSON:API Extras Text Field Enhancer** (`jsonapi_text_enhancer`) adds a field
*enhancer* to the **JSON:API Extras** module that reshapes how formatted text
fields appear in the API. A Drupal formatted-text field carries several parts —
the raw stored value, the processed (rendered) HTML, an optional summary, and the
text format — and by default JSON:API returns these in core's own shape. This
enhancer presents the processed and raw parts in a clean, predictable structure
that is easier for a decoupled front end to consume.

Because it is a JSON:API Extras enhancer rather than a standalone feature, it has
no page or settings form of its own. You apply it per field from the JSON:API
Extras resource configuration, where enhancers are selected. Once applied, the
chosen text field is serialized through the enhancer instead of the default
representation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside JSON:API Extras.

This module has **no configuration page** of its own — it is enabled per field
from **JSON:API Extras**, described under "How to use it" below.

## How to use it

1. Make sure **JSON:API Extras** is installed and enabled (it is a hard
   dependency — see [Installation](installation/index.md)).
2. Go to JSON:API Extras' resource configuration
   (**Configuration → Web services → JSON:API**) and edit the resource type
   whose text field you want to reshape.
3. On the field you want to change, choose the text enhancer this module provides
   as the field's **enhancer**, and save.
4. Request that resource over JSON:API — the field is now serialized in the
   enhancer's cleaner processed/raw structure.
