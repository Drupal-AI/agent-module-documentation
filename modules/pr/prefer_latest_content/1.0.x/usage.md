<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prefer Latest Content lets roles that hold one permission automatically see the newest pending draft of a node instead of the published default revision.
---
When a user with the `prefer latest content` permission views a published node's canonical page, `hook_preprocess_html()` checks whether a newer forward revision exists whose moderation state is `draft` (`Utils::getLatestRevisionOnlyIfDraft`, prefer_latest_content/src/Utils.php:200) and, if so, issues a 302 redirect to `/node/{nid}/latest`. The administrator role is explicitly excluded, and anonymous users never trigger the behaviour. A small library is attached on every page for users with the permission.

The module is read/redirect-only: it grants no ability to edit or publish, and the `/node/{nid}/latest` route is still gated by core's own "view latest version" access. Note the redirect logic in the `.module` file is convoluted (several `!$route_match == '...'` comparisons that always evaluate the same way) and the language-prefix handling assumes an `en`/`fr` bilingual setup (`getLatestRevisionOnlyIfDraft` hard-codes the other language as `fr`/`en`) — worth reviewing before use on differently-configured sites.

Typical setup: enable the module and grant `prefer latest content` to the desired non-admin roles.
---
- Grant `prefer latest content` to an editor role.
- Let reviewers land on the latest draft when opening a published node.
- Keep anonymous visitors on the published revision.
- Exclude administrators from the redirect.
- Combine with Content Moderation draft states.
- Preview pending edits without manually visiting the latest-version tab.
- Use alongside Workbench/moderation editorial flows.
- Attach the module library only for permitted users.
- Restrict draft visibility to trusted roles.
- Audit which roles hold the permission.
- Vary page cache correctly by user role.
- Return anonymous users straight to canonical output.
- Support Content Moderation forward revisions.
- Avoid exposing drafts to the public.
- Review pending edits inline on the canonical URL.
- Limit the behaviour to authenticated editors.
