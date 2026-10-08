# Flexible List Options — manual setup guide

**Flexible List Options** (`flo`) adds a CKEditor 5 toolbar button that lets
content editors choose the **numbering style** of an ordered list — alphabetical
(A/a), numeric (1), or Roman numerals (I/i) — combined with bracket formatting
(plain period, right parenthesis, or both parentheses). That gives 15 style
options in all, and each **indentation level** of a nested list can carry its own
style — for example Roman numerals at the top level, lowercase letters at the
second, numbers at the third.

Out of the box CKEditor 5 in Drupal only offers plain numbered and bulleted lists.
This module fills the gap for content where precise list formatting matters — legal
documents, academic writing, government regulations, technical documentation. A
single toolbar button opens a grouped dropdown with visual previews of each style
(for example "A. B. C.", "i) ii) iii)", "(1) (2) (3)"). Styles are applied as CSS
classes on the `<ol>` element, producing clean, semantic HTML that works with
assistive technology, and the front-end stylesheet is attached only on pages that
actually use the plugin.

The plugin is vanilla JavaScript with no build step — you just enable the module
and add its button to a text format's toolbar. There is no separate settings
form; the setup lives entirely in the CKEditor 5 toolbar configuration of the text
formats you choose.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — setup happens in a text
format's CKEditor 5 toolbar, described in "How to use it" below.

## Where it lives in the admin menu

Flexible List Options adds no admin page of its own. You configure it from
**Configuration → Content authoring → Text formats and editors**, by adding its
button to a CKEditor 5 toolbar.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit a text format that uses **CKEditor 5** (for example **Full HTML**).
3. Under **Filters**, make sure **General HTML Support (GHS)** is enabled and that
   `<ol class>` is allowed — this lets the CSS classes the plugin adds survive the
   HTML filter. Without it, the styling will be stripped on save.
4. In the CKEditor 5 toolbar configuration, drag the **List Style per Level**
   button into your active toolbar.
5. Save the text format.

Editors will now see the list-style button whenever they edit content with that
format. Place the cursor inside any ordered list, click the button, and pick a
style — apply a different style at each indentation level as needed.

> **Complementary module:** if you also want *unordered* list style options (disc,
> circle, square), the **CKEditor 5 List** module pairs well with this one.
