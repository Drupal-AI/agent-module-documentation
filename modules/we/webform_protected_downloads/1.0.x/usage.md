<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Protected Downloads gates a file behind a form: a visitor submits a webform and receives a unique per-submission download link, the pattern used to exchange whitepapers, price lists and licensed documents for contact details.

---

The module ships a Webform handler ("Webform Protected Download") that you add to a webform and point at an uploaded file. On each submission it creates a `webform_protected_downloads` entity linking the submission to the file and mints a link at `/webform_protected_file/{hash}/download`, which you surface with the `[webform_submission:protected_download_url]` token in a confirmation message or email. Uploaded files are kept in the private filesystem and streamed by the module's own controller. Links can be time-limited (`expiration_time` in minutes, `0` = never) and marked one-time so they deactivate after the first download; when a link is invalid or expired the visitor is routed to a 404, the front page, the form again, or a custom page. A `verify_access` setting chooses how much access checking the download controller does — from `basic` up through options that require the current user to own the submission or to have permission to view it (`owner`, `view_submission`, `owner_or_view_submission`, `owner_and_view_submission`). Multiple handlers can be added to one webform for multiple downloads, each addressable with a handler-id sub-token. Requirements are Webform `^6.2`, core `file` and `token`; the documented release is `8.x-1.0-alpha3`.

---

- Exchange a whitepaper for contact details.
- Gate a price list behind a form.
- Send a download link after a form submission.
- Expire a download link after an hour.
- Issue a one-time download link that deactivates after first use.
- Require the submitter to be logged in to download.
- Restrict a download to the person who made the submission.
- Restrict a download to users who may view the submission.
- Track who requested a document by capturing a form first.
- Deliver a licensed file to a requester.
- Provide a report or datasheet after registration.
- Return a generated document to the submitter.
- Offer multiple protected files from one webform.
- Combine gating with a webform confirmation email.
- Put the download link in a confirmation message via token.
- Address a specific download with a handler-id sub-token.
- Provide time-limited access to a file.
- Deliver event materials to registrants.
- Capture leads in exchange for content.
- Redirect expired links to a custom "link expired" page.
- Serve files from the private filesystem instead of a public URL.
- Restrict which file extensions may be uploaded as the protected file.
