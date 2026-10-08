# IO Builder — manual setup guide

**IO Builder** (`io_builder`) is a **frontend page builder** for Drupal, built by
[iO](https://www.iodigital.com). Instead of editing content in the usual backend
node form, editors build and rearrange the page visually *on the front end* —
much like the Divi or Elementor builders in WordPress, which inspired it. Its
main focus is adding and editing Paragraphs on nodes directly in the rendered
page, but it works with any fieldable entity type (media, taxonomy terms, and so
on).

The module ships an out‑of‑the‑box integration with Paragraphs through the
**IO Builder Paragraphs** submodule (`io_builder_paragraphs`), and it is
extensible through three plugin types: **Contexts** (the bridge between the
front end and back end), **Entity Actions** (custom actions per entity type), and
**Fields** (which turn a field's build array into an IO Builder widget). Site
builders enable the module on the bundles they want, configure a builder form
display, and editors take it from there.

A note on access: editing through IO Builder is governed by the module's own
permissions **plus** the underlying entity and field edit access. A front‑end
builder should never let someone edit content they couldn't otherwise edit, so
grant its permission only to trusted editors and confirm your entity/field
permissions are correct.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it and the Paragraphs submodule.

IO Builder has **no central settings page**. You set it up per content type by
enabling the builder on a bundle and configuring an IO Builder form display,
described in "How to use it" below.

## Where it lives in the admin menu

There is no single IO Builder configuration screen. Setup happens per bundle
under **Structure → Content types → *(your type)* → Manage** and its **IO Builder
display** tab, and you place an **IO builder toggle block** from **Structure →
Block layout**.

## How to use it

1. **Enable the module** (see [Installation](installation/index.md)), including
   the `io_builder_paragraphs` submodule for Paragraphs support.

2. **Turn the builder on for a bundle.** Go to the entity type you want to make
   buildable — for example the Basic page content type at
   `/admin/structure/types/manage/page` — and enable IO Builder there. Repeat for
   every content type (or other entity bundle) that should use the builder.

3. **(Optional) Create a trimmed front‑end form.** If you want editors to see
   fewer fields while building in the front end, create a new **form display**
   with the machine name `io_builder`. IO Builder uses that form display when it
   renders the editing form.

4. **Add the toggle block.** Place the **IO builder toggle block** from
   **Structure → Block layout**. Editors use it to switch the builder on and off
   while viewing a page.

5. **Configure the Paragraphs field.** Open the IO Builder form display for your
   content type, e.g.
   `/admin/structure/types/manage/page/io-builder-display/default`. You'll see a
   list of the type's fields; for your Paragraphs field, select the **IO Builder
   paragraphs field** plugin.

6. **Expose the builder in your theme.** IO Builder needs its HTML attributes
   printed on entity wrappers, and it adds its actions to the `content` variable.
   In your Twig template, print them with `{{ content.io_builder }}` so the
   builder controls appear.

Once that's in place, an editor with the right permission can open a page, toggle
the builder on, and add or rearrange paragraphs visually.
