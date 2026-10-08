<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Website Feedback (website_feedback) — agent index

Adds a site-wide floating **Feedback** button that opens an AJAX modal form for feedback /
support / bug reports (optionally with an in-browser page screenshot), stored as
`website_feedback` content entities. The button + libraries are attached in
`website_feedback_page_attachments()` **only for users with the `create website feedback`
permission** — exposure is opt-in per role. Front-end submit form is route
`website_feedback.frontend_add` at `/website-feedback/modal`. Managed at
`/admin/content/website-feedback`; site settings at `/admin/config/development/website-feedback`
(route `website_feedback.settings`). Requires core `text`, `image`, `options`. Core `^10.3 || ^11`.
Screenshots use html2canvas (jsDelivr CDN by default) or the browser `getDisplayMedia` API.

Provides:
- Content entity `website_feedback` (base table `website_feedback`, `admin_permission = administer website feedback`); interface `WebsiteFeedbackInterface`; access handler `WebsiteFeedbackAccessControlHandler`.
- Field widget plugin `website_feedback_screenshot` (`ScreenshotWidget`, extends core `FileWidget`) — decodes/validates base64 screenshot data into a managed image file.
- Action plugins `website_feedback_resolve_action` / `website_feedback_unresolve_action` (+ shipped `website_feedback_delete_action`); Views field `website_feedback_bulk_form`.
- Forms: `WebsiteFeedbackForm` (add/edit, flood-guarded), `SettingsForm`, `ConfirmDeleteMultiple`.
- Controller `WebsiteFeedbackController::toggleStatus` (route `website_feedback.toggle_status`, `_entity_access` + `_csrf_token`).
- Optional Views view `website_feedback`; theme hook `website_feedback` (`website-feedback.html.twig`).

Docs:
- Settings keys, entity fields, screenshot widget, flood control, bulk actions & routes → [configure/website_feedback.md](configure/website_feedback.md)
- The five permissions and what they gate → [permissions/website_feedback.md](permissions/website_feedback.md)
