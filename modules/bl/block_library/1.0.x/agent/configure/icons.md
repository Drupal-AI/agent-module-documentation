# Block type icons

## Where you set it
Edit any custom block content type at `/admin/structure/block-content/manage/{type}` (add or
edit form). Block Library adds an open **Icon** details section with:
- **Path to custom icon** (`icon_path` textfield) — examples: `public://hero-icon.svg`,
  `modules/custom/mymod/hero-icon.svg`, `themes/custom/mytheme/hero-icon.svg`.
- **Upload icon** (`icon_upload` file element) — validated with `file_validate_is_image`.

## How it is stored
Saved by the entity builder `_block_library_block_content_type_form_builder` as a **third-party
setting** on the `block_content_type` config entity:

```yaml
# block_content.type.{type} config
third_party_settings:
  block_library:
    icon_path: 'public://hero-icon.svg'
```

Read/write in code:
```php
$type = \Drupal\block_content\Entity\BlockContentType::load('hero');
$path = $type->getThirdPartySetting('block_library', 'icon_path');      // get
$type->setThirdPartySetting('block_library', 'icon_path', 'public://x.svg'); // set
$type->unsetThirdPartySetting('block_library', 'icon_path');            // clear
$type->save();
```
An empty path unsets the setting (no icon).

## Path resolution & upload (`_validate_path`, form builder)
- On save, if `icon_path` is filled it is validated by `_validate_path()`:
  - an **absolute local filesystem path** (where `realpath($path) == $path`) is rejected as
    invalid;
  - a path that `is_file()` (relative to Drupal root, or a valid stream URI) is accepted;
  - otherwise `public://` is prepended and `is_file()` re-checked.
  - Invalid → form error "The custom icon path is invalid."
- If a file is uploaded, `_file_save_upload_from_form()` saves it, then it is copied into the
  site default scheme (e.g. `public://`) and that resulting path becomes `icon_path`.
- Requires the core `file` module for the upload/copy branch (checked with
  `moduleExists('file')`).

## How the icon reaches the picker
`ChooseBlockController::inlineBlockList()` (route `layout_builder.choose_inline_block`, controller
swapped by `RouteSubscriber`) runs for each inline-block link:
- Loads the `BlockContentType` for the link's `inline_block:{type}` plugin id.
- If it has `icon_path`, builds a URL with `file_url_generator`.
- If `mime_content_type($icon_path)` is an `image/svg*`, reads the file
  (`file_get_contents(DRUPAL_ROOT . '/' . $icon_url)`), strips `<?xml …?>` and `<!DOCTYPE …>`,
  and inlines the raw SVG markup so `currentColor` applies. Otherwise renders `<img class="bl-block-icon">`.
- The title becomes `Markup::create($icon . '<span class="bl-block-title">…</span>')`; the list
  gets class `lb-list` and library `block_library/inline_blocks_style`.

## Trust / hardening note (not a vulnerability)
`icon_path` and the uploaded icon are set only by users who can administer block content types
(`administer block content` / `administer block types`, both `restrict access: TRUE`). The
controller inlines that admin-provided SVG verbatim (only prolog/DOCTYPE stripped, scripts not
sanitized) into the authoring-only picker. Because the source is trusted-admin config and the
render happens on an admin Layout Builder screen, this is by-design admin behavior — but keep
icon SVGs to trusted, sanitized assets, since a malicious SVG author with block-type-admin
rights could embed script that runs for other editors opening the picker.

## Notes
- No global settings page (`configure` null); each block type is configured individually.
- No config schema ships for the third-party setting; the value lives in the block type's
  config export.
