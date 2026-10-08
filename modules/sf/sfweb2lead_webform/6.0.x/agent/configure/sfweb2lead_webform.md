# sfweb2lead_webform — configure the handler

No module settings page. Configure per webform:
**Structure → Webforms → [your form] → Settings → Emails / Handlers → Add handler →
"Salesforce Web-to-Lead post"**.

## Settings (`defaultConfiguration`)
| Key | Type | Default | Purpose |
|---|---|---|---|
| `salesforce_url` | url (**required**) | `''` | Full Salesforce Web-to-Lead POST URL, e.g. `https://www.salesforce.com/servlet/servlet.WebToLead?encoding=UTF-8`. |
| `salesforce_oid` | textfield (**required**) | `''` | Your Salesforce org OID (sent as `oid`). Public identifier, not a secret. |
| `salesforce_mapping` | webform_mapping | `[]` | Maps webform elements → Salesforce campaign fields. Only mapped fields are posted. |
| `custom_data` | YAML (codemirror) | `''` | Extra data included in the post; may use tokens. |
| `excluded_data` | array | `[]` | Inherited from RemotePost (fields to exclude). |
| `type` | string | `x-www-form-urlencoded` | Post content type. |
| `debug` | checkbox | `FALSE` | If on, posted submission is displayed on-screen **to all users**. |

## Salesforce campaign fields available in the mapping
`description`, `email`, `first_name`, `last_name`, `lead_source`, `phone`
(destination is a `webform_select_other`, so custom Salesforce field names can be typed).
Composite element sub-fields appear as `element_subkey` sources.

## How the payload is built (`getRequestData`)
1. Starts from the parent RemotePost request data.
2. Adds `oid` = `salesforce_oid`.
3. For each webform value whose key is in `salesforce_mapping`, sets
   `salesforce_data[<mapped SF field>] = value` (composite values flattened to `key_subkey`).
4. Merges `custom_data` (YAML) for keys present in the submission data.
5. Dispatches `Sfweb2leadWebformEvent::SUBMIT` (`sfweb2lead_webform.submit`) so modules can
   alter the array, then returns `$event->getData()`.

## Posting (`remotePost`)
Only posts on `STATE_COMPLETED`: it copies `salesforce_url` into the parent handler's
`completed_url` and defers to `RemotePostWebformHandler::remotePost()` (which handles the
HTTP request, logging, and error/debug display).

## Notes
- The handler is `CARDINALITY_UNLIMITED` — add several (e.g. multiple orgs/endpoints) to one
  webform.
- No credentials are stored beyond the public OID; Web-to-Lead does not use an API secret.
- Test data mapping with `debug` on **in a non-public/staging context only** (it prints to
  screen for everyone).
