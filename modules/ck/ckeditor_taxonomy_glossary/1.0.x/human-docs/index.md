# CKEditor Taxonomy Glossary — manual setup guide

**CKEditor Taxonomy Glossary** (`ckeditor_taxonomy_glossary`) lets content editors
link words in their text to **glossary terms**, so that when a visitor hovers over
(or focuses/clicks) the linked word on the front end, a tooltip shows the term's
definition. The glossary itself is an ordinary Drupal **taxonomy vocabulary**
named *Glossary*, so definitions are managed as taxonomy terms — the term name is
the word, and its description is the definition shown in the tooltip.

It adds a **Glossary Link** button to CKEditor 5 with autocomplete: editors
highlight text, click the button, and start typing to find a matching term — or
create a brand-new term (name and description) on the fly without leaving the
editor. There is multilingual support, with language badges (for example `[EN]`)
in the autocomplete and language-specific behaviour, and the front-end tooltips
are cached, accessible, and keyboard-navigable.

The module depends on core's **Taxonomy**, **CKEditor 5**, and **Filter**
modules. Getting it working is a few steps rather than a single toggle: you enable
a text-format **filter** ("Glossary link filter"), add the **Glossary Link**
button to that format's toolbar, grant a couple of **permissions**, and manage
your terms in the *Glossary* vocabulary. All of that is covered in the
configuration guide.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable the filter, add the button,
   grant permissions, and manage glossary terms.

## Where it lives in the admin menu

There is no single settings page. The pieces live in the usual admin locations:

- **Text format setup** — **Configuration → Content authoring → Text formats and
  editors** (`/admin/config/content/formats`).
- **Glossary terms** — **Structure → Taxonomy → Glossary**.
- **Permissions** — **People → Permissions** (`/admin/people/permissions`).
