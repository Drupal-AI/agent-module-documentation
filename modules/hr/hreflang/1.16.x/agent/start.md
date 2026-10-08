# hreflang — agent start

Adds `<link rel="alternate" hreflang="…">` tags to every page for each enabled language
(multilingual SEO), via `hook_page_attachments()` and the core language-switch links —
covering all pages, not just the translated entity pages Content Translation handles.
Multilingual sites only; skips 403/404. Config UI:
**Admin → Config → Search and metadata → Hreflang tags** (`/admin/config/search/hreflang`);
settings route `hreflang.admin_settings`.

- Settings (x-default, fallback, defer to Content Translation) → [configure/hreflang.md](configure/hreflang.md)
- Alter/remove the hreflang tags in code → [hooks/hreflang.md](hooks/hreflang.md)
