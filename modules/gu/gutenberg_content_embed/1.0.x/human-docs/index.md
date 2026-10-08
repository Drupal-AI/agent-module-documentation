# Gutenberg Content Embed — manual setup guide

**Gutenberg Content Embed** (`gutenberg_content_embed`) adds a block to the
[Gutenberg](https://www.drupal.org/project/gutenberg) editor that lets editors
**search for and embed existing Drupal nodes** inside a Gutenberg-authored page.
The embedded node is rendered live in a view mode you choose (teaser, full, or a
custom mode), so the embed always reflects the current content — it is not a copy.

This is ideal for landing and promo pages: pull an existing team member, product,
or event node into a Gutenberg layout instead of duplicating its content. You
control, **per content type**, which view modes may be embedded and which offer
width/alignment controls in the editor. Node view access is respected both in the
editor preview and on the front end.

The module has **no standalone settings page**. Its configuration is added directly
to each content type's edit form, under the *Gutenberg experience* settings, and it
adds no permissions of its own — access is governed by Gutenberg's own **Use
Gutenberg** permission.

This guide is written for a **human** setting this up in the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it requires the
   Gutenberg module) and enable it.
2. **Enabling content for embedding & using the editor block** — below on this
   page (there is no separate settings page).

## Where it lives in the admin menu

There is no dedicated page. The per-content-type options appear on each type's edit
form at **Structure → Content types → *(your type)* → Edit**, under the **Gutenberg
experience → Allowed Content** section (visible only when the Gutenberg experience
is enabled for that type).

## How to use it

### 1. Decide which content is embeddable (per content type)

1. Edit a content type at **Structure → Content types → *(your type)*** that has the
   Gutenberg experience enabled.
2. In the **Gutenberg experience → Allowed Content** section, set:
   - **Allowed view modes** — check the view modes in which this type may be
     embedded. A view mode must be checked here for the type to appear as
     embeddable in the editor. If none are checked, that type is not embeddable.
   - **Width control** — check the view modes that should offer alignment/width
     controls when embedded.
3. Save the content type.

### 2. Embed content while editing a Gutenberg page

1. Edit a Gutenberg-enabled page as a user with the **Use Gutenberg** permission.
2. Add the **Drupal content embed** block.
3. Search for a node by title (only published nodes you can view are returned),
   pick one, and choose the view mode to render it in.
4. If width control is allowed for that view mode, set the alignment/width.

On the front end, the block renders the referenced node live through the view
builder — wrapped in `content-embed` CSS classes you can style — and re-checks node
view access at render time.

> **Note for developers:** the allowed-view-modes list constrains the **editor UI**;
> the underlying render endpoints honor whatever view mode is requested (still gated
> by node view access). See the sibling [`agent/`](../agent/api/endpoints.md) docs.
