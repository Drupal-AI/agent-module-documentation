A lightweight question-and-answer CAPTCHA that adds a configurable question to selected forms and blocks anonymous submissions whose answer is wrong.

---

Captcha questions protects chosen forms (by form_id) from automated spam without images or third-party services. An administrator sets a single question, one or more accepted answers (one per line, case-insensitive), an optional field description, and ticks which forms to protect from a generated list (core account/contact/comment/forum forms, discovered Webform submission forms, plus any custom form_id you add). The challenge is injected via `hook_form_alter` only for anonymous users; a required text field carries the question as its label, and a validate handler rejects the submission with "Invalid answer" if the typed value (lowercased) is not among the accepted answers. On multi-page forms the field appears only on the first page. Failed attempts can optionally be recorded to the Drupal log (watchdog) and, when the `captcha_questions_dblog` submodule is enabled, to a dedicated database table viewable through an admin report. The module has no dependencies and is meant for low-sophistication bot spam; the maintainer recommends keeping questions trivially easy for humans (even embedding the answer in the question text).

---

- Add a simple question to the user registration form (`user_register_form`) to cut down spam account creation.
- Protect the site-wide contact form (`contact_site_form`) and personal contact form (`contact_personal_form`) from contact spam.
- Add a question to comment forms (`comment_node_<type>_form`) to stop anonymous comment spam.
- Protect the password-reset form (`user_pass`) from automated abuse.
- Protect the login form or login block (`user_login_form`, `user_login_block`) against scripted login attempts by anonymous visitors.
- Protect forum posting (`forum_node_form`) from bot submissions.
- Protect Webform submission forms (auto-discovered as `webform_submission_<id>_form`) when the Webform module is installed.
- Protect an arbitrary custom form by typing its form_id into the "Custom form_id" field and adding it to the protected list.
- Configure a math-style challenge ("What is 1+1?") for a minimal, fast human check.
- Configure a trivia challenge with the answer embedded in the question ("What is Mickeys last name? Its Mouse.") to maximize human pass-through.
- Accept several spellings or variants by listing multiple accepted answers, one per line.
- Give respondents guidance via the optional description shown under the question field.
- Keep the challenge invisible to authenticated users (it is only added for anonymous sessions).
- Exempt trusted staff by granting the "administer captcha questions settings" permission (holders are not shown the challenge).
- Log every failed submission to the Drupal log (watchdog) to monitor spam volume, when the core dblog module is enabled.
- Enable the `captcha_questions_dblog` submodule to store failed submissions (timestamp, IP, form_id, question, answer given, correct answer) in a dedicated table.
- Review failed submissions in a paged, sortable admin report at Configuration to gauge attack patterns and tune the question.
- Use a fast, dependency-free alternative to image CAPTCHAs on small or accessibility-sensitive sites.
- Combine with rate limiting or a honeypot module for stronger protection against targeted abuse.
- Rotate the question/answer periodically to reduce the chance a scripted attacker has hard-coded the answer.
- Protect multi-page forms, where the question is enforced on the first step only.
- Replace older abandoned Q&A CAPTCHAs (Trick Question, Captcha Riddler) with an actively maintained equivalent.
- Add a challenge to any custom module's public form by registering its form_id in the settings.
