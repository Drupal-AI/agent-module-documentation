# ai_image_bulk_alt_text — agent start

Submodule of **ai_image_alt_text**. Adds one admin form that lists all image fields **missing
alt text** and lets you AI-generate + save them in bulk. Requires `ai_image_alt_text` (and
through it AI Core) — it has no AI code of its own. No config, no schema, no services.

Form route `ai_image_bulk_alt_text.fix_alt_text` →
**Admin → Config → Media → Bulk Generate Alt Text with AI**
(`/admin/config/media/ai_image_bulk_alt_text`), permission `batch fix ai images alt text`.

- The bulk form: how it finds missing alt text, generates, and saves → [configure/ai_image_bulk_alt_text.md](configure/ai_image_bulk_alt_text.md)
