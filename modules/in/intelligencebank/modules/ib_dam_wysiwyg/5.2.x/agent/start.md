<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ib_dam_wysiwyg — agent index

Submodule of **intelligencebank** (`ib_dam`). Historically integrated `ib_dam` directly into CKEditor
so sites not using the Media suite could insert DAM assets in rich text. **Deprecated** in 4.x/5.x and
scheduled for removal in 6.0.0. Version **5.2.3**, core `^10.3 || ^11`. Depends on `drupal:field`,
`drupal:filter`, `ib_dam:ib_dam`.

What it actually ships in 5.2.x:
- One text-filter plugin, **`ib_dam_wysiwyg`** (`Drupal\ib_dam_wysiwyg\Plugin\Filter\IbDamWysiwygFilter`,
  `@Filter type = TYPE_MARKUP_LANGUAGE`). Its `process()` is now a **no-op** — it returns the text
  unchanged and only emits an `E_USER_DEPRECATED` notice. There is no CKEditor plugin/button, service,
  route, or config schema of its own here.
- `hook_requirements` (runtime) that reports the module as deprecated (WARNING).
- Update hooks in `ib_dam_wysiwyg.install`: `ib_dam_wysiwyg_update_9000` disables the filter and
  converts legacy inline JSON asset markup into core `<drupal-media>` tags (creating media via the
  parent's `Asset`/`MediaStorage` pipeline). The parent's `ib_dam_update_10000` removes this filter
  from all formats and uninstalls the module.

No settings page, no permissions, no config object. Prefer `ib_dam_media` + core Media/CKEditor 5 for
new sites. Parent: `../../../5.2.x/agent/start.md`.
