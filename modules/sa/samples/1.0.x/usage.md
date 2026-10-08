<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sample Content creates restricted content in production for demonstration and development.

---

Sample Content (samples) **creates restricted demonstration content in production** — sample nodes for demo/
development that are hidden from the public but visible to permitted users, so you can keep example content on a
live site without exposing it. It depends on core Node and provides its own permissions.

Use it to keep demo content on production safely. It is a content/access feature, and it restricts the sample
content the **right way**: it implements **`hook_node_access_records()`** (the node-access-grants system) via a
`samples.node_access` service, so the restriction is a real grant-based access control that is honoured everywhere
Drupal checks node access — the canonical route, **Views, JSON:API/REST and search** — not just the UI. That is the
robust pattern (a positive). Security notes: gate the permission that grants viewing of sample content to the
intended audience, and remember node-access-grants require a rebuild if the grants change. Configure the samples
and their view permission.

---

- Create restricted demo content in production.
- Hide samples from the public.
- Show them to permitted users.
- Depend on core Node + provide permissions.
- Serve content/access.
- Keep demo content on a live site.
- RESTRICT via hook_node_access_records()/grants (robust, not UI-only).
- BE honoured everywhere (canonical, Views, JSON:API, search) — a positive pattern.
- Gate the view-samples permission to the intended audience.
- Rebuild node-access grants when they change.
- Configure the samples + view permission.
- Handle sample content.
- Create samples.
- Configure the samples.
- Restrict content.
- Handle the grants.
- Show demos.
- Gate viewing.
- Use node access grants.
- Provide restricted sample content.
