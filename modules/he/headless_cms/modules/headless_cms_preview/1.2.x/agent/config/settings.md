<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preview — settings, enabled bundles & consumer URL templates

## Enable

```
drush en headless_cms_preview -y
```

Installs two base fields onto the `consumer` entity (`headless_cms_preview_install()` →
`headless_cms_preview.basefields.inc`).

## Settings form (`/admin/config/headless-cms/preview`)

Route `headless_cms_preview.settings` (`_permission: administer headless_cms settings`) →
`Form\HeadlessCmsPreviewSettingsForm`, editing config object `headless_cms_preview.settings`:

| Setting | Config key | Notes |
|---|---|---|
| Enable preview for node bundles | `enabled_bundles` | Checkboxes of node bundles; only these get the Save Preview button |
| Encryption profile | `encryption_profile` | Select of Encrypt profiles; `''` = no encryption. Requires the `encrypt` module (field disabled if absent) |

Schema in `config/schema/headless_cms_preview.settings.yml`; install defaults
`enabled_bundles: []`, `encryption_profile: ''`. When the `encrypt` module is installed, selecting a
profile makes `PreviewTokenManager` encrypt/decrypt the token instead of plain base64. For
production decoupled sites, configure an Encrypt profile.

![Headless CMS Preview settings form](../../../../../../../../../screenshots/headless_cms/1.2.x/preview-settings.png)

(When `headless_cms_preview_nats` is enabled, this form also shows a *NATS Settings* section — see
that submodule's docs.)

## Per-consumer URL templates (`headless_cms_preview.basefields.inc`)

Surfaced under *Consumer → Additional Settings → Headless CMS → Preview*
(`headless_cms_preview_form_consumer_form_alter()`):

| Field | Placeholders supported |
|---|---|
| `headless_cms_preview_url` (Preview URL) | `[preview:entity_type_id]`, `[preview:entity_bundle]`, `[preview:entity_uuid]`, `[preview:owner_id]`, `[preview:token]` |
| `headless_cms_revision_url` (Revision URL) | the above plus `[preview:revision_id]` |

`ConsumerHeadlessPreviewManager::getPreviewUrl()` / `getRevisionUrl()` do a `str_replace()` of these
placeholders to build the concrete URL the editor clicks. Example template:
`https://frontend.example.com/preview?type=[preview:entity_type_id]&uuid=[preview:entity_uuid]&token=[preview:token]`.

## Editor workflow

On an enabled bundle's node form (`headless_cms_preview_form_alter()`):

- A **Save Preview** button (`#access` = preview mode enabled AND the user can create/update the
  node) runs `submitForm` → core `preview` → `_headless_cms_preview_form_save_preview_submit()`,
  which redirects back to the edit form and dispatches `HeadlessPreviewUpdatedEvent`.
- After a preview exists in the form state, a **Preview** details group shows the JSON:API preview
  link, each consumer's built preview URL, and the token value.

The token is generated with `PreviewTokenManager::encode(currentUserId, uuid, entityTypeId,
bundle)`. The frontend passes it back in the `X-Headless-Preview-Token` header — see
[../api/preview.md](../api/preview.md).
