<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Feedback lets visitors and users send a short feedback message about the page they are viewing, collected for admin review.

---

Content Feedback adds a **Feedback** link at the bottom of eligible pages; clicking it opens an AJAX modal
form (name, email, and a required message) so the visitor can submit feedback without leaving the page. Each
submission is stored in a custom `content_feedback` database table together with the page URL, IP address,
and a timestamp. Admins review submissions in an Open/Resolved list under Administration » Content, where
each item can be edited or marked Resolved. It is configured at `content_feedback.settings` and provides
its own permissions.

Which pages show the link is controlled on the settings form: enable it globally, or only on selected
content types, and suppress it on specific paths. The `name` and `email` fields can each be shown and/or
made required, and the modal's sizing is configurable. The form link, and the ability to submit, require the
`access content feedback form` permission; viewing, editing, and deleting collected feedback require
`manage content feedback submissions`; the settings form requires `administer content feedback settings`.
Submitted values are escaped on storage and again when rendered in the admin list.

---

- Add a Feedback link to eligible pages.
- Let visitors submit page feedback via an AJAX modal.
- Collect a name, email, and required message.
- Store the page URL, IP address, and timestamp with each submission.
- Keep the visitor on the page after submitting.
- Enable the link globally or per content type.
- Suppress the link on specific paths.
- Show or require the name and email fields.
- Configure the modal size and width.
- Review submissions in an Open/Resolved list.
- Edit a submission or mark it Resolved.
- Delete a submission.
- Gate the form with `access content feedback form`.
- Gate review/edit/delete with `manage content feedback submissions`.
- Gate settings with `administer content feedback settings`.
- Configure at `content_feedback.settings`.
- Store feedback in the `content_feedback` table.
- Group feedback by open vs. resolved status.
- Reach settings at Config » Content authoring.
- Reach the list at Content » Feedback.
