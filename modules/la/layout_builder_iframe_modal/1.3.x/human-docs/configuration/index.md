# Configuration

Layout Builder iFrame Modal works out of the box — all ten built-in Layout Builder
routes open in the iframe modal by default, so this page is about *narrowing* or
*extending* that list rather than turning anything on.

## Open the settings form

1. Log in as a user with the **Configure layout builder iframe modal** permission
   (an administrator has it by default).
2. Go to **Configuration → Content authoring → Layout Builder iFrame Modal**, or
   navigate directly to `/admin/config/content/layout_builder_iframe_modal`.

## Built-in Layout Builder routes

The main section of the form is a set of **checkboxes**, one per built-in Layout
Builder route. Tick a route to open its form in the iframe modal; untick it to
leave that form using core's default off-canvas tray. All ten are checked on a
fresh install:

- `layout_builder.configure_section` — Configure section
- `layout_builder.remove_section` — Remove section
- `layout_builder.remove_block` — Remove block
- `layout_builder.add_section` — Add section
- `layout_builder.add_block` — Add block
- `layout_builder.update_block` — Update (inline) block
- `layout_builder.move_sections_form` — Reorder sections
- `layout_builder.move_block_form` — Move block
- `layout_builder.translate_block` — Translate block (`layout_builder_st`)
- `layout_builder.translate_inline_block` — Translate inline block (`layout_builder_st`)

For example, you might enable the modal for only *Add block* and *Update block*
while leaving the rest in the tray — just untick the others.

## Custom routes

Below the checkboxes is a **Custom routes** textarea, one route name per line. Use
it to opt an additional dialog route into the iframe treatment.

Important caveat: adding a route here only rewrites its existing dialog to an
iframe — the route must *already* be configured to open in a dialog (it needs a
`data-dialog-type`), and it may need extra code to work fully. This field is for
advanced, Layout-Builder-adjacent routes, not for arbitrary pages.

## The permission

A single permission controls this form:

- **Configure layout builder iframe modal** (`configure layout builder iframe
  modal`) — a restricted permission that gates the settings form only. It does
  *not* affect who can use Layout Builder itself.

## Save and clear caches

Click **Save configuration**. Because the module rewrites contextual links and
preprocesses pages based on this config, run `drush cr` (or clear caches from the
admin UI) after changing the route lists so the new selection takes effect.

## Deploying between environments

The two lists live in one exportable config object,
`layout_builder_iframe_modal.settings`, so they move with your normal config
workflow:

```bash
drush config:get layout_builder_iframe_modal.settings   # read the whole object
drush config:export                                     # capture your route choices
drush config:import                                     # apply them elsewhere
```

Both keys (`layout_builder_iframe_routes` and `custom_routes`) are lists, which are
awkward to set one line at a time on the command line, so if you script changes,
prefer `drush php:eval` or editing the exported YAML — see the
[agent configuration doc](../../agent/configure/settings.md) for ready-made
recipes.

## Theming the iframe

The iframe element and the success/redirect page are both themeable. The module
adds a `layout-builder-iframe-modal` body class inside the iframe (target it from
your admin-theme CSS), and you can override the `lbim-iframe.html.twig` template or
set iframe attributes (width, height, class) from a theme preprocess. See the
[agent theming doc](../../agent/theming/templates.md) for details.
