<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# advban settings & admin routes

## Routes (all require `advanced ban IP addresses`)

| Route | Path | What |
|---|---|---|
| `advban.admin_page` | `/admin/config/people/advban` | ban list + "add ban" form (`configure` target) |
| `advban.search` | `/admin/config/people/advban/search` | find which entry bans an IP |
| `advban.edit` | `/admin/config/people/advban/edit/{ban_id}` | edit a ban |
| `advban.delete` | `/admin/config/people/advban/delete/{ban_id}` | delete one ban |
| `advban.delete_all` | `/admin/config/people/advban/delete_all` | bulk delete (all / simple / range × all / expired / not-expired) |
| `advban.settings` | `/admin/config/people/advban/settings` | the config form below |

## `advban.settings` keys

```yaml
expiry_durations: "+1 hour\n+1 day\n+1 week\n+1 month\n+1 year"  # newline list, strtotime() strings
default_expiry_duration: 'never'      # one of the above, or the sentinel 'never'
save_last_expiry_duration: false      # bool: remember the duration used on the last ban
advban_listing_table_rows: '50'       # rows per page on the list; -1 disables the pager
range_ip_format: '@ip_start ... @ip_end'
advban_ban_text: '@ip has been banned'
advban_ban_expire_text: '@ip has been banned up to @expiry_date'
advban_protected_ips: ''              # newline list, see below
```

**Important:** the module ships no `config/install/advban.settings.yml`. Right after
`drush en advban`, `drush cget advban.settings` fails with "does not exist". It is created
the first time the settings form is saved, or lazily by `AdvbanIpManager::expiryDurations()`
which writes the five default durations.

Set it from the CLI:

```bash
drush cset advban.settings default_expiry_duration '+1 day' -y
drush cset advban.settings advban_protected_ips '198.51.100.0/24
googlebot.com
# office' -y
drush cget advban.settings
```

### `advban_protected_ips` syntax

One entry per line; a protected match **always overrides** a ban.

- `203.0.113.9` — a single IPv4 address
- `198.51.100.0/24` — a CIDR block
- `googlebot.com` — matched as a **suffix of the reverse DNS name** of the client IP
- `# text` — a whole-line comment; `1.2.3.4 # office` — trailing inline comment

### Expiry durations

Any string `strtotime()` understands (the settings form validates each line and rejects
duplicates). The literal string `never` (constant `AdvbanHelper::ADVBAN_NEVER`) is appended
as the last option in the select and stores `expiry_date = 0`.

## Adding a ban through the UI

`/admin/config/people/advban` → **IP address** (required), **IP address (end of range)**
(optional, IPv4 only), **IP ban expiry duration** select, **IP ban reason** textarea → *Add*.
Validation refuses: an invalid IP, an already-banned IP, your own client IP (also if it falls
inside the range), an end address lower than the start, a non-IPv4 range, and any IP covered
by the protected list.
