<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lupus Decoupled Webform brings Webform's forms and submissions into the decoupled front end through the custom-elements form API.

---

Webform is where most Drupal sites' real forms live, and it is a large surface: dozens of element types, conditional logic, multi-step wizards, file uploads, handlers that email and post to third parties, and its own access model per form. Reimplementing that in a front end is not a sprint.

This submodule renders Webforms as custom elements so the front end presents them and Drupal processes the submissions. Handlers still run, submission storage still applies, and per-webform access is still Webform's.

Two things to check on any decoupled Webform deployment. **File uploads** need a path from the front end to Drupal's file handling, and whether they land as managed files with validators applied is worth confirming rather than assuming. And **spam protection** — a form reachable from a different origin is a form reachable by a bot; whatever CAPTCHA or honeypot the site uses must work in the decoupled flow, because a webform without it will be found.

---

- Render a Webform in a decoupled front end.
- Submit a webform from Nuxt.
- Run Webform handlers on submission.
- Store submissions in Drupal.
- Keep per-webform access in Drupal.
- Support conditional webform logic.
- Support multi-step webform wizards.
- Handle file uploads from the front end.
- Confirm uploads apply file validators.
- Keep CAPTCHA working in a decoupled flow.
- Protect a decoupled form against bots.
- Email a submission from Drupal.
- Post a submission to a third party.
- Style webform elements as components.
- Debug a submission that never arrived.