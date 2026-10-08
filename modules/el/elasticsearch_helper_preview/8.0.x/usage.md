<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Elasticsearch Helper Preview adds a "preview" capability for decoupled Drupal: an editor can preview an unsaved/draft entity in the front-end application by staging the current form values into a temporary Elasticsearch index and being redirected to the app's preview URL.
---
Settings live at `/admin/config/search/elasticsearch_helper/preview` (route `elasticsearch_helper_preview.settings`, permission `administer site configuration`) where you set the front-end base URL and the temporary preview-index expiration. Per content index you enable preview and set a preview path template (via a third-party-settings alter on the `elasticsearch_content_index` form). On a node form the `PreviewHandler` adds a preview button; submitting stores the built document in the private tempstore and produces a link to `/elasticsearch-preview/{preview}`. A custom param converter loads that tempstore entry, and `PreviewController::preview()` returns a `TrustedRedirectResponse` to `base_url + preview_path`. Expired preview indices are cleaned up on cron.

Security posture is sound on the sensitive path: the `elasticsearch-preview/{preview}` route uses `_custom_access` → `PreviewController::access()`, which returns `AccessResult::allowedIf($entity->access('update'))` — so only a user who can edit that entity may follow the preview, preventing unpublished/draft content from leaking to unauthorized users. The redirect target is built from admin-configured base URL + configured preview path (not raw user input), and the preview payload is held in the per-user private tempstore. Operate it by configuring the base URL, enabling preview on the relevant index, and using the editor's preview button.
---
- Preview draft/unsaved content in a decoupled front-end app.
- Stage the current form values into a temporary Elasticsearch index.
- Redirect editors to the front-end preview URL automatically.
- Set the front-end application base URL in settings.
- Configure preview-index expiration time.
- Enable preview per Elasticsearch content index.
- Define a preview path template with `{_index}`/`{_id}` placeholders.
- Add a preview button to node edit forms.
- Gate preview access to users who can update the entity.
- Keep preview payloads in the per-user private tempstore.
- Clean up expired preview indices via cron.
- Support any content entity type (node by default).
- Provide draft-mode links for headless editorial workflows.
- Avoid publishing to preview by using temporary indices.
- Restrict settings to `administer site configuration`.
- Redirect only to the configured trusted front-end URL.