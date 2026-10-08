# EBT Basic Button — manual setup guide

**Extra Block Types (EBT): Basic Button** (`ebt_basic_button`) gives site builders a
reusable **button block** they can drop into Layout Builder or the block library and
style in a few clicks — no CSS required. Each button block has a link field and a rich
"Block settings" panel where an editor picks the button's colours (including hover
colours), alignment, shape, size, whether it stretches full-width, and any custom
classes. It's designed for call-to-action buttons: create one in the block library and
reuse it, or add it inline while building a layout.

It's one module from the **Extra Block Types (EBT)** family, so it depends on
**`ebt_core`** (which holds the shared button/colour machinery and the site-wide
defaults), the **Paragraphs** module, and core **Link**. Installing it creates a
`block_content` bundle called *EBT Basic Button* with two fields: a Link field for the
button target and text, and an EBT settings field edited through a styled-button
widget.

There is **no settings page of its own** (`configure` is null) and **no permissions of
its own** — placing and creating button blocks uses core's normal block-content and
Layout Builder permissions. The one place site-wide defaults live is **EBT Core's**
settings (for example the default button background colour), at **Configuration →
Content authoring → Extra Block Types (EBT) settings**. Everything else is configured
per button, right on the block, and the styling you choose is emitted as scoped inline
CSS for that block so it never touches a global stylesheet.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and note the EBT Core dependency.

## Where it lives in the admin menu

There's no dedicated form for this module. You create button blocks at **Content →
Block library → Add content block → EBT Basic Button**, or add an inline block in
Layout Builder. Site-wide colour and breakpoint defaults are in **EBT Core** at
**Configuration → Content authoring → Extra Block Types (EBT) settings**
(`/admin/config/content/ebt-settings`).

## How to use it

1. **Create a button block** — go to **Content → Block library → Add content block →
   EBT Basic Button** (or add an inline EBT Basic Button block directly in Layout
   Builder).
2. **Set the link** — fill in the button's URL and link text in the Link field.
3. **Style it** in the "Link options" panel of the block form. The available settings:

   | Setting | What it does |
   |---|---|
   | **Open in new tab** | Opens the link in a new browser tab. |
   | **Add nofollow** | Adds `rel="nofollow"` to the link (useful for sponsored/external links). |
   | **Title Color** | The button's text colour (default white). |
   | **Background Color** | The button's background (defaults to the site-wide colour set in EBT Core). |
   | **Custom hover colors** | Toggle on to reveal separate hover title and hover background colour fields. |
   | **Alignment** | Left, center, or right within the block. |
   | **Shape** | Square, rounded, or circle. |
   | **Size** | Small, medium, or large. |
   | **Stretched** | Makes the button fill the container width. |
   | **Custom class name** | Add your own CSS class for bespoke styling. |

   Colour and class inputs are validated, so editors get safe, sane values.
4. **Place the block** where you want it — in a region, or in a Layout Builder layout.
   The colours you chose are rendered as inline CSS scoped to that one block.

## Site-wide defaults (EBT Core)

Primary/secondary colours and the mobile/tablet/desktop breakpoints are set once in
**EBT Core** at `/admin/config/content/ebt-settings` and act as defaults across all EBT
blocks — for example the default button background colour above. Set your brand colours
there and individual buttons inherit them unless overridden.

## Theming

To customise the markup, override the button's Twig templates in your theme
(`block--block-content--ebt-basic-button.html.twig` for library blocks,
`block--inline-block--ebt-basic-button.html.twig` for inline Layout Builder blocks), or
restyle via the module's front-end CSS or the block's *Custom class name*. See the
sibling [`agent/`](../agent/start.md) docs for the template variables.

## Troubleshooting

If the Field Layout module forces Layout Builder onto this block type, disable it at
the block type's *Manage display*
(`/admin/structure/block/block-content/manage/ebt_basic_button/display/default`).
