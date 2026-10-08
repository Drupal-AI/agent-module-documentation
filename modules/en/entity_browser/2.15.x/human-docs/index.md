# Entity Browser — manual setup guide

**Entity Browser** (`entity_browser`) is a framework for building reusable
pop-up (or inline) UIs that let editors browse, search, upload, or create
entities — most commonly media and files — and hand the selection back to a
reference field. Instead of the default autocomplete box, an editor clicks a
button, a browser opens, they pick or upload what they need, and the chosen
items drop into the field. Each browser is a reusable configuration entity you
assemble from four pluggable layers: a **display** plugin (how the browser
opens — modal, iframe, or standalone page), one or more **widget** plugins (the
selection sources, such as a Views listing or a file upload), a **widget
selector** (how you switch between widgets — tabs, a drop-down, or a single
widget), and a **selection display** (how picked items appear before you
submit).

This guide is written for a **human** clicking through the admin UI. It walks
you, step by step and with screenshots, from installing the module to building
your first browser and attaching it to a field. If you are looking for terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Entity Browsers list under Configuration → Content authoring](images/list.png)

## Where it lives in the admin menu

Entity Browser's configuration lives under **Configuration → Content authoring →
Entity browsers** (`/admin/config/content/entity_browser`). That page lists
every browser on the site and gives you an **Add Entity browser** button to
create a new one. Individual browsers are then attached to fields from the
**Manage form display** tab of the entity type (for example a content type or a
media type) whose reference field should use them.

## Contents

1. [Installation](installation/index.md) — install Entity Browser with Composer,
   enable it, and (optionally) turn on the Inline Entity Form submodule.
2. [Configuration](configuration/index.md) — the browsers list and the four
   plugin layers every browser is built from.
3. [Creating a browser](creating-a-browser/index.md) — walk through the add
   wizard and attach the finished browser to a reference field.
