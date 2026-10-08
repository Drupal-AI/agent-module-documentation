<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

| Permission | Machine name | Grants |
|---|---|---|
| Administer llmstxt | `administer llmstxt` | Access the settings form (`llmstxt.settings` → `/admin/config/search/llmstxt`) and edit the `llmstxt.settings:content` value. |

Defined in `llmstxt.permissions.yml`. It is **not** flagged `restrict access`, but it lets the
holder change what is published at the public `/llms.txt` path, so treat it as a
trusted-editor permission.

The module deliberately uses its own permission rather than `administer site configuration`,
so editing the file can be delegated to an SEO/content role without granting broad config
access.

The public serving route `llmstxt.content` (`/llms.txt`) has **no** permission — it is
`_access: 'TRUE'` by design (the file must be fetchable by anyone).

Grant via drush:

```bash
drush role:perm:add editor 'administer llmstxt'
```
