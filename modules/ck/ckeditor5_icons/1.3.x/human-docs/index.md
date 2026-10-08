# CKEditor 5 Icons — manual setup guide

**CKEditor 5 Icons** (`ckeditor5_icons`) adds an **Icons** button to the CKEditor 5
toolbar that opens a searchable **Font Awesome** icon picker, so editors can find
and insert an icon ("cart", "phone", "heart") inline in their text without touching
Source view. The chosen icon goes in as a simple `<i>` tag with Font Awesome
classes, and a little balloon toolbar then lets the editor resize it, change its
style, or float it left or right — all from the editor.

Everything is configured **per text format**. On each format you decide which Font
Awesome **version** to target (6 or 5), which **styles** the picker offers (Solid,
Regular, Brands, and — on a Pro setup — Light, Thin, Duotone, and custom Kit
icons), whether to load the icon catalogue **asynchronously** (recommended, so the
large catalogue only loads when the picker opens), and whether to pin a short
list of house‑style icons into a **Recommended** category at the top. You can offer
the full picker on *Full HTML* and leave *Basic HTML* icon‑free. It even updates a
restricted format's allowed‑HTML list so the `<i class>` markup survives filtering.

> **One crucial requirement:** this module supplies the *picker* and the *markup*,
> but it does **not** load the Font Awesome CSS on your front end. The Font Awesome
> library must already be present on your site — via your theme, a CDN include, or
> the contrib [Font Awesome](https://www.drupal.org/project/fontawesome) module —
> and its major version must match the version you pick here. Without it, inserted
> icons render as blank boxes.

There's **no site‑wide settings page** (`configure: null`), so this guide has no
separate configuration page; the "How to use it" section below covers the setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and make sure Font Awesome CSS is present.

## Where it lives in the admin menu

CKEditor 5 Icons adds **no admin page of its own**. You configure it while editing
a text format at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

1. Go to **Text formats and editors** (`/admin/config/content/formats`) and
   **Configure** a format whose editor is **CKEditor 5** (for example *Full HTML*).
2. Drag the **Icons** button from *Available buttons* into the *Active toolbar*.
3. An **Icons** settings tab appears below the toolbar. Set:
   - **Font Awesome version** — 6 (default) or 5. This decides both which icon set
     is offered and the class flavour emitted. Match this to the Font Awesome CSS
     your site actually loads.
   - **Styles** — which style tabs the picker shows (Solid, Regular, Brands by
     default). Pro‑only styles (Light, Thin, Duotone, custom Kit) require a Pro
     setup; the form rejects styles that don't match the chosen version.
   - **Load metadata asynchronously** — leave on (the default) so the big icon
     catalogue loads only when the picker opens, keeping page weight down.
   - **Recommended category** — optionally turn on a "Recommended" group and list a
     few icon names (without the `fa-` prefix) to surface your most‑used icons at
     the top of the picker.
   - **Custom metadata** — only available, and only tick it, if you have the
     contrib Font Awesome module installed (this is how you use Font Awesome Pro or
     a custom Kit).
4. **Save configuration**.

Editors using that format now see the **Icons** button. Note that removing the
button from the toolbar also drops its settings on the next save — the plugin is
only active while its toolbar button is present.
