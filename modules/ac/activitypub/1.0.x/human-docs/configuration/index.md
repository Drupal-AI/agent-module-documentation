# Configuration

ActivityPub is configured from its central settings page (route
`activitypub.settings`). There you set up your site's **actors** — the identities
that publish to and receive from the Fediverse — and the **federation
behaviour**: who your site follows, whose content it accepts, and the security
options described below.

## Open the settings

1. Sign in as an administrator (you'll need the ActivityPub administration
   permission the module provides).
2. Go to the **ActivityPub settings** page and work through the actor and
   federation options.

## Actors and federation

- **Actors** represent the Fediverse identities on your site (for example a
  site-wide actor or per-user actors). Configure these so remote servers have
  something to follow and deliver to.
- **Following / followers** — as local users follow remote actors, their content
  can flow into the reader/timeline (if you enabled the Reader submodule).

## Security options — read this

Because inbound signature verification is incomplete in this alpha (see the
[main guide](../index.md)), the federation settings are also your main defence.
Use them deliberately:

- **Require follow** — restrict which incoming activities are accepted based on
  follow relationships. Prefer the stricter setting.
- **Blocked domains** — block servers you don't want to federate with.
- Keep the module **updated** — the signature-verification gap is expected to be
  closed upstream; newer releases are the real fix.

The settings form itself notes that "signature verification is not 100% done
yet", and that when verification fails the module may still publish an activity
if the actor is followed. Until that changes, **do not treat incoming federated
timeline content as authenticated** — don't display it to users as verified, and
be especially cautious with links in federated content, since an attacker could
inject them by impersonating a followed actor.

## Operational commands

The module provides **Drush commands** for federation tasks. Use those (and cron,
if you enabled the Scheduler submodule) to drive publishing and processing rather
than relying solely on the UI.
