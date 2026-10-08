<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Focal Point Focus (focal_point_focus) — agent index

An **image field formatter** (`focal_point_focus`) that keeps an editor-chosen Focal Point in view by
rendering the **original image** (no derivative) inside a fixed-height, `overflow:hidden` container and
letting the bundled **jquery-focuspoint** script shift the oversized image (`top`/`left` offsets) so the
focal point stays centred at any container width. Not `object-position`, not an image-style crop, not
`srcset`. Depends on `drupal:image`, `crop:crop`, `focal_point:focal_point`. Core `^11`, PHP `^8.1`.

Mechanism in one line: crop pixel position → normalised `data-focus-x`/`data-focus-y` (`-1..1`) on the
wrapper `<div>` → JS `adjustFocus()` positions the image; a per-view-mode **display height** fixes the
container height (optionally per **core Breakpoint** via a scoped `<style>` block of `@media` rules).

## What you'd do → where

- **Use / configure the field formatter (all settings: height, first-only, mute title, loading,
  breakpoint heights) and understand `viewElements()`** → [fields/formatter.md](fields/formatter.md)
- **Understand or override the Twig template, CSS, JS behavior, and the breakpoint `<style>`/`drupalSettings`
  output (incl. the State test-mode flag)** → [theming/theming.md](theming/theming.md)

## Key facts (real machine names)

- Field formatter plugin: `focal_point_focus` (label "Focal Point Focus"), field type `image`,
  `quickedit = disabled`. Class `Drupal\focal_point_focus\Plugin\Field\FieldFormatter\FocalPointFocusFormatter`
  (extends `image`'s `ImageFormatterBase`).
- Settings keys (defaults): `height`=300, `title`=FALSE (mute figcaption), `first-only`=FALSE,
  `focal-provider`='none' (Breakpoint Group id), `loading`=FALSE (`''`|`lazy`|`eager`),
  `breakpoint_heights`=[] (nested `provider → breakpoint_id → px`). No config schema ships.
- Theme hook: `focal_point_focus` (template `templates/focal-point-focus.html.twig`, single var
  `focalpoint`); library `focal_point_focus/focuspoint` (jQuery.focusPoint.js + behaviors + css).
- Reads the crop via `\Drupal\focal_point\FocalPointManager::getCropEntity($file, 'focal_point')`;
  no crop ⇒ image centred (x=y=0).
- **No** admin route/`configure`, **no** permissions, **no** drush, **no** config entities. All settings
  live on the field-formatter (Manage Display).
- Soft dependency: core **Breakpoint** module — if enabled, the settings form exposes per-breakpoint
  heights and output gains a scoped `<style>` block + `drupalSettings['focalpoint-breakpoints']`.
- Not documented live-verified beyond enable: module + `crop`/`focal_point`/`breakpoint` all enabled on
  the site; formatter renders through the Twig template.
