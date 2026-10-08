<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite — content model (bundle fields, media types, field type, node type)

## The bundle-field system (`vlsuite_bundle_field`)

Rather than exporting dozens of `field.storage` configs, VLSuite defines its component fields as
**code-declared bundle fields**. `vlsuite_bundle_field_entity_field_storage_info()` (a
`hook_entity_field_storage_info()` impl) registers all block bundle field *storages* against the
provider module `vlsuite_bundle_field`, via `VLSuiteBundleFieldStorageDefinitions`. Individual
bundle classes then attach the field *definitions* by using the matching trait from
`vlsuite_bundle_field/src/BundleField/`:

- `VLSuiteBundleFieldStringTrait`, `…TextTrait`, `…CtaTrait`, `…DateTrait`
- `…ImageTrait`, `…IconTrait`, `…IconFontIconTrait`, `…BackgroundTrait`
- `…MediaTrait`, `…MediasTrait`, `…LocalVideoTrait`, `…RemoteVideoTrait`
- `…AttachmentsTrait`, `…ParagraphTrait`, `…WebformTrait`

Storages are installed/removed with the provider module, so any bundle field can be reused across
bundles without each component module having to declare storage. Optional field types that need a
contrib module (webform, paragraph) are wired in that submodule's own
`*_entity_field_storage_info()` (see comments in `vlsuite_bundle_field.module`).
`vlsuite_bundle_field.helper` (`VLSuiteBundleFieldHelper`, args `@entity.definition_update_manager`,
`@entity_type.manager`) applies the definition updates.

## Media types (`vlsuite_media` + submodules)

Five media bundles, each a `media.type.*` optional config; every media submodule depends on
`vlsuite_media` + `vlsuite_bundle_field`:

| Media type | Submodule | Source |
|---|---|---|
| `vlsuite_image` | `vlsuite_media_image` | core image |
| `vlsuite_document` | `vlsuite_media_document` | core file |
| `vlsuite_icon` | `vlsuite_media_icon` | icon |
| `vlsuite_local_video` | `vlsuite_media_local_video` | core file/video |
| `vlsuite_remote_video` | `vlsuite_media_remote_video` | **`source: oembed:video`** |

`vlsuite_remote_video` is a standard **core oEmbed media type**: source `oembed:video`, source field
`field_media_oembed_video`, thumbnails under `public://oembed_thumbnails/…`. URL fetching, provider
validation and thumbnail download are handled entirely by Drupal core Media's oEmbed system — the
submodule adds no custom remote fetching. `vlsuite_media.settings` (`bg_types`, `media_types`)
controls which of these may be used as backgrounds / offered in the UI.

## Icon-font field (`vlsuite_icon_font`)

A real custom field, plus a Twig helper:

- Field type `vlsuite_icon_font_icon` (`VLSuiteIconFontIconItem`, storage extends string).
- Field widget `vlsuite_icon_font_icon` (`VLSuiteIconFontIconWidget`) — autocompletes icon class
  names via route `vlsuite_icon_font.autocomplete` (`/vlsuite/icon-font/autocomplete`), matching the
  newline `list` from `vlsuite_icon_font.settings`.
- Field formatter `vlsuite_icon_font_icon` (`VLSuiteIconFontIconFormatter`).
- Twig extension service `vlsuite_icon_font.twig_extension` (`VLSuiteIconFontTwigExtension`) exposes
  the icon markup to templates; `VLSuiteIconFontHelper` resolves `main_classes`/`replacement`.

## Landing node type & text format

- `vlsuite_landing` installs node type **`vlsuite_landing`** (Layout Builder enabled, with the
  `vlsuite_full_content_top` / `vlsuite_full_content_bottom` view modes wired by the parent's
  `hook_entity_view_alter()`). It hard-depends on `layout_builder_restrictions`, `layout_builder_at`
  (asymmetric translations) and the core `vlsuite_block_*` set. Submodule
  `vlsuite_landing_content_editor` layers the content-editor role/config.
- `vlsuite_format` installs the `vlsuite_basic_html` CKEditor 5 format that permits `id` on
  headings — the prerequisite for the Headings Menu block's in-page anchors.

## Uninstall safety

Every content-bearing submodule registers a `*UninstallValidator` service (tagged
`module_install.uninstall_validator`) extending the abstract
`Drupal\vlsuite\VLSuiteUninstallValidator`. Each subclass sets `ENTITY_TYPE`, `BUNDLE_KEY`,
`BUNDLE`, and blocks uninstall while any entity of that bundle still exists — preventing a piece
being pulled out from under live content/layouts.
