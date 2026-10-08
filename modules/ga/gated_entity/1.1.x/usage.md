<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gated Entity locks the rendered display of chosen node types behind a pluggable "locker", shipping a default login-to-unlock locker.
---
On the config page (`/admin/config/content/gated-entities`, permission `configure gated entities`) an admin selects which node types are gated and which locker plugin applies (default `login_locker`). At render time `hook_entity_view_alter()` asks the `gated_entity.helper` service whether the entity is gated and locked for the current user; if so it registers a `#post_render` callback (`GatedEntityCallback::postRender`). That callback discards the fully rendered entity markup and returns only the entity title plus the locker's render array (for the login locker, a "Login to unlock" link). Lockers are `@GatedEntityLocker` plugins whose `checkAccess()` decides whether content is shown — `LoginLocker` returns TRUE for any authenticated user.

Security/operational posture worth flagging: enforcement is at the **render/presentation layer only**. `postRender` replaces the rendered string, so the gated body is not delivered in that page's HTML — but the module does **not** use Drupal node-access grants, so the underlying node stays fully readable through other channels (JSON:API/REST, Views field output, search indexing, the node edit form, other view modes). The gate also treats "unlocked" as merely "authenticated" for the default locker — any logged-in user passes, regardless of role. Use it as a soft/marketing gate, not as real access control for sensitive content. The admin config route itself is properly permission-gated and does not over-grant.

Setup: enable the module, open the config form, tick the node types to gate and pick a locker.
---
- Gate the full-page view of selected node types.
- Require visitors to log in before reading a body ("login to unlock").
- Pick which node types are locked on the config form.
- Choose the default locker plugin for gated entities.
- Show a call-to-action (login link) in place of gated content.
- Build a soft paywall / registration wall for marketing content.
- Keep the node title visible while hiding the body.
- Add a custom locker by implementing a `@GatedEntityLocker` plugin.
- Reference a custom unlock form via the plugin's `form_class`.
- Restrict configuration to trusted roles with `configure gated entities`.
- Apply gating across all view modes that go through entity view.
- Encourage account creation to view premium articles.
- Combine with real node access when true protection is required (this module is presentation-only).
- Audit which node types are currently gated via `gated_entity.config`.
- Swap the login locker for a password/other locker plugin.
- Provide a consistent "members only" teaser experience.
- Understand that JSON:API/REST/Views still expose gated nodes.
- Understand that any authenticated user passes the default login locker.
