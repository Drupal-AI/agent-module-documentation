<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SynAjax provides AJAX-only contact form submission, requiring JavaScript to submit as a spam-control measure.

---

SynAjax provides AJAX-only submission for contact forms — requiring the form to be submitted via AJAX
(JavaScript), which blocks simple spam bots that POST directly without running JavaScript. It is configured
at `synajax.config` and is in the Spam control package.

Use it as a lightweight spam-control measure on contact forms. It is a security/anti-spam feature. Note the
usual caveats for JS-requirement spam control: it stops naive bots that don't run JS, but not headless-
browser/determined spammers (which can run JS), and requiring JavaScript can affect legitimate no-JS clients
(accessibility) — so use it as one layer and pair with CAPTCHA/honeypot/flood control where stronger
protection is needed. It has no access-control role. Configure it on the contact forms.

---

- Require AJAX-only contact submission.
- Block simple spam bots.
- Require JavaScript to submit.
- Configure at synajax.config.
- Provide lightweight spam control.
- Stop bots that POST directly.
- Know it stops naive bots only.
- Know determined bots can pass.
- Mind no-JS/accessibility impact.
- Use as one anti-spam layer.
- Pair with CAPTCHA/honeypot.
- Have no access-control role.
- Protect contact forms.
- Configure on contact forms.
- Reduce contact spam.
- Filter direct-POST bots.
- Add spam control.
- Require JS submission.
- Handle contact spam.
- Configure spam control.
