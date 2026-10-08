<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Whatsapp Button (whatsapp_button) — agent index

A tiny "Social Media" module that adds **one Block plugin** rendering a floating **WhatsApp
click-to-chat button**. No dependencies beyond Drupal core; core requirement
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.x (packaged 1.0.4).
**No routes, no permissions, no services, no Drush, no config schema, no composer requirements.**

- **The block, all its settings, how the link/CSS are built, how to place & configure it** →
  [block/whatsapp-button.md](block/whatsapp-button.md)

## What it actually is

- One plugin: `WhatsappButtonBlock` (id **`whatsapp_button_block`**, admin label *"WhatsApp
  Button"*, category *"Custom"*) in `src/Plugin/Block/WhatsappButtonBlock.php`, extending
  `BlockBase` and implementing `ContainerFactoryPluginInterface`.
- Injects `extension.list.module`, `file_url_generator`, and `entity_type.manager` (for the
  `file` storage) — used to resolve the icon URL.
- All configuration is **per-block-instance** (`blockForm()` / `blockSubmit()` /
  `defaultConfiguration()`); there is **no global settings form or config object**, and **no
  `config/schema`** file ships for the block settings.
- `hook_theme()` in `whatsapp_button.module` registers theme hook
  **`whatsapp_button_template`** → `templates/whatsapp-button-template.html.twig`.
- Library `whatsapp_button/whatsapp_button_block` (`whatsapp_button.libraries.yml`) attaches
  `css/whatsapp-button-block.css`; bundled default icon `assets/WhatsApp.svg`.

## Mechanism (from source)

- `build()` resolves the icon: if a managed file is uploaded (`configuration['image'][0]`) it
  loads it via the `file` storage and generates an absolute URL with
  `fileUrlGenerator->generateAbsoluteString($file->getFileUri())`; otherwise it uses the bundled
  `default_image` (`/assets/WhatsApp.svg`) resolved against `moduleExtensionList->getPath()`.
- The render array uses `#theme => 'whatsapp_button_template'` and attaches the CSS library. The
  Twig template builds the link as
  `https://api.whatsapp.com/send?phone=<number>&text=<message>` (`target="_blank"`) and emits an
  inline `<style>` block for the bottom/right position and tablet/desktop media-query overrides.

See [block/whatsapp-button.md](block/whatsapp-button.md) for every setting key, defaults, and the
positioning/media-query behavior.
