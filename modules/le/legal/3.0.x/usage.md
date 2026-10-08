<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Legal displays a Terms & Conditions statement on the user registration form (and optionally on login / profile edit) and requires visitors to tick an "Accept" checkbox before their account is created — recording who accepted which version.

---

You enter T&C text at `/admin/config/people/legal`; each save creates a new **version** (or revision) stored in the `legal_conditions` content-entity table, per language. When someone registers, `legal_form_user_register_form_alter()` injects the terms plus a required "Accept" checkbox (and any extra checkboxes you defined), and on account creation `legal_user_insert()` records acceptance in the `legal_accepted` table. Each new T&C version forces existing users to re-accept: `legal_user_login()` intercepts login and, if the latest version isn't accepted, logs the user out and redirects them through `/legal_accept` to agree. Display behaviour is controlled by config `legal.settings` — the T&C display style (Scroll box, Scroll box CSS, HTML text, or Page link) for registration and login, whether to show terms on profile edit, whether to require acceptance on **every** login, roles exempt from T&C, and a login redirect URL. A public `/legal` page renders the current terms, the module ships two Views (T&C history and user acceptances), provides a `[legal:tc]` token, and honors exemptions for user 1 and masquerading users. It depends on core User and Views and adds no Drush commands.

---

- Require new users to accept your Terms & Conditions before registering.
- Force all existing users to re-accept when you publish a new T&C version.
- Present terms as a scrollable read-only box on the registration form.
- Render terms as formatted HTML text inline on the registration form.
- Show only an "Accept [Terms & Conditions]" link that opens the terms in a modal.
- Add extra required checkboxes (e.g. "I am at least 18 years of age").
- Re-ask users to accept the terms on every login for high-compliance sites.
- Exempt specific roles (e.g. staff) from having to accept the T&C.
- Publish a public `/legal` page showing the current Terms & Conditions.
- Track exactly which user accepted which version/revision and when.
- Review a full history of past T&C versions via the shipped Views report.
- Maintain separate T&C text per language on a multilingual site.
- Explain what changed since the last version (shown to returning users as a bullet list).
- Show the T&Cs (and require re-acceptance) on the user profile edit page.
- Deploy terms programmatically in an update hook via `Conditions::create()`.
- Embed the current terms elsewhere using the `[legal:tc]` token.
- Redirect users to a specific page after they accept on login.
- Keep a GDPR/consent audit trail of acceptance records.
- Update the terms text and automatically bump the version for compliance.
- Prevent user 1 (and masquerading sessions) from being blocked by the T&C flow.
- Style the scroll box with the module's CSS scroll library.
- Gate account activation behind explicit, versioned consent.
- Add a company/age/privacy acknowledgment step to sign-up.
- Restore or migrate legacy Drupal 7 Legal terms and acceptances via the bundled migrations.
