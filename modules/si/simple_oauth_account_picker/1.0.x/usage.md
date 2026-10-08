<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple OAuth Account Picker adds an account picker to the OAuth authorize endpoint.

---

Simple OAuth Account Picker **adds an account picker to the OAuth2 authorize endpoint** — presenting a
"choose an account" step on the Simple OAuth authorization page, similar to the account chooser large identity
providers show. It depends on the Simple OAuth module.

Use it to improve the OAuth authorize UX. It is an authentication-flow feature and touches a sensitive surface (the
OAuth **authorize** endpoint), so understand the trust boundary: the picker should only ever let the **currently
authenticated user** authorize the client for **their own** account — it must not become a way to select or grant
access on behalf of a **different** account the browser isn't authenticated as (that would be an authorization
bypass). Verify that switching accounts requires proper re-authentication and that the issued tokens correspond to
the authenticated session, not merely the picked account. Store Simple OAuth keys/secrets securely as usual. It has
no broader access-control role. Configure the account picker.

---

- Add an account picker to OAuth authorize.
- Show a 'choose an account' step.
- Improve the authorize UX.
- Depend on the Simple OAuth module.
- Serve the OAuth authorization flow.
- Touch the sensitive authorize endpoint.
- ONLY let the authenticated user authorize their OWN account.
- NOT allow selecting/granting on behalf of another (unauthenticated) account (bypass).
- Require proper re-authentication to switch accounts.
- Ensure tokens correspond to the authenticated session, not just the picked account.
- Store Simple OAuth keys/secrets securely.
- Configure the account picker.
- Handle the account picker.
- Pick accounts.
- Configure the picker.
- Choose accounts.
- Handle authorize.
- Improve the flow.
- Verify the binding.
- Provide an OAuth account picker.
