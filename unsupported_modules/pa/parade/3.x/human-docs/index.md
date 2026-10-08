# Parade — manual setup guide

**Parade** (`parade`) is a page‑building toolkit built on top of the
[Paragraphs](https://www.drupal.org/project/paragraphs) module. Instead of giving
you one big "page builder" screen, it hands editors a palette of reusable
Paragraph components — headers with hero text and parallax backgrounds, text‑box
"cards", location maps, call‑to‑action blocks and more — and lets them assemble
flexible landing pages and one‑page microsites section by section. It was built to
power large campaign‑site platforms where many similar marketing pages share the
same set of building blocks.

What sets Parade apart from plain Paragraphs is the authoring experience it layers
on top. It ships custom field widgets — an **inline paragraphs previewer** so you
can see each section as you edit it, a **call‑to‑action** widget and matching
formatter, and a **link‑with‑selected‑attribute** widget for links that carry a
chosen CSS class — plus integration with view‑mode selection, Field Group and
Classy Paragraphs so sections can be laid out and styled without custom theming.

Because of all that, Parade is a heavier install than most Paragraphs add‑ons: it
pulls in Paragraphs itself along with Geocoder, Geofield, Leaflet,
`view_mode_selector`, `classy_paragraphs`, `field_group` and `machine_name`. Most
of the work of using it is **content‑model work** — you build (or adjust) Paragraph
types and their displays, then editors compose pages with the preview widgets on
the node form. There is no single "Parade settings" screen for the base module;
the optional submodules are where the admin forms live.

A note on project health: at the time of writing Parade is marked *Seeking new
maintainer* with *No further development* planned, and it is not covered by
Drupal's security advisory policy. Weigh that before adopting it on a new site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Parade and its Composer
   dependencies, enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the optional submodule settings pages
   (demo content and the feature pack), and where the real "configuration" of
   Parade actually happens.

## Where it lives in the admin menu

The base Parade module adds **no settings page of its own** (`configure` is null).
You work with it in two places:

- **Structure → Paragraphs types** (`/admin/structure/paragraphs_type`) and each
  type's **Manage form display / Manage display**, where you attach Parade's
  widgets and formatters to your Paragraph fields.
- **Content → your node's edit form**, where editors add and preview sections.

The optional submodules add their own admin pages under **Configuration →
Content** — see [Configuration](configuration/index.md).

## How to use it

Parade's day‑to‑day setup is content‑model work rather than a single form:

1. Install Parade and its Composer dependencies (see
   [Installation](installation/index.md)).
2. Optionally enable `parade_demo` to load demo content that shows the components
   in action, and `parade_pack` for extra feature settings.
3. Create or adjust **Paragraph types** for your page sections. On each Paragraph
   field (an *entity reference revisions* field), choose Parade's widgets:
   - the **inline paragraphs previewer** widget for inline editing with a live
     preview,
   - the **call‑to‑action** widget (paired with the call‑to‑action formatter) for
     CTA fields,
   - the **link with selected attribute** widget for links that carry a chosen
     attribute or CSS class.
4. Use **view‑mode selection** and **Field Group** to control how each section is
   laid out, and **Classy Paragraphs** to offer editors preset styling classes so
   they stay inside your style guide.
5. Add optional behaviour with the `parade_conditional_field` submodule, managed
   per Paragraph type at
   `/admin/structure/paragraphs_type/<type>/parade-conditional-fields/add`
   (requires the *Administer paragraph types* permission).

Integration submodules — `marketo_form`, `marketo_poll`, `linkedin_autofill` and
`aggregated_leaflet_map` — add specific components (Marketo forms and polls, a
LinkedIn autofill helper, and an aggregated Leaflet map). Enable only the ones you
actually need.
