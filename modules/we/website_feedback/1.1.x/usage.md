Website Feedback adds a site-wide floating "Feedback" button that opens a form so users can send feedback, support requests, or bug reports — optionally with a page screenshot captured in the browser — which are stored as `website_feedback` content entities for site staff to review and resolve.

---

The module defines a `website_feedback` content entity (fields: summary, description, type, tags, screenshot, image, url, author, created, status/resolved) and attaches a JavaScript button to every page via `hook_page_attachments()` — but only for users who hold the `create website feedback` permission, so exposure is opt-in per role. The submission form is the entity add form at `/admin/content/website-feedback/add`; on save the entity's `url` field is set from the request `Referer` header so staff know which page the feedback came from. Screenshots are produced client-side by the html2canvas library (loaded from the jsDelivr CDN by default, or locally at `/libraries/html2canvas/html2canvas.min.js`) through the `website_feedback_screenshot` field widget. A site-wide settings form at **Admin → Configuration → Development → Website Feedback settings** (`/admin/config/development/website-feedback`, route `website_feedback.settings`, permission `administer website feedback`) toggles the type selector, tags (mapped to a chosen taxonomy vocabulary), and screenshot capture, and customises the button text/title, success message, link position (left/right), and CDN vs local html2canvas. Submissions are listed and managed at `/admin/content/website-feedback` with a Views-based collection and bulk **Resolve/Unresolve/Delete** actions (`system.action.*` plugins shipped in config). Five permissions (`administer`, `create`, `view`, `edit`, `delete website feedback`) gate the workflow, with `uid`/`status`/`created` treated as administrative fields only editable by staff. The entity is themeable via the `website-feedback.html.twig` template. It is a lightweight alternative to embedding a third-party feedback SaaS widget.

---

- Add a floating "Feedback" button to every page of the site for logged-in staff.
- Let editors report a bug directly from the page where they found it.
- Collect general feedback, support requests, and bug reports through one form.
- Capture a client-side screenshot of the current page and attach it to the feedback.
- Let submitters upload an additional image (e.g. an annotated mock-up) with their report.
- Record which URL each piece of feedback was submitted from (via the Referer header).
- Categorise feedback by type: Feedback, Support request, or Bug report.
- Tag feedback with taxonomy terms from a vocabulary you choose.
- Review all submitted feedback in an admin listing at /admin/content/website-feedback.
- Bulk-resolve or unresolve feedback items using Views bulk actions.
- Bulk-delete feedback items that are no longer relevant.
- Mark individual feedback as Resolved vs Active to track a triage workflow.
- Customise the feedback button label and hover title.
- Move the feedback button to the left or right edge of the viewport.
- Customise the thank-you message shown after a submission.
- Serve the html2canvas screenshot library locally instead of from the jsDelivr CDN.
- Restrict who can submit feedback by granting the "create website feedback" permission per role.
- Give a QA/support team view-only access to feedback without edit rights.
- Disable the type selector to keep the form to a single feedback stream.
- Disable screenshots or tags to simplify the form.
- Use it as a self-hosted alternative to third-party feedback widgets.
- Theme feedback display output via the website-feedback Twig template.
