# Social Post Mastodon — manual setup guide

**Social Post Mastodon** (`social_post_mastodon`) is a provider module for
[Social Post](../../../social_post/3.0.x/human-docs/index.md): it lets a Drupal
site automatically publish posts (toots) to a configured Mastodon account when
content is created, for social distribution. It is a plug-in for the Social Post
framework rather than a standalone tool, so it does nothing until Social Post is
present and a Mastodon account is connected.

You configure it with Mastodon API credentials from your Mastodon instance. As
with any autoposting credentials, store them securely — backed by an environment
variable rather than pasted into exported configuration. It depends on Social
Post (version 3.x or newer) and supports Drupal 10 and 11. This release is an
alpha (3.0.0-alpha3), so treat it as early software and test before relying on it
in production.

This guide is written for a **human** setting the integration up through the
admin UI. If you want terse, token-cheap references for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Because this module has no settings page of its own, its Mastodon integration
appears within Social Post. After enabling it:

1. Make sure Social Post is installed and configured (see its
   [guide](../../../social_post/3.0.x/human-docs/index.md)).
2. Register an application on your Mastodon instance to obtain API credentials.
3. Connect the Mastodon account through Social Post's integrations, supplying
   those credentials (kept in a secret / environment-backed store, not exported
   config).

Once connected, site content can be published to the Mastodon account
automatically. Note the same security cautions that apply to Social Post: its
stored access tokens are live credentials, and its account-management permissions
should be limited to administrators.
