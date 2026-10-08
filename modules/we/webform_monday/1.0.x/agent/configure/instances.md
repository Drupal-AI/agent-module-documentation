<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Webform Monday.com

1. **Store the token as a Key** (module depends on `key`): create an authentication Key holding your Monday.com API token. The module reads it via `key.repository` — the token never lives in module config.
2. **Add a Monday instance** at `/admin/config/services/monday` (`webform_monday_instance` config entity). Each instance selects the Key (`getApiKeyId()`) and is the connection a handler targets. Use **Test connection** (`MondayClient::testConnection`, `{ me { name } }`) to verify.
3. **Global settings** at `/admin/config/services/monday/settings`: `api_version` (default `2024-10`), `timeout` (default 30s), and `debug` (logs full request/response to the `webform_monday` channel — leave off in production).
4. **Attach the handler** to a webform and map elements to board columns. Read-only Monday column types (formula, mirror, item_id, etc.) are excluded automatically. Board/column metadata is cached 5 minutes, tagged with the instance's cache tags (auto-invalidated on save/delete).

Requests POST to Monday's HTTPS GraphQL endpoint with the token in the `Authorization` header over the default Guzzle client (TLS verification enabled). `create_item` mutations create one item per submission; `create_labels_if_missing` can add missing labels.
