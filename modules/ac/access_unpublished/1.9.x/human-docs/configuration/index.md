# Configuration

There are three things to set up with Access Unpublished: **grant the permission** so
shared links actually work, **generate and share a token**, and (optionally) tune the
**global settings**. Start with permissions — without them, a shared link just shows
"access denied".

## Grant the "view via token" permission

The module generates a permission for each content type (and bundle) that can be
previewed by token, named like **Access unpublished article Content**
(`access_unpublished node article`). A user — including the **anonymous** role — can
only open a shared preview link if they hold the matching permission for that
content's type.

At **People → Permissions**, grant the relevant permission to the roles that should
be able to open preview links. To let logged-out reviewers use links, grant it to
**Anonymous user**, for example:

```bash
drush role:perm:add anonymous 'access_unpublished node article'
```

This grants **view only** — token holders can never edit. Three more permissions
control the admin side:

- **Access tokens overview** — see the token list at `/admin/content/access_token`.
- **Renew token** — renew (re-extend) a token.
- **Delete token** — delete a token to revoke its link.

## Generate and share a token

1. Edit an **unpublished, saved** piece of content (e.g. a node).
2. In the advanced sidebar, open **Temporary unpublished access**.
3. Choose a **Lifetime** (how long the link stays valid), optionally set a **token
   label**, and click **Generate token**.
4. The form shows a table with the **shareable URL** (the page URL plus the token,
   e.g. `https://example.com/node/12?auHash=AbCd…`), its expiry, and **Renew** /
   **Delete** links.

Send that URL to your reviewer. Anyone who opens it sees the unpublished content,
view-only.

The available lifetimes are 1 day, 2 days, 4 days, 1 week, 2 weeks, and **Unlimited**
(never expires). If you're editing inside an active **Workspace**, the widget is
disabled and shows a warning — generate tokens outside a workspace.

## Manage issued tokens

**Content → Access Tokens** (`/admin/content/access_token`) lists every token, its
content, owner, and expiry. From here (or the entity form) you can:

- **Renew** an expired token — re-adds its original lifetime from now, so the same
  link works again.
- **Delete** a token — instantly revokes the link.

## Global settings

**Configuration → Content authoring → Access Unpublished**
(`/admin/config/content/access_unpublished`) controls site-wide behaviour. You need
the **Administer site configuration** permission. The settings:

| Setting | Default | What it does |
|---------|---------|--------------|
| **Hash key** | `auHash` | The URL query parameter that carries the token (`?auHash=…`). Rename it for a little extra obscurity. |
| **Duration** | 2 days | The default token lifetime for new tokens. |
| **Label** | *(empty)* | A default label applied to new tokens. |
| **Clean up tokens on publish** | Off | Delete a content item's tokens automatically when it is published. |
| **Clean up expired tokens** | Off | Let cron delete expired tokens. |
| **Expired-token period** | `-2 weeks` | With cron cleanup on, purge expired tokens older than this. |
| **Modify HTTP headers** | *(none)* | Extra HTTP headers (one `key\|value` per line) added on token-viewed pages — e.g. `X-Robots-Tag\|noindex` to keep drafts out of search engines. |

Because these are configuration, they export and deploy across environments with
`drush config:export` / `drush config:import`.

## Content Moderation

If you use Content Moderation, a token can preview the latest forward/pending revision
of a moderated item, so reviewers see the draft rather than the last published
version.
