Captcha Riddler is an add-on for the CAPTCHA module that provides a "Riddler" challenge type: site-defined question-and-answer riddles (e.g. "Do you really hate spam?") that a user must answer correctly to submit a form, foiling automated bots.

---

Riddler depends on the CAPTCHA module and registers a new challenge type named **Riddler** via `hook_captcha()`. Riddles are stored as **`riddle` config entities** (config prefix `riddler.riddle.*`), each with a `question`, a `solution`, an optional `hint`, and a `status` (enabled/disabled). You manage them at `/admin/config/people/captcha/riddler-riddle` (add/edit/delete/translate), then attach the "Riddler" challenge to any form in the CAPTCHA settings (CAPTCHA points). When a protected form renders, Riddler picks a random enabled riddle and shows its question as a required text field; on submit, `riddler_captcha_validate()` compares the response against the comma-separated `solution` list, honouring CAPTCHA's global case-sensitivity setting (`captcha.settings: default_validation`). Multiple acceptable answers are supported by comma-separating them in the solution. There is a caching caveat: page caching is only compatible with **exactly one** enabled riddle; with two or more enabled riddles Riddler disables the page cache for those forms (via the page-cache kill switch) so a fresh random riddle is shown each time. Riddler has no configure route of its own and no permissions file — administering riddles is gated by CAPTCHA's `administer CAPTCHA settings` permission.

---

- Add a custom question-and-answer CAPTCHA to a Drupal site's forms.
- Foil spam bots with a human-only riddle instead of an image/reCAPTCHA.
- Create a brand- or community-specific question ("What is our town's name?").
- Allow several correct answers to a riddle via a comma-separated solution list.
- Give users a hint to help them answer a tricky riddle.
- Enable or disable individual riddles without deleting them (the `status` flag).
- Rotate among multiple riddles so bots can't hard-code one answer.
- Use a single riddle to keep page caching fully enabled on protected forms.
- Attach the Riddler challenge to the user registration or contact form via CAPTCHA points.
- Respect the site's global CAPTCHA case-sensitivity setting for answer matching.
- Replace an inaccessible image CAPTCHA with a text riddle for better accessibility.
- Translate riddles for multilingual sites (riddles are translatable config entities).
- Deploy riddles as configuration (`riddler.riddle.*`) across environments.
- Add a domain-knowledge gate to a members-only signup form.
- Protect a webform or comment form from automated submissions.
- Ship a default example riddle and customise it for the site.
- Provide a low-friction alternative to third-party CAPTCHA services (no external calls).
- Programmatically create riddles from code/config during site install.
- Audit which riddles are enabled by listing the `riddle` config entities.
- Combine with CAPTCHA's per-form-id configuration to protect only chosen forms.
- Discourage form spam without collecting or sending user data to a third party.
- Set a math or logic riddle ("What is 2+2?") with multiple accepted spellings ("4,four").
- Manage all riddles from one admin list showing question, solution, hint and status.
