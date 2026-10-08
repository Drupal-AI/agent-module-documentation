<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Kit (layout_builder_kit) — agent index

Seven ready-made **`@Block` components** for core **Layout Builder** (also usable in Block Layout).
Provides **no `@Layout` plugins and no section styles** — it is a block/component library. Depends on
`layout_builder` and **`hook_event_dispatcher`** (`core_event_dispatcher`, 4.x). Version
**3.0.0-beta2**; core `^10 || ^11`. Settings at
`/admin/config/content/layout_builder_kit/settings`; permission `access layout builder kit components`
(`restrict access: true`) gates only that form. Block placement is gated by core Layout Builder
permissions, not by this module.

## The seven components (all extend `LBKBaseComponent`)

| Admin label | Plugin id | Purpose | Needs |
|---|---|---|---|
| Rich Text (LBK) | `lbk_rich_text` | A `text_format` (CKEditor) body rendered via `processed_text`. | — |
| Image (LBK) | `lbk_image` | Managed-file image, optional image style, alignment, rich-text overlay. | — |
| Icon Text (LBK) | `lbk_icon_text` | Image beside rich text, media left/right, optional link URL. | — |
| Video (LBK) | `lbk_video` | YouTube/Vimeo URL (typed or read from an entity field) → embed `<iframe>`. | — |
| Render (LBK) | `lbk_render` | Renders a chosen node or media entity by a selected view mode. | `media` (for media) |
| Tab (LBK) | `lbk_tab` | Unlimited tabs, each rich text or a rendered content/plugin block. | — |
| Book Navigation (LBK) | `lbk_book_navigation` | Sibling + next-section navigation for core Book nodes. | `book` |

`hook_requirements()` emits an INFO status-report notice when `book` or `media` is absent.

## Shared configuration surface (from `LBKBaseComponent`)

Every component's config form adds: **Title** (required text), **Display title** (checkbox), and a
free-text **CSS class** field (`classes`, maxlength 64) added to the component's wrapper `<div>`.
`LBKBaseComponent` is a hand-rolled re-implementation of `BlockBase`'s form/config handling; it does
**not** add Layout Builder's usual block visibility conditions.

## How templates are registered

Components do **not** ship `hook_theme()`. Each has an `*EventSubscriber` that listens to the Hook
Event Dispatcher `hook_event_dispatcher.theme` event and calls `addNewThemes()` to register its Twig
template (`LBKRichText`, `LBKImage`, `LBKIconText`, `LBKVideo`, `LBKRender`, `LBKTab`,
`LBKBookNavigation`). This is the reason for the `hook_event_dispatcher` dependency. Per-component CSS
(and JS for Tab and Render) is attached via libraries in `layout_builder_kit.libraries.yml`.

## Settings & config

- Route `layout_builder_kit.layout_builder_kit_settings` → `LayoutBuilderKitSettingsForm`
  (`/admin/config/content/layout_builder_kit/settings`): **image upload location** and **allowed
  image extensions** used by the Image and Icon Text managed-file widgets.
- Shipped config `layout_builder_kit.settings` (`image_location`, `image_extensions`; default
  extensions `gif png jpg jpeg webp`). Note: the settings form actually reads/writes a
  `layout_builder_kit.image_component` config object with prefixed keys — a known config-naming
  mismatch, functional not security-relevant.

## Details

- `blocks/components.md` — per-component field lists, stored config keys, template variables, and the
  Video URL → embed rewriting logic.

## Adoption trade-offs (same as the EPT paragraph family)

- Prebuilt components are quick to adopt but **awkward to diverge from** — markup and settings are the
  module's; anything the options don't cover means template overrides, at which point local blocks
  are often cheaper.
- **Components become a dependency of the content** — pages are built from them, so removing the
  module later leaves sections referencing blocks that no longer exist.
- Project is **minimally maintained, no further development**; not covered by the security advisory
  policy (beta release).
