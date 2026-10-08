<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# alter_hreflang

SEO/multilingual helper that rewrites the `hreflang` code on Drupal's alternate-language head links.

- Single hook: `alter_hreflang_page_attachments_alter()` in `alter_hreflang.module`.
- Admin form `AlterHrefLangConfigForm` at `/admin/config/regional/alter-hreflang` (`administer site configuration`).
- Overrides stored as `alter_hreflang.settings:language_<langcode>`; fallback is the raw langcode.
- No permissions/services/blocks. Config-only, cache-attached output.

See [../usage.md](../usage.md) for the full behavior.
