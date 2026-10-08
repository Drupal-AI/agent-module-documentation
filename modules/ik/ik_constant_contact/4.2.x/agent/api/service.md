# The `ik_constant_contact` service

Service id `ik_constant_contact` → `Drupal\ik_constant_contact\Service\ConstantContact`. All API
traffic to Constant Contact v3 (`https://api.cc.email/v3`) goes through it, using Guzzle
(`http_client`) with a Bearer access token. Get it with
`\Drupal::service('ik_constant_contact')`.

## Submitting contacts

| Method | Purpose |
|---|---|
| `submitContactForm(array $data, array $listIDs): ?array` | Preferred signup path (as of 2.0.9). POSTs to `/contacts/sign_up_form`. Validates credentials, non-empty `$listIDs` all enabled, and `$data['email_address']`. Refreshes tokens first. Returns `['error' => …]` on failure, else NULL. |
| `postContact(array $data, array $listIDs): ?array` | Older path. Looks up the contact (`getContact`) then routes to `updateContact` / `putContact` (resubscribe deleted) / `createContact`. |
| `unsubscribeContact(array $data)` | Finds the contact and PUTs `permission_to_send = unsubscribed`. |

`$data` keys: required `email_address`; optional `first_name`, `last_name`, `company_name`,
`job_title`, `street_address` (assoc → object), `phone_number`, `birthday`
(`{month, day}`), `anniversary`, and `custom_fields` (`{ <uuid>: value }`).
`buildResponseBody()` maps these onto the API body; the three `*_data_alter` hooks fire so other
modules can extend the payload (see [../hooks/data-alter.md](../hooks/data-alter.md)).

## Lists / fields / campaigns (reads)

| Method | Returns |
|---|---|
| `getContactLists($cached = TRUE)` | All account lists (keyed by `list_id`); caches under `ik_constant_contact.lists`; refreshes token. |
| `getEnabledContactLists($cached = TRUE)` | Only lists flagged in `ik_constant_contact.enabled_lists`. |
| `getCustomFields($cached = TRUE)` | Account custom fields (stdClass with `custom_fields`). |
| `getCampaigns($status = [])` | Email campaigns, optionally filtered by status. |
| `getCampaign($id)` / `getCampaignActivity($id)` / `getPermaLinkFromCampaign($id)` | Single campaign / activity / permalink URL. |

## Auth / tokens

| Method | Purpose |
|---|---|
| `getConfig()` | Merged settings: client_id/secret (settings.php or config), auth_type, tokens, endpoint URLs, and the static `fields` / `address_subfields` maps. |
| `refreshToken($updateLists = TRUE)` | POSTs refresh_token grant, `saveTokens()`, optionally re-fetches lists. Called before each request. |
| `saveTokens($data)` | Persists access/refresh tokens to the `ik_constant_contact_tokens` table (or legacy config if the table is missing). |
| `deleteExpiredTokens()` | Removes stale token rows (called from cron). |
| `generateCodeVerifier()` / `getCodeChallenge($v)` / `base64UrlEncode($s)` | PKCE helpers (PKCE flow currently disabled). |

## Notes

- Errors from the API are normalized by `handleRequestException()` / `handleResponse()` into
  `['error' => <message>]` and logged to the `ik_constant_contact` channel; success returns
  `['method' => …, 'response' => <status>]` (or the contact for `getContact`).
- Every write refreshes tokens first, so a stale access token self-heals if the refresh token is
  valid.
- `email_address` in `getContact()` is sent as a query param to the Constant Contact API (external
  URL), not to any local query — it is user data forwarded to the third-party service.
