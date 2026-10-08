Website Feedback adds a site-wide floating "Feedback" button that opens a modal form so permitted users can send feedback, support requests, or bug reports — optionally with a page screenshot captured in the browser — which are stored as `website_feedback` content entities for site staff to review, triage, and resolve.

---

The module defines a `website_feedback` content entity (fields: summary, description, type, tags, screenshot, image, url, author, created, status/resolved) and attaches a JavaScript feedback button to every page via `hook_page_attachments()` — but only for users who hold the `create website feedback` permission, so exposure is opt-in per role. The button opens the entity add form at `/website-feedback/modal` (route `website_feedback.frontend_add`) in an AJAX dialog; on success the form is replaced in-place with a themed "Thank you" confirmation card. On save, the entity's `url` field is set from the request `Referer` header (validated with `UrlHelper::isValid()`) so staff know which page the feedback came from, and the post-submit redirect is constrained to same-host relative paths to avoid open redirects. Screenshots are produced client-side by the html2canvas library (loaded from the jsDelivr CDN by default, or locally at `/libraries/html2canvas/…`) or via the browser `getDisplayMedia` API, and captured through the custom `website_feedback_screenshot` field widget (`ScreenshotWidget`), which decodes the base64 image, size-validates it, verifies it is a genuine image, and stores it as a managed file. Non-administrative submissions are rate-limited by Drupal's flood service (`flood_limit` submissions per `flood_window` seconds). A site-wide settings form at Admin → Configuration → Development → Website Feedback settings (`/admin/config/development/website-feedback`, route `website_feedback.settings`, permission `administer website feedback`) toggles the type selector, tags (mapped to a chosen taxonomy vocabulary), and screenshot capture, and customises button text/title, success message, link position (left/right), screenshot technology, CDN vs local html2canvas, and flood limits. Submissions are listed and managed at `/admin/content/website-feedback` through an EntityListBuilder (with total/active/resolved metric cards, status/type badges, and screenshot thumbnails) and an optional Views view, with a per-row quick "Mark Resolved / Re-open" toggle (route `website_feedback.toggle_status`, CSRF-protected) and bulk Resolve/Unresolve/Delete actions (`system.action.*` plugins shipped in config). Five permissions (`administer`, `create`, `view`, `edit`, `delete website feedback`) gate the workflow via `WebsiteFeedbackAccessControlHandler`, with `uid`/`status`/`created` treated as administrative fields only editable by staff. The entity detail view is themeable via `website-feedback.html.twig`. It is a lightweight, self-hosted alternative to embedding a third-party feedback SaaS widget.

---

- Add a floating "Feedback" button to every page of the site for permitted users.
- Let editors report a bug directly from the page where they found it.
- Collect general feedback, support requests, and bug reports through one modal form.
- Capture a client-side screenshot of the current page and attach it to the feedback.
- Choose the screenshot capture technology: html2canvas or the browser getDisplayMedia API.
- Let submitters upload an additional image (PNG/JPG up to 2MB) with their report.
- Record which URL each piece of feedback was submitted from (via the Referer header).
- Categorise feedback by type: Feedback, Support request, or Bug report.
- Tag feedback with taxonomy terms from a vocabulary you choose.
- Review all submitted feedback in an admin listing at /admin/content/website-feedback.
- See at-a-glance total / active / resolved counts via metric cards on the listing.
- Quick-toggle a single item between Resolved and Re-opened from the listing row.
- Bulk-resolve or unresolve feedback items using content actions or Views bulk operations.
- Bulk-delete feedback items that are no longer relevant.
- Rate-limit anonymous/non-admin submissions with configurable flood limit and window.
- Customise the feedback button label and hover title.
- Move the feedback button to the left or right edge of the viewport.
- Customise the thank-you message shown after a submission.
- Serve the html2canvas screenshot library locally instead of from the jsDelivr CDN.
- Restrict who can submit feedback by granting "create website feedback" per role.
- Give a QA/support team view-only access to feedback without edit rights.
- Disable the type selector to keep the form to a single feedback stream.
- Disable screenshots or tags to simplify the form.
- Use it as a self-hosted alternative to third-party feedback widgets.
- Theme the feedback detail display via the website-feedback Twig template.
