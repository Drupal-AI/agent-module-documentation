<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
League OAuth Login Slack provides a Slack provider for League OAuth Login.

---

League OAuth Login Slack adds **Slack as an OAuth provider** for the League OAuth Login module — a plugin
(`Slack`) supplying the Slack OAuth2 provider config so users can log in with Slack. It depends on the
league_oauth_login base module, which owns the actual login flow.

Use it to offer Slack login on a League OAuth Login site. This module is only the Slack provider plugin — the
login redirect/callback flow lives in the base `league_oauth_login` module. Store the Slack **client secret** as
a secret and use HTTPS. It adds no access-control logic of its own.

---

- Add Slack as an OAuth provider.
- Supply the Slack OAuth2 provider config.
- Let users log in with Slack.
- Depend on league_oauth_login (owns the flow).
- Store the Slack client secret as a secret.
- Use HTTPS.
- Add no access-control logic of its own.
- Configure the Slack OAuth app.
- Handle Slack login.
- Provide the Slack plugin.
- Configure OAuth.
- Log in via Slack.
- Handle the provider.
- Provide Slack login.
