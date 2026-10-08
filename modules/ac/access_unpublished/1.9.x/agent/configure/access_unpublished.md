# Configure & generate tokens

## Generate a token to share a draft (UI)

Edit any **unpublished, saved** entity of an applicable type (implements `EntityPublishedInterface`
and has a `canonical` link — e.g. a node). The module (`AccessUnpublishedForm::formAlter`) adds a
**"Temporary unpublished access"** section in the form's advanced sidebar with:

- **Lifetime** — select of durations (default from the `duration` setting).
- **Token label** — optional label (default from the `label` setting).
- **Generate token** button — AJAX; creates an `access_token` for this entity and renders it in a
  table showing the shareable URL, expiry, and Renew/Delete links.

The shareable URL is the entity's canonical (or `latest-version` for moderated pending revisions)
URL plus the token query parameter, e.g. `https://site/node/12?auHash=AbCd…`. Sharing that URL lets
a holder view the unpublished content, view-only (no edit). The widget is disabled with a warning
when editing inside an active **Workspace**.

## Token overview

| Route | Path | Permission |
|---|---|---|
| `access_unpublished.access_token.list` | `/admin/content/access_token` | `access tokens overview` |
| `entity.access_token.renew` | `/access_token/{access_token}/renew` | `renew token` |
| `entity.access_token.delete` | `/access_token/{access_token}/delete` | `delete token` |

Renewing an expired token re-adds its original lifetime from now; deleting revokes the URL instantly.

## Global settings — `access_unpublished.settings`

Settings form route `access_unpublished.settings_form` at
`/admin/config/content/access_unpublished` (permission: `administer site configuration`). Or
`drush cset access_unpublished.settings <key>`. Defaults:

| Key | Default | Meaning |
|---|---|---|
| `hash_key` | `auHash` | URL query parameter carrying the token value (`?auHash=…`) |
| `duration` | `172800` | Default token lifetime in seconds (2 days); `-1` = unlimited |
| `label` | `''` | Default label for new tokens |
| `cleanup_tokens_on_publish` | `false` | Delete a content item's tokens when it is published (`hook_entity_update`) |
| `cleanup_expired_tokens` | `false` | Let cron delete expired tokens |
| `cleanup_expired_tokens_period` | `-2 weeks` | strtotime period; expired tokens older than this are purged by cron |
| `modify_http_headers` | `{}` | Extra HTTP headers (`key\|value` per line) added on token-accessed pages (e.g. `X-Robots-Tag`) |

The Lifetime select options are `86400, 172800, 345600, 604800, 1209600` seconds plus **Unlimited**
(`-1`); alter them with `hook_access_unpublished_duration_options_alter()` (see api doc). Config
schema: `config/schema/access_unpublished.schema.yml`; settings export/deploy with `drush cex`.
