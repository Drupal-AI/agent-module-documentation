# Languages Dropdown — manual setup guide

**Languages Dropdown** (`languages_dropdown`) renders the language switcher as a
single **dropdown** control instead of a row of links. Core's switcher prints
every enabled language as a link, which is the right presentation for two or three
languages and unmanageable at fifteen — a European institution's site, a global
product site, or anything with many regional variants. A dropdown collapses that
list to one control that fits in a header without pushing your navigation onto a
second row. Options can be shown as **country flags and/or language labels**,
using the Bootstrap Languages library.

This is a finished, extended Drupal 10/11 continuation of the old D7 *Bootstrap
Languages* module. It depends on core's **Language** module and requires the
Bootstrap Languages front‑end library (see [Installation](installation/index.md)).
It is placed as an ordinary block, so its visibility and region are handled
through Block layout like any other block, and you can place it more than once.

A few accessibility points are worth checking, because they are easy to get wrong
with a dropdown and they are the difference between a switcher that works for its
audience and one that frustrates them: each option should carry its **`lang` and
`hreflang`** attributes so assistive technology announces language names in their
own language rather than mispronouncing them in the page's; the control needs an
**accessible label**, since an unlabelled select of language names is ambiguous;
and if the dropdown navigates the moment you change the selection rather than on an
explicit submit, that change‑of‑context can catch keyboard users mid‑selection —
a submit button or confirmation avoids it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the
   Bootstrap Languages library, and enable it.
2. [Configuration](configuration/index.md) — placing the block and choosing flags
   vs labels.

## Where it lives in the admin menu

Languages Dropdown adds no admin settings page. You place and configure its block
under **Structure → Block layout** (`/admin/structure/block`) — look for
**Languages Dropdown (Bootstrap)**.
