<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set up download counting

## 1. Add a count field to the media type
Counting needs a field to write to. On the media type (e.g. Document), add a **Number (integer)** or **Text** field — any non-base `integer`, `string`, or `string_long` field qualifies. Without one, the config fieldset shows a "no text field" notice.

## 2. Enable counting on the media type
Go to **Structure → Media types → (type) → Edit**. In **Media Download Count configuration**:
- Check **Activate media download counter**.
- In **Count field**, select the field added in step 1.

These are saved as third-party settings (`enable_count`, `count_field`) on the media-type config entity.

## 3. Global settings
**Admin → Configuration → Media → Media Entity Download Count Settings**
(`/admin/config/media/download/count/form/settings`, permission `administer media entity download count`):
- **Excluded file extensions** — space-separated list; useful to skip private image derivatives.

## 4. Permissions
- `administer media entity download count` — reach the settings form.
- `skip media entity download counts` — users with this are **not** counted (grant to admins/editors so previews don't inflate totals).

## How a download is counted
`hook_file_access($file, 'download', $account)`:
1. Skips the `media/add` flow and users holding the skip permission.
2. Finds the referencing entity via `file_get_file_references()`.
3. Reads the media type's configured `count_field`, increments it, `Media::save()`.
4. Logs `%file downloaded by user #%uid from %ip` to the `media_entity_download_count` channel.

**Caveats:** the increment is a non-atomic read-modify-write on the download (read) path, so parallel downloads can under-count; every counted download re-saves the media entity (creating a revision if the type is revisionable).
