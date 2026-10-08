<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Type Style (type_style) — agent index

Associates a **colour** and an **icon name** with each **entity bundle** — content type, custom
block type, media type, taxonomy vocabulary, file type, or (via submodule) workflow state. The two
values are stored as **third-party settings** on the bundle config entity; the module itself renders
**no markup or CSS**. Version **8.x-1.2**, core `^8 || ^9 || ^10 || ^11`, no dependencies.

## What it actually does

1. **Form alter** — `type_style_form_alter()` adds a "Style settings" fieldset (a `#type => color`
   picker and an `icon` textfield) to any `ConfigEntityBundleBase` edit form, plus any entity type
   returned by `hook_type_style_entity_support()`. Values save via an entity builder into
   `setThirdPartySetting('type_style', …)`. Colour is validated to `/^#[0-9a-f]{6}$/i` on submit.
2. **Read helpers** — `type_style_get_style($entity, $name, $default)` and
   `type_style_get_styles($entity)` return the stored values for a bundle or a bundleable entity.
   Both **sanitise output** with `preg_replace('/[^a-zA-Z0-9\-\_\#]/', '', …)`.
3. **Consumption surfaces** (nothing is emitted automatically — the site decides how to render):
   - **Twig function** `type_style(entity_or_type, id, style, default)` — `TypeStyleExtension`.
   - **Views fields** `type_style`, `type_style_color`, `type_style_icon` on every bundle base table
     (`type_style.views.inc` + `TypeStyle` field plugin). The colour path uses a `postRender`
     placeholder swap: put `data-type-style-color` / `data-type-style-background-color` in the row
     and it becomes `style="color: …"`.
   - **Tokens** `[<entity>:type-style-color]`, `:type-style-icon`, `:type-style-*` (`type_style.tokens.inc`).
4. **Global settings form** at `/admin/structure/type-style/settings` (route `type_style.settings`,
   permission **`administer type style`**) — the ONLY page. It just picks which icon-font library
   (`material` / `fontawesome` / `ionicons`) `hook_page_attachments()` attaches from a CDN, and a
   `use_cdn` toggle. Config: `type_style.settings` (`icon_type`, `use_cdn`). Purely a convenience;
   does not affect the store/read mechanism.

## What it is NOT

- Not a typography / type-scale tool. "Type" means **entity bundle (type)**, not font/type-scale.
- Does not inject a `<style>` block or a custom-CSS snippet. There is **no custom-CSS textarea** —
  only a hex colour and a short icon name, both sanitised. No body/article class is emitted either.

## Submodules

- **`type_style_moderation`** — same colour/icon on Content Moderation / Workbench Moderation
  **workflow states and transitions** (stored in the workflow type plugin config), plus a
  `type_style_moderation` Views field. Depends on `type_style`; works with `content_moderation` or
  `workbench_moderation`.
- **`type_style_example`** — seeds every content type with a random colour + icon on install and
  ships a demo view at `/admin/type-style-example`. Depends on `node`, `type_style`, `views`.

## Extending

- `hook_type_style_form_alter(&$form, $type)` — add more style keys (also add config schema).
- `hook_type_style_entity_support()` — return entity type IDs that should get the fieldset.

## Files

- `data.json` — metadata.
- `usage.md` — short / dense / use-case bullets.

All stored color/icon values are sanitised to `[A-Za-z0-9\-_#]` (and colors are hex-validated on save)
before output, and the settings form is gated by `administer type style`.
