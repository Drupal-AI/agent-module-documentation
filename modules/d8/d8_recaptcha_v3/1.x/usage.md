<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
reCAPTCHA v3 integrates Google reCAPTCHA v3 — the invisible, score-based bot check — into Drupal forms.

---

reCAPTCHA v3 scores each interaction for how bot-like it is, invisibly, without a challenge, letting the site decide a threshold below which to reject or add friction. This module integrates it into Drupal forms. The considerations are the standard reCAPTCHA ones: it needs a Google site key and secret (the secret is a credential to keep out of plain config), it sends interaction data to Google (a privacy/disclosure point), and a score threshold must be tuned — too strict blocks real users, too loose lets bots through. Unlike v2 it adds no user friction, but it is probabilistic, so pair it with other controls for high-value forms.

---

- Add invisible bot protection.
- Score form submissions.
- Use reCAPTCHA v3.
- Protect forms without a challenge.
- Set a score threshold.
- Keep the reCAPTCHA secret out of git.
- Disclose Google integration.
- Tune the bot threshold.
- Reduce spam without friction.
- Pair with other anti-spam controls.
- Enable when the feature is needed.
- Keep it disabled otherwise.
- Restrict administration to trusted roles.
- Confirm behaviour on your site.
- Test before production.
- Review configuration.
- Pair with related modules.
- Keep the setup minimal.
- Document why it was added.
- Verify it fits your theme.
- Audit access to it.
- Match it to your use case.