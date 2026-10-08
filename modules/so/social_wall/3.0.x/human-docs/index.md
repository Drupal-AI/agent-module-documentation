# Social Wall — manual setup guide

**Social Wall** (`social_wall`) aggregates posts from several social networks into
one combined feed on your site — the "social wall" pattern used on campaign and
event pages, where a single display mixes content from more than one platform. It
runs on Drupal 8 through 11.

Each network is modelled as a **configuration entity** (`social_network_config`),
managed at `/admin/config/services/social-wall` behind the **administer social
networks** permission. That means each network's credentials and settings live in
configuration, and several networks combine into one wall. Under the hood the
module relies on two PHP libraries — `abraham/twitteroauth` for Twitter/X and
`pgrimaud/instagram-user-feed` for Instagram — which Composer installs alongside
it.

There is one caution to weigh before you commit to this module, and it is
important enough to check first. Both platforms it targets have changed
fundamentally since this approach was designed: **Twitter/X's API is now a paid
product** with no free read tier of the kind a social wall assumes, and
**Instagram's Basic Display API — the route the Instagram library used for a
user's own recent posts — has been shut down**, with the replacement restricted to
business and creator accounts through the Graph API. So the module's code may be
sound while the integrations it depends on are simply not available on the terms
it assumes. Establish, per network, whether current API access is obtainable and
at what cost before weighing anything else. Where you only need one platform, a
narrower module or the platform's own official embed is usually the more durable
answer.

This guide is written for a **human** setting the wall up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its libraries)
   with Composer and enable it.
2. [Configuration](configuration/index.md) — adding and configuring each social
   network.

## Where it lives in the admin menu

Networks are managed at **Configuration → Web services → Social Wall**
(`/admin/config/services/social-wall`), behind the **administer social networks**
permission.
