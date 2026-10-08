<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Swiper formatter CKEditor — agent index

Submodule of **swiper_formatter**. Intended to add a **CKEditor 5** toolbar button for
embedding a Swiper slider into rich text. In **3.0.x it is a placeholder**: it ships only
`swiper_formatter_ckeditor.info.yml` + `README.md` — no PHP, no `*.ckeditor5.yml`, no JS, no
config, no routes, no permissions, no services, no hooks.

- Machine name: `swiper_formatter_ckeditor`.
- Dependency: `swiper_formatter:swiper_formatter` (the parent module).
- Core: `^11.3 || ^12`. Package: `Other`.
- Status: CKEditor 5 plugin **not yet implemented** (parent README TODO "Finish CKEditor 5 plugin").

No solution docs: there is no functional surface to document beyond enabling the module.
For working slider features, see the parent `swiper_formatter` docs (field formatters +
Views style). Enabling this submodule currently only registers it and pulls in the parent.
