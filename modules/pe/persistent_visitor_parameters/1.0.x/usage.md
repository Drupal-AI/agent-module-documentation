<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Persistent Visitor Parameters checks GET and HTTP request parameters and persists them.

---

Persistent Visitor Parameters **captures GET/HTTP request parameters from a visitor and persists them** —
storing selected query parameters (e.g. UTM/campaign/referral params) across the session so they survive to a
later action, with a `persistent_visitor_parameters_user_registration` submodule that attaches captured params
to user registration. It provides its own permissions, in the Custom package.

Use it for campaign attribution / carrying params to registration. It is a marketing/user-engagement feature.
Security/data handling: the persisted values are **user-controlled request input** — so anything that later
**outputs** them must sanitize/escape (avoid reflected XSS), anything that stores them to a user/entity should
validate them, and don't trust them for security decisions. It has no access-control role beyond its permission.
Configure which parameters are captured.

---

- Capture GET/HTTP request params.
- Persist params across the session.
- Carry UTM/campaign/referral values.
- Attach params to registration (submodule).
- Provide its own permissions.
- Support attribution.
- TREAT persisted values as user-controlled input.
- Sanitize/escape on output (avoid XSS).
- Validate before storing / don't trust for security.
- Have no access-control role beyond permission.
- Configure captured parameters.
- Handle visitor params.
- Persist params.
- Configure the capture.
- Store params.
- Handle the params.
- Carry parameters.
- Capture input.
- Sanitize on output.
- Provide persistent params.
