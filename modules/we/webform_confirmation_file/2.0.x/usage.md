<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Confirmation File provides a webform handler that streams the contents of a file to a user after they complete a webform.

---

Webform Confirmation File provides a Webform handler that streams a file to the user after they complete
a webform — e.g. a download (a whitepaper, a coupon, a resource) delivered as the confirmation of
submitting a form, gating the file behind form completion. It depends on the Webform module.

Use it for "fill in the form to get the download" flows. The security-relevant points: the file streamed is
configured on the handler (admin-set), so it is not user-controlled — but ensure the configured file is
intended for the audience who can complete the form (the file is effectively available to anyone who submits
the form), and if the file is sensitive, remember that form completion is the only gate (a public form means
a public file to anyone who fills it in). Confirm the file and form-access align. It has no access-control
role beyond the form-completion gate. Configure the file on the handler.

---

- Stream a file after form completion.
- Deliver a download on submit.
- Gate a file behind a form.
- Depend on the Webform module.
- Configure the file on the handler.
- Provide 'fill form to download'.
- Know the file is admin-configured (not user-controlled).
- Ensure the file suits the form's audience.
- Understand form completion is the only gate.
- Mind a public form = public file.
- Confirm file and form-access align.
- Have no access role beyond the gate.
- Deliver a whitepaper/coupon.
- Stream the configured file.
- Handle download-after-submit.
- Configure the handler.
- Gate downloads by submission.
- Provide resource downloads.
- Deliver files on completion.
- Stream confirmation files.
