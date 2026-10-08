<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth GitHub — agent index

"Log in with GitHub" — a **Social Auth** provider plugin (on Social API) using OAuth2 via
`league/oauth2-github`. Supplies the GitHub client + settings form (client ID/secret); the OAuth2
authorization-code flow, **`state`/CSRF handling**, and token exchange live in the Social Auth base
module. Version **4.0.1**. Core `^9.5||^10||^11`.

Depends on `social_auth`. Register a GitHub OAuth app, store client secret as config/secret, set the
Social Auth callback URL. Account creation/matching governed by Social Auth settings.
