# Configuration

Block Styles has no central settings page. You apply a style to each block
individually, on that block's own configuration form. Your choice is saved as an
exportable config entity tied to the block.

## Apply a style to a block

1. Edit a placed block — for example go to **Structure → Block layout**
   (`/admin/structure/block`) and click **Configure** on any block. (The same
   section appears on any block configuration form, including in Layout Builder.)
2. Open the **Block Styles Template** fieldset (it is collapsed by default).
3. Set the options:
   - **Select block style** — pick from the available styles. These are the Styles
     API styles of type "block": the bundled **Clean Wrapper**, plus any others you
     have enabled such as the Bootstrap styles. Choose **None** to leave the block
     with its default markup.
   - **Text for button label** — this field is only active for *interactive* styles
     whose definition declares a button label (the Bootstrap modal, collapse,
     dropdown, and popover styles). It becomes the label of the button that triggers
     the interaction.
   - **Add classes to block wrapper** — a space-separated list of CSS classes added
     to the block's wrapper element, for example `is-featured border` or
     `bg-light p-3`.
4. **Save the block.** It re-renders using the chosen template with your classes
   applied.

## Where your choice is stored

Each configured block gets its own `block_styles` config entity named
`block_styles.blocks.<block_id>`, holding the selected style (`theme`), the CSS
classes (`classes`), and the button label (`text`). Because it is configuration, it
exports and deploys with the rest of your site config. The exact structure and a
scriptable example are in the [`agent/`](../agent/start.md) docs.

## A note on theme-provided styles

A style can be registered by a module or by a theme. If a style is provided by a
**theme**, it only applies while that theme is active — Block Styles skips
theme-provided styles under other themes. Styles registered by a **module** (like
Clean Wrapper and the Bootstrap submodule's styles) apply site-wide.

## Adding your own styles

You are not limited to the bundled styles. A developer can register a new block
style by shipping a `*.themes.yml` entry with `type: block` plus a matching
`block--*.html.twig` template — no PHP needed. Once registered, it shows up in the
**Select block style** dropdown automatically. See the
[`agent/`](../agent/start.md) docs for the `*.themes.yml` format and template
naming.
