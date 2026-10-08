# Permissions

Defined in `simplenews.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer newsletters` | Create/edit/delete `simplenews_newsletter` config entities; the newsletter list (`simplenews.newsletter_list`, the module's `configure` route). |
| `administer simplenews subscriptions` | Subscriber admin: the subscribers collection, mass subscribe/unsubscribe, and export. |
| `view simplenews subscriptions` | Read-only view of subscription data. |
| `administer simplenews settings` | The global settings forms (newsletter, subscriber, subscription, mail, prepare-uninstall). Trusted/administrative. |
| `send newsletter` | Send/queue newsletter issues (the Send action and node Newsletter tab). |
| `subscribe to newsletters` | Front-end subscribe: the subscription block, `/simplenews/subscriptions`, and the validate/manage flows. |

The unsubscribe/confirm/manage links (`/simplenews/confirm|add|remove/{snid}/{timestamp}/{hash}`)
have **no permission check** — access is proven by the time-limited hash, so users need not log in
to confirm or unsubscribe.

```bash
drush role:perm:add authenticated 'subscribe to newsletters'
```
