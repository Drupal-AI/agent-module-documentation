# Replicate Actions — agent index

Adds post-clone behaviour on top of Replicate + Replicate UI: cloned entities become unpublished/draft,
owned by the current user, re-added to their original Groups, and opened in edit mode. Depends on
`replicate` and `replicate_ui`. No permissions of its own, no Drush, no plugin types.

- **The one setting (`follow_default_moderation_state`) and its config route** →
  [configure/settings.md](configure/settings.md)
- **What actually happens on replication — the event subscribers, moderation/group/redirect logic, and exemptions** →
  [api/behavior.md](api/behavior.md)

Key facts:
- Config route `replicate_actions.settings` = `/admin/config/content/replicate/actions`, gated by core
  `administer site configuration` (shown as a tab beside Replicate UI settings).
- Behaviour is delivered via event subscribers on Replicate's `REPLICATE_ALTER` / `AFTER_SAVE` events
  (registered in `replicate_actions.services.yml`) plus a `hook_form_alter` redirect on `*_replicate_form`.
- `ReplicateSetEntityEdit` is present in code but **not** registered as a service (inactive).
