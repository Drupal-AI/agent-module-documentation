# Configuration

Configuring this module has two parts: adding your monday.com **API token** (once,
in `settings.php`), and attaching and configuring the relay **handler** on each
webform you want to feed into monday.com.

## 1. Add the monday.com API token (kept out of config)

By design, the token is **not** entered in the admin UI and is **not** stored in
configuration — so it never ends up in `config:export` output, your repository, or
failure logs. Instead, Drupal reads it from the Settings API. Add this to your
`settings.php` (or an environment-specific settings file):

```php
$settings['monday_crm_integration']['api_token'] = getenv('MONDAY_API_TOKEN');
```

Keep the actual token value in an environment variable rather than in the file.
On this project, store it with DDEV's dotenv helper (never committed) and restart:

```bash
ddev dotenv set .ddev/.env --monday-api-token=<your-token>
ddev restart
```

The flag becomes the environment variable `MONDAY_API_TOKEN` in the web
container, which the `getenv()` call above reads. Because the module calls
monday.com's servers, make sure your site's outbound network allows HTTPS
requests to monday.com's GraphQL API. You can generate an API token in
monday.com's developer settings.

## 2. Attach and configure the handler

1. Go to **Structure → Webforms**, open the form you want to relay, and choose
   **Settings → Emails / Handlers**.
2. Click **Add handler** and pick **monday.com — Create board item**.
3. Fill in the handler settings:

   - **Monday board ID** — the numeric board id, visible in the board's URL on
     monday.com.
   - **Item name template** — how each created item is titled. Supports standard
     Webform tokens such as `[webform_submission:values:full_name]`. Leave it
     empty to fall back to a sensible default ("Submission from *(webform
     label)*").
   - **Field → column mapping** — a compact YAML block mapping Drupal Webform
     field keys to monday.com column IDs. Supported column types include `text`,
     `email`, `long_text`, `phone`, `status` and `dropdown`. Leave a `column_id`
     empty to collect a field but not relay it. See the handler's inline help for
     the exact YAML shape.
   - **Phone column country shortname** — the ISO 3166-1 alpha-2 country code sent
     with phone column values (default `JP`). Set it to match your audience's
     region.
   - **Lead source default** *(optional)* — set a constant `status`-column value
     on every item from this form (for example, tag all submissions as "Website
     inquiry") so they are distinguishable from items created by hand.
   - **Failure handling** — choose what happens when monday.com is unreachable:
     - *Validation-blocking* — the submitter sees a customisable error message and
       can retry; the submission is not saved until the relay succeeds. Best when
       capturing the lead is essential.
     - *Fire-and-forget* — the submitter always sees the confirmation; any failure
       is logged with redacted diagnostics. Best when the form's user experience
       matters more than a guaranteed relay.

4. **Save** the handler.

You can repeat this for as many webforms as you like — each handler attachment is
configured independently, so different forms can feed different boards with
different mappings.

## 3. Test it

Submit a test entry on the webform, then check the target monday.com board for the
created item. If nothing appears, check Drupal's log at
**`/admin/reports/dblog`** — relay failures are logged there (with the token
redacted).
