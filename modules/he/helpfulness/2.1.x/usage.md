<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Helpfulness provides a block for the user to leave feedback, such as a 'was this helpful?' response.

---

Helpfulness provides a feedback block — letting users leave feedback on a page (e.g. a "was this
helpful? yes/no" widget with optional comment), so site owners gauge content usefulness. It is configured at
`helpfulness.admin_form` and provides its own permissions.

Use it to collect page-helpfulness feedback. The security-relevant point mirrors any user-feedback feature:
if it accepts free-text comments, that is user input — sanitize/escape when displaying to admins (avoid
stored XSS) and consider spam (flood control/CAPTCHA for anonymous). Gate who views the feedback with its
permission. It has no content-access role beyond its permission. Place the feedback block and configure
it.

---

- Add a feedback block.
- Ask 'was this helpful?'.
- Collect yes/no feedback.
- Accept optional comments.
- Configure at helpfulness.admin_form.
- Provide its own permissions.
- Sanitize free-text comments.
- Avoid stored XSS.
- Guard against feedback spam.
- Gate who views feedback.
- Have no content-access role beyond permission.
- Place the feedback block.
- Gauge content usefulness.
- Configure the block.
- Collect helpfulness ratings.
- Handle user feedback.
- Add helpfulness feedback.
- Review feedback.
- Escape submitted feedback.
- Collect page feedback.
