# Entity body class — manual setup guide

**Entity body class** (`entity_body_class`) lets editors add CSS classes to the page
`<body>` tag based on the entity being viewed. It adds a new **"Body CSS class(es)"**
field to entities, and whatever value is entered there is output as a class on the
`<body>` element of that entity's page. Themes can then target styling by page
without any custom preprocessing — for example giving one specific node a special
layout, or flagging a landing page so its hero styles kick in.

The field is available on **all entity types that have canonical routes** — nodes,
taxonomy terms, users, comments, media, and so on — since those are the ones with a
page whose `<body>` the class can attach to. The field supports **tokens**, so you
can build classes dynamically, and it runs a validation callback that filters values
against XSS before they reach the markup.

The module works as soon as it is enabled — the base field is added automatically —
but there are a couple of things you will usually want to configure: which roles can
see and edit the field, and (optionally) default class values. It also lets you hide
the field from an entity's form by moving it to the disabled region on that bundle's
*Manage form display*. It works on Drupal 8.8 and later and has no module
dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set default values, control the field's
   visibility, and grant the two permissions.

## Where it lives in the admin menu

The settings page for default values is at **Configuration → Content authoring →
Body class settings** (`/admin/config/content/body-class-settings`). The field
itself appears on each entity's edit form, and you control its placement per bundle
from **Structure → (entity type) → (bundle) → Manage form display**.
