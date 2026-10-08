<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Billwerk Subscriptions

## 1. API credentials
Settings form: `/admin/config/services/billwerk-subscriptions/settings` (permission `administer billwerk_subscriptions configuration`). Provide the Billwerk API key and select the environment (`src/Environment.php` / `src/SettingsHelper.php` resolve the base URL). Requests go out through `src/Api.php`; enable the suggested `http_client_logger` to debug Guzzle traffic.

## 2. Plan → role mapping
`src/BillwerkRolesManager.php` grants/revokes Drupal roles based on the user's active Billwerk contract/plan. Configure which subscription plans map to which roles in the settings form.

## 3. Webhook
Register `/billwerk-subscriptions/webhook-listener/{secret}` in the Billwerk dashboard, substituting the shared secret configured in Drupal. The controller compares the `{secret}` path segment to the stored value with strict `===`, then re-fetches the subscription details from the Billwerk API — so the request body is never trusted for state. Keep the secret out of logs/VCS.

## 4. Self-service & actions
- `/user/{user}/subscription/refresh` — logged-in users can trigger a resync (custom access check).
- Permissions `billwerk_subscriptions_selfservice_manage_own_contract` / `..._manage_any_contract` gate the embedded self-service (`src/EmbedHelper.php`) on user profiles.
- `billwerk_subscriptions_fetch_assign_contract_ids` enables the action that maps Billwerk ExternalId → Drupal UID.
