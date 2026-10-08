# Permissions

Defined in `dubbot.permissions.yml`. Two "capability" permissions plus one permission **per
report pane**, so a role can be limited to specific tabs. If a role is granted *no* tab
permissions, **all** panes are visible to it (the per-tab filter only kicks in once at least one
tab permission is set) — see `Client::buildUrl()` which maps panes to permissions.

| Permission | Gates | restrict access |
|---|---|---|
| `administer dubbot configuration` | The settings form (`dubbot.settings` route) — embed key & module config. | yes |
| `access dubbot report` | The Overview page and individual report links (`dubbot.overview`). | yes |
| `view dubbot practices tab` | The **Best Practices** pane (`best-practices`). | no |
| `view dubbot governance tab` | The **Web Governance** pane (`web-governance`). | no |
| `view dubbot accessibility tab` | The **Accessibility** pane (`a11y`). | no |
| `view dubbot spellcheck tab` | The **Spell Check** pane (`spelling`). | no |
| `view dubbot seo tab` | The **SEO** pane (`seo`). | no |
| `view dubbot links tab` | The **Broken Links** pane (`links`). | no |

Grant with drush, e.g.:

```bash
drush role:perm:add qa_reviewer 'access dubbot report'
drush role:perm:add qa_reviewer 'view dubbot accessibility tab'
drush role:perm:add qa_reviewer 'view dubbot links tab'
```

Typical setups:
- **Full QA role:** `access dubbot report` + every `view dubbot * tab`.
- **Accessibility-only role:** `access dubbot report` + `view dubbot accessibility tab` (that
  single tab permission hides the other panes).
- **Site admin:** `administer dubbot configuration` (to enter the embed key).
