<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Ck5BlockEmbed CKEditor 5 plugin, dialog, and preview

## Registration
- `ck5_block_embed.ckeditor5.yml` defines base id `ck5_block_embed_ck5BlockEmbed`:
  - `ckeditor5.plugins: [ck5BlockEmbed.Ck5BlockEmbed]` (the JS global from
    `js/build/ck5BlockEmbed.js`).
  - `drupal.deriver: \Drupal\ck5_block_embed\Plugin\Deriver\Ck5BlockEmbedDeriver`.
- `Ck5BlockEmbedDeriver::getPluginDefinition()` supplies the real Drupal metadata (the `.ckeditor5.yml`
  is a thin shell): `class` `\Drupal\ck5_block_embed\Plugin\CKEditor5Plugin\Ck5BlockEmbed`, library
  `ck5_block_embed/ck5_block_embed`, admin library `ck5_block_embed/admin`, toolbar item
  `ck5BlockEmbed__default` (label "Embed Block"), `conditions: { filter: ck5_block_embed }`, and
  allowed elements:
  - `<ck5-block-embed>`, `<ck5-block-embed-inline>`
  - `<ck5-block-embed data-plugin-config data-plugin-id data-button-id>` (and the inline variant)
- It derives a single `:default` derivative.
- `ck5_block_embed.libraries.yml` → `ck5_block_embed` = `js/build/ck5BlockEmbed.js` (minified) +
  `css/ck5_block_embed.css`, depending on `core/ckeditor5`, `core/ckeditor5.essentials`,
  `editor/drupal.editor.dialog`, `core/drupal.dialog.off_canvas`. A second `admin` library carries
  `css/ck5_block_embed.admin.css`.

## PHP plugin: `src/Plugin/CKEditor5Plugin/Ck5BlockEmbed.php`
- Extends `CKEditor5PluginDefault`, implements `ContainerFactoryPluginInterface`; injects
  `entity_type.manager` and `csrf_token`.
- `getDynamicPluginConfig()` builds `ck5BlockEmbed` editor config:
  - `previewUrl`: `Url::fromRoute('ck5_block_embed.preview', {editor})` with a CSRF `token` query
    param computed as `csrfTokenGenerator->get($url->getInternalPath())`.
  - `buttons.default`: label "Embed Block", `iconUrl` (route
    `ck5_block_embed.ck5_block_embed_button.icon`), `dialogUrl` (route `ck5_block_embed.dialog` with
    `ck5_block_embed_button=default` and the format id), and `dialogSettings` (600px, auto height,
    modal).

## JS
- Source lives in `js/ckeditor5_plugins/ck5BlockEmbed/src/` (`index.js`, `editing.js`, `command.js`,
  `ui.js`, `toolbar.js`, `utils.js`); the shipped build is `js/build/ck5BlockEmbed.js`.
- The plugin registers the toolbar button, opens `dialogUrl` in a Drupal dialog, and on
  `editor:dialogsave` inserts the `ck5BlockEmbed` (or `ck5BlockEmbedInline`) model element with the
  saved `data-plugin-id` / `data-plugin-config` / `data-button-id` attributes. The widget calls
  `previewUrl` (POST, CSRF token) to render a live preview of the chosen block inside the editor.

## Dialog form: `src/Form/Ck5BlockEmbedDialogForm.php`
- Route `ck5_block_embed.dialog`; `checkAccess()` = `AccessResult::allowedIfHasPermission($account,
  'use ck5 block embed button')`.
- Lists the available embed plugins via `plugin.manager.ck5_block_embed->getDefinitions()` — no
  per-button filtering, so all three (`content_block`, `view_block`, `theme_block`) are offered.
  When more than one exists it shows a "Block category" select; the chosen plugin's
  `buildConfigurationForm()` is embedded as a subform (via `SubformState`).
- On AJAX submit (`ajaxSubmitForm`): instantiates the plugin, calls `massageFormValues()`, and
  returns an `EditorDialogSave` command whose `attributes` are
  `data-plugin-id`, `data-plugin-config` (`Json::encode` of the subform values), and
  `data-button-id=default`. Element name is `ck5BlockEmbed` or `ck5BlockEmbedInline` per
  `isInline()` (all three shipped plugins return `FALSE`).
- `submitForm()` is a no-op; the insert happens entirely through the AJAX callback.

## Preview controller: `src/Controller/Ck5BlockEmbedPreviewController.php`
- Route `ck5_block_embed.preview`; `checkAccess()` = permission `use text format {format}` (derived
  from the `{editor}`), plus `_csrf_token: TRUE`.
- `preview()` reads a JSON body `{plugin_id, plugin_config}`, applies `Xss::filter()` to both,
  `createInstance($plugin_id, Json::decode($plugin_config))`, calls `->build()`, and returns the
  rendered HTML as a raw `Response`.

## Icon controller: `src/Controller/Ck5BlockEmbedIconController.php`
- Route `ck5_block_embed.ck5_block_embed_button.icon`; `checkAccess()` returns
  `AccessResult::allowed()` (public). `build()` returns the static `icons/Ck5BlockEmbed.svg` with
  `Content-Type: image/svg+xml`. The `{ck5_block_embed_button}` path arg is not used by `build()`.
  (`buildAdminCss()` exists but is unreferenced by any route and references an undefined variable.)

## Module hook
`ck5_block_embed.module` implements `hook_editor_js_settings_alter()` and unsets the
`ck5BlockEmbed__default` toolbar item from every format's editor settings when the current user
lacks `use ck5 block embed button`. This is client-config gating only — it hides the button, it does
not by itself stop rendering of already-embedded elements.
