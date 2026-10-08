<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Post is the autoposting arm of the Social API family: it provides the framework for modules that publish content to social networks on a user's behalf, storing each user's connection (provider account id plus an OAuth access token) as a `social_post` content entity. It does nothing visible on its own — installing a per-network implementer (Twitter, Facebook, LinkedIn, …) is what adds actual posting.

---

Social API is split into three siblings — Social Auth (log in with), Social Widgets (embed) and Social Post (publish out); this module owns publishing. It defines a `social_post` content entity that binds a Drupal user to a social account, with fields `user_id`, `plugin_id`, `provider_user_id`, `name`, a `link`, an `additional_data` blob and a `token` field holding the provider's OAuth access token used to post. Around it sit three services (`social_post.user_authenticator`, `social_post.user_manager`, `social_post.data_handler`), an `OAuth2ControllerBase` scaffolding the OAuth connect/callback flow, a `Plugin\Network\NetworkBase` and a `PostManager\OAuth2Manager` base class that implementers extend, and an admin page at `/admin/config/social-api/social-post` listing installed integrations. Networks such as Twitter or Facebook are separate provider projects that plug in here through the shared Social API `@Network` plugin type. Three permissions are declared, covering viewing the connected-account lists and deleting accounts. Requirements are PHP 8.1+, Social API `^4` and core `link`; core support is `^9.5 || ^10 || ^11`.

---

- Post new content automatically to a social network on a user's behalf.
- Let users connect their own social account for autoposting.
- Store a per-user provider OAuth token for later publishing.
- Reuse one stored connection across several posting operations.
- Publish site announcements without a manual copy-paste step.
- Let a user disconnect their own connected social account.
- Give administrators a table of connected accounts per network.
- Add a new network by writing a Social Post implementer module.
- Reuse Social API's shared OAuth `@Network` plugin plumbing.
- Push editorial content to a brand or organization account.
- Keep posting credentials per user rather than site-wide.
- Audit which users have connected which networks.
- Build the OAuth connect flow with the provided controller base.
- Combine autoposting with Social Auth login on the same site.
- Support several accounts on the same network via distinct records.
- Store provider profile metadata alongside the connection.
- Look up a Drupal user from a provider user id.
- Update a stored token when the provider refreshes it.
- Load all connected accounts for a given provider.
- Base a bespoke integration on the `PostManager` API.
