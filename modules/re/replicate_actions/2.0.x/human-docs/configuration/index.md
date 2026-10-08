# Configuration

Replicate Actions works the moment it's enabled — cloned content is set
unpublished/draft, reassigned to you, re-added to its Groups, and opened for
editing, with nothing to configure. The one setting on this page only matters if
you use **Content Moderation**.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Replicate → Actions**, or navigate
   directly to `/admin/config/content/replicate/actions`. It appears as a tab next
   to *Replicate UI Settings*.

## The setting

- **Follow default moderation state** (`follow_default_moderation_state`,
  default **off**) — this decides which moderation state a cloned, moderated
  entity is put into:
  - **Off (recommended)** — the clone is set to the workflow's **draft** state if
    that state exists; otherwise it falls back to the workflow's default state.
    This is the safe choice, keeping copies out of any published state.
  - **On** — the clone is set to the workflow's configured **default moderation
    state**. Be aware that a workflow's default state *can* be a published one, in
    which case turning this on could publish clones immediately — so only enable
    it if that's genuinely what you want.

If Content Moderation is **not** installed, the form shows a notice and the
setting has no effect — clones are simply set unpublished.

Click **Save configuration** to apply your choice.

## Set it from the command line (optional)

```bash
ddev drush config:set replicate_actions.settings follow_default_moderation_state false -y
```
