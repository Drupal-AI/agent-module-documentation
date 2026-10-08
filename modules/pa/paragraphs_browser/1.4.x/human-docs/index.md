# Paragraphs Browser — manual setup guide

**Paragraphs Browser** (`paragraphs_browser`) replaces the default Paragraphs
"add" experience with a visual, modal **browser**. Instead of a plain dropdown or
a row of buttons, editors get a pop‑up dialog that lists the available paragraph
types organised into filterable groups, each type optionally showing a preview
image and a short description. On sites with dozens of paragraph types — layouts,
banners, galleries, text, media — this turns "which one was that again?" into a
quick, recognisable pick.

You define one or more **Browser Types** (a configuration entity) at
**Structure → Paragraph Types → Manage Browsers**. Each browser holds an ordered
set of **Groups** (for example Layouts, Media, Text), and you assign paragraph
types to those groups per browser. Because the assignment lives on the browser,
the same paragraph types can be organised differently for different fields — a
"Layouts" browser on the main content field, a "Media" browser on a sidebar
field. Each browser card shows the paragraph type's own **description** and a
**preview image** you set on the paragraph type.

The browser is a **field widget**, so you switch it on per field in **Manage form
display** and pick which Browser Type it uses. The module ships two widget
variants — "Paragraphs Browser (stable)" and "Paragraphs Browser Legacy" — for
the newer and legacy Paragraphs widgets respectively. It depends on the
**Paragraphs** module, and administering browsers and groups is gated by the core
Paragraphs "administer paragraphs types" permission. Two Twig templates let you
restyle the browser and its cards.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the config entity
structure, routes, and theming hooks — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer (and
   its Paragraphs dependency) and enable it.
2. [Configuration](configuration/index.md) — create browsers and groups, assign
   paragraph types, set preview images, and switch the widget on for a field.

## Where it lives in the admin menu

Browsers are managed under **Structure → Paragraph Types → Manage Browsers**
(`/admin/structure/paragraphs_type/browsers`). Each paragraph type gains a
**Configure Groups** tab, and each type's edit form gains a **Paragraphs Browser
Settings** fieldset for its preview image. You turn the widget on from a content
type's **Manage form display**.

## How to use it

Enable the module, build a Browser Type with a few groups, assign your paragraph
types to those groups, add preview images, and finally set a Paragraphs field's
form‑display widget to a Paragraphs Browser widget pointing at that browser. The
full step‑by‑step is on the [Configuration](configuration/index.md) page.
