<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure No Referrer

Settings form `Drupal\noreferrer\Form\NoReferrerSettingsForm` at route `noreferrer.settings`
→ **`/admin/config/content/noreferrer`** (menu: *Configuration → Content authoring → No
Referrer*). Permission: **`administer site configuration`** (the module defines none of its
own). All state lives in the config object **`noreferrer.settings`**.

## Config keys (`noreferrer.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `noreferrer` | boolean | `true` | Add `rel="noreferrer"` to non-allowed **external** links. |
| `noopener` | boolean | `true` | Add `rel="noopener"` to links that have a non-empty `target`. |
| `referrerpolicy` | boolean | `true` | Add `referrerpolicy="no-referrer"` to external `img`/`iframe`/`script`/`link` resources **in user-generated content**. |
| `allowed_domains` | sequence(string) | `[]` | Hosts exempt from `noreferrer`/`referrerpolicy` (matched by host or subdomain). |
| `publish` | boolean | `false` | On save, publish `allowed_domains` as a JSON file at a secret URI. |
| `subscribe_url` | uri (nullable) | `null` | If set, fetch `allowed_domains` from this URL on each cron run (and on save). |

The form shows `allowed_domains` as a **space-separated** textfield (e.g.
`example.com example.org`) — converted to/from the stored sequence.

```bash
drush config:get noreferrer.settings
# turn off the privacy attribute but keep the security one:
drush config:set noreferrer.settings noreferrer false -y
```

## Applying to user-generated content (the filter)

Code-generated links (menus, link fields) get the `rel` attributes automatically via
`hook_link_alter`. **User-generated content is only processed if you enable the filter.**

- Filter plugin id **`noreferrer`**, title *Add referrerpolicy="no-referrer", rel="noopener"
  and/or rel="noreferrer"*, type `TYPE_TRANSFORM_IRREVERSIBLE`, default weight 10. It also
  includes the *Correct faulty and chopped-off HTML* behaviour, so you need not enable that too.
- Enable it at *Administration → Configuration → Content authoring → Text formats and editors*
  on the desired format (e.g. Full HTML / Basic HTML). In config this is
  `filter.format.<id>` → `filters.noreferrer.status: true`.
- The filter rewrites `a`/`area`/`form` (`rel`) and adds `referrerpolicy` to external
  `img`/`iframe`/`script`/`link`; internal and allowlisted URLs are left alone.

## Allowlist: publish & subscribe

- **Allowed domains** exempt trusted hosts. Matching (`Allowlist\Validator::isAllowed`) is
  case-insensitive on the exact host **or** any subdomain of a listed domain.
- **Publish** (`publish: true`) writes `allowed_domains` to
  `public://noreferrer-allowlist-<hmac>.json` — the filename is HMAC-obscured (security by
  obscurity). Other sites can subscribe to that URL.
- **Subscribe** (`subscribe_url`) fetches a remote JSON array of domains via Guzzle and
  overwrites `allowed_domains`, on form save and on every `hook_cron` run. Invalid responses
  are logged to the `noreferrer` channel and ignored.
