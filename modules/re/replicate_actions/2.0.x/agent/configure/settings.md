# Settings

One config object, `replicate_actions.settings`, one form (`ReplicateActionsSettingsForm`) at
`/admin/config/content/replicate/actions` (route `replicate_actions.settings`, permission
`administer site configuration`). It appears as a local task tab next to *Replicate UI Settings*.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `follow_default_moderation_state` | bool | `false` | Only relevant when Content Moderation is installed. **FALSE (recommended):** replicated content is set to the workflow's `draft` state if that state exists, otherwise the workflow default. **TRUE:** replicated content is set to the workflow's configured `default_moderation_state` (which may be a published state). |

If Content Moderation is not installed the form shows a warning and the setting has no effect (clones are
simply set unpublished).

Set via Drush:
```bash
ddev drush config:set replicate_actions.settings follow_default_moderation_state false -y
```

The setting is read by `ReplicateSetUnpublished::getModerationState()` — see
[api/behavior.md](../api/behavior.md) for the full resolution order.
