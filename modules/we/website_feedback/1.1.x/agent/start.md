# website_feedback — agent start

Adds a site-wide floating **Feedback** button that opens a form for feedback / support /
bug reports (optionally with an in-browser page screenshot), stored as `website_feedback`
content entities. The button is attached in `hook_page_attachments()` **only for users with
the `create website feedback` permission** — exposure is opt-in per role. Managed at
`/admin/content/website-feedback`; site settings at
`/admin/config/development/website-feedback` (route `website_feedback.settings`).
Depends on core `text` + `image`. Screenshots use html2canvas (jsDelivr CDN by default).

- Settings form keys, entity fields, taxonomy/screenshot wiring, bulk actions → [configure/website_feedback.md](configure/website_feedback.md)
- The five permissions and what they gate → [permissions/website_feedback.md](permissions/website_feedback.md)
