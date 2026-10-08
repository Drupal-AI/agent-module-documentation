<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & access model

One permission, defined in `llms_txt_generator.permissions.yml`:

- **`administer llms txt generator`** — title "Administer LLMs.txt Generator", `restrict access: true`
  (Drupal marks it as security-sensitive in the permissions UI). Gates the settings form route
  `llms_txt_generator.settings` (`/admin/config/search/llms-txt-generator`) — i.e. who may edit the
  file contents and the enable toggle. Grant only to trusted administrators.

## Why `/llms.txt` itself is public

The serving route `llms_txt_generator.content` (`/llms.txt`) uses **`_access: 'TRUE'`**, so it is
reachable anonymously. That is **by design**: like `robots.txt`, the file is meant to be fetched by
any crawler. The served body is exactly the admin-authored `llms_txt_content` — the module performs
no content enumeration, so making the route public exposes only text an administrator deliberately
wrote. The response carries `X-Robots-Tag: noindex`.

The physical file lives at `public://llms.txt` (typically `sites/default/files/llms.txt`), which is
directly web-readable as well; again, its contents are only the admin-authored string.
