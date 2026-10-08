# DX8 AddToAny — manual setup guide

**DX8 AddToAny** (`dx8_addtoany`) is a small bridge module. It takes the social
share‑button functionality from the **AddToAny** module and makes it available as a
custom **element inside Acquia Site Studio**. Site Studio builds pages from its own
vocabulary of elements, and a share button provided by an ordinary Drupal module
isn't part of that vocabulary unless something exposes it there — this module is that
"something."

Once enabled, an **AddToAny** element appears in the Site Studio element sidebar. A
designer can drop it onto a page and choose a combination of universal and specific
social networks, the placement, and the icon size. The title and URL of the current
page are detected automatically, so there's nothing to wire up per page.

Two things are worth knowing before you reach for it. First, it **requires an Acquia
Site Studio subscription** (and the AddToAny module) — outside Site Studio it has no
purpose. Second, the `dx8_` prefix is historical: **DX8** was Site Studio's original
name, so the prefix marks a module written before the rename, which is a useful
signal when you're judging how actively something is maintained.

> **Privacy note:** AddToAny's share buttons load a **third‑party script** from
> AddToAny's own domain and can set analytics cookies. On an EU‑facing site that
> belongs behind cookie consent — bridging the buttons into Site Studio does not
> change that obligation. If your site runs a consent platform, gate these share
> buttons the same way you gate any other tracker, and document AddToAny's cookies in
> your privacy notice.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, and the Site
   Studio / AddToAny prerequisites.

There is **no standalone configuration page** for this module — you configure the
share buttons on the **AddToAny element** wherever you place it in Site Studio
(networks, placement, icon size), described in "How to use it" below.

## Where it lives

DX8 AddToAny adds no admin settings page of its own. Its one visible addition is the
**AddToAny element** in the **Site Studio element sidebar**, which you use inside the
Site Studio page‑building canvas.

## How to use it

1. Make sure Acquia Site Studio and the AddToAny module are installed and Site
   Studio is set up (see [Installation](installation/index.md)).
2. Edit a page (or component/template) in Site Studio.
3. From the element sidebar, drag the **AddToAny** element onto the canvas.
4. In the element's settings, pick which universal and specific social networks to
   offer, where the buttons sit, and the icon size.
5. Save. The page and its URL/title are detected automatically at render time.
