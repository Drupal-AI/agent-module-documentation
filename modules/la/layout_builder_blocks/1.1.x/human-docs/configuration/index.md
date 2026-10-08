# Configuration

The module's own settings form does two things: it decides **which style controls**
editors may use in the Style tab, and it can **restrict which blocks** show the
Style tab at all. Everything else — the actual colors, spacing values, and other
options behind each control — is defined by the Bootstrap Styles module.

## Open the settings form

1. Log in as a user with the **Configure bootstrap layout builder** permission
   (this permission comes from the Bootstrap Styles module).
2. Go to **Configuration → Content authoring → Layout Builder Blocks**, or navigate
   directly to `/admin/config/layout-builder-blocks/styles`.

## Choose which style controls editors get

The form lists the Bootstrap Styles plugins you can offer in the block Style tab.
Tick the ones editors should be able to use and untick the rest:

- **Background color** and **Background media**
- **Text color** and **Text alignment**
- **Padding** and **Margin** (spacing)
- **Border**
- **Box shadow**
- **Scroll effects** (animation)

Only the controls you enable here appear in the Style tab, which is a good way to
keep the editor experience focused (for example, allow background color and
spacing but not animation).

## Restrict which blocks can be styled (optional)

By default **every** block placed in Layout Builder gets a Style tab. If you would
rather only certain blocks be styleable, use the **block restrictions** option to
build an allow-list:

- Pick specific **block plugins** (for example the *Powered by* block or *Site
  branding* block), and/or
- Pick specific **custom block types**. Selecting a custom block type covers both
  inline blocks of that type and reusable blocks of that type.

Leave the list empty to allow styling on all blocks. Add one or more entries to
limit the Style tab to just those blocks.

## Save

Click **Save configuration**. Your choices take effect the next time an editor
opens a block form in Layout Builder.

## Where the style *content* is defined

This module only chooses *which* controls appear and *on which* blocks. The actual
options inside each control — the specific color classes, the spacing scale, the
available box-shadow values — live in the **Bootstrap Styles** module and are
managed from its own settings screen. If a color or spacing value you expect is
missing, adjust it there.

## Dashboards are excluded

The Style tab is deliberately suppressed on Dashboard layouts, so dashboard blocks
stay unstyled. A developer can override that behavior (to force the tab on or off
for a custom route) with the module's alter hook — see the sibling
[`agent/`](../agent/start.md) docs.
