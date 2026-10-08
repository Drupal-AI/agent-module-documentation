<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Insert Responsive Image — agent index

Experimental **style-provider** submodule of Insert. It adds one insert style per Responsive Image
style so editors can insert a responsive `<img>` (with `srcset`/`sizes`) into a text area. **No config
object, no route, no permissions, no per-widget setting of its own** — it only makes responsive-image
options selectable in the parent Insert module's per-widget `styles` list.

- **The styles it adds and how the responsive markup is built** →
  [api/responsive-styles.md](api/responsive-styles.md)

Key facts:
- Adds `responsive_image__<style-id>` insert styles for the image insert type (`hook_insert_styles`),
  one per `ResponsiveImageStyle` entity (label `Responsive: <id>`).
- `hook_insert_variables` (run after the parent's, via `hook_module_implements_alter`) calls core
  `template_preprocess_responsive_image()` to compute `srcset`/`sizes`, resolves the fallback image
  style URL, and merges the attributes into the insert vars.
- To use it: create a Responsive Image style, then enable `responsive_image__<id>` in an image field
  widget's Insert settings (parent's `content.<field>.third_party_settings.insert.styles`).
- Depends on `responsive_image` + `insert`. Extends Insert via the parent hooks (see the parent
  project's `agent/hooks/extend.md`).
