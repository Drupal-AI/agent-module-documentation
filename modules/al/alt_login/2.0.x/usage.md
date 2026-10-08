<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alternative Login ID & Display Name lets registered users sign in with alternative identifiers (email, user ID, or first+last name) instead of only their username, and templates the name shown for each user with tokens.

---

Alternative Login ID & Display Name (alt_login) decouples the identifier a user types to log in from the stored Drupal username, and separately controls how a user's name is displayed. An administrator picks which "login methods" are accepted at `/admin/config/people/alt_login` — username, email, user ID, and (when the Address module is installed) first+last name — and each accepted method is turned into a pluggable alias that maps a typed identifier back to the underlying account before core validates the password. When the username method is turned off, the username field is hidden on the account form and is auto-populated (from the email, or from the address name), so end users only ever deal with the aliases you expose. A token-based template (`display` for authenticated viewers, `display_anon` for anonymous viewers) rewrites the rendered display name via `hook_user_format_name_alter`, and HTTP Basic Auth is extended to accept the same aliases so API clients can authenticate with an email or user ID. It ships an `AltLoginMethod` plugin type plus a matching entity-reference selection handler so autocomplete widgets can search users by the configured aliases.

---

- Let users log in with their email address instead of a username.
- Let users log in with their numeric user ID.
- Let users log in with their first + last name from an Address field.
- Accept several login identifiers at once (e.g. username OR email).
- Hide the username field entirely and drive everything off email.
- Auto-generate a unique username from the email local-part for new accounts.
- Auto-generate a username from the address given/family name on registration.
- Template the on-screen display name with tokens like `[user:uid]` or `[user:account-name]`.
- Show anonymous visitors a different display name (e.g. `Member [user:uid]`) than logged-in viewers see.
- Replace `[user:name]` in emails/messages with the user's configured aliases via `hook_tokens_alter`.
- Authenticate REST/JSON:API clients over HTTP Basic Auth using an email or user ID as the username.
- Surface a user's available login aliases on their own account edit form.
- Configure accepted login methods from `/admin/config/people/alt_login`.
- Prevent two accounts from sharing the same alias via a per-method dedupe check on the account form.
- Search/autocomplete users by their configured aliases through the `default:altlogin` entity-reference selection handler.
- Provide a custom login-method plugin by implementing `AltLoginMethodInterface` with the `#[AltLoginMethod]` attribute.
- Keep core's normal username login working alongside the added aliases.
- Offer email-as-username behavior similar to the core "Email registration" pattern without a separate field.
- Give migrated/imported users a sensible generated username when none is supplied.
- Integrate the Token module's token-tree UI into the display-name settings form.
- Enforce that the display template does not reference `[user:display-name]` (which would recurse).
