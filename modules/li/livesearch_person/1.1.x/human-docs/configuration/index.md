# Configuration

Configuration happens in two steps: enter the directory service credentials once,
then set up field mapping on each webform where you want the lookup.

## 1. Service credentials

1. Log in as a user with the **administer livesearch** permission.
2. Go to **Configuration → Web services → Live Search - Person**
   (`/admin/config/services/livesearch-person`).
3. Set:
   - **Live Search URL** — the directory endpoint, for example
     `https://search.datafactory.online/person/`. The module appends the search
     string to this URL when it queries the service.
   - **API key** — your Data Factory Live Search key. The module sends it as an
     `X-API-Key` header on the outbound request.
   - **Debug JavaScript** *(optional)* — a flag that enables debug output on the
     front end; leave it off in production.
4. Use the **Test Connection** tab
   (`/admin/config/services/livesearch-person/test`) to confirm the endpoint and
   key work.
5. Save.

> **About the API key and data handling.** The key is stored server‑side in the
> module's configuration (`livesearch_person.livesearchconfig`) and the outbound
> call runs over the configured HTTPS URL with normal TLS verification, so the key
> never reaches the browser. Still, treat it as a secret: if you export and deploy
> configuration, avoid committing the key value — prefer a per‑environment override
> so it stays out of Git. And remember the outbound request is **egress to a
> third‑party service** returning **PII** (names, addresses, dates of birth) —
> confirm that's acceptable for your site and your data‑protection obligations.
>
> **Restrict who can trigger lookups.** The internal search route
> (`/livesearch-person/search-directory`) is gated only by the **access content**
> permission, which anonymous users hold on a default site. Anyone who can load the
> form can therefore drive lookups through your stored key. If the directory is
> sensitive, tighten `access content`, or front the feature with an authenticated
> route/form.

## 2. Per‑webform field mapping

1. Go to the webform you want to enhance and open its settings — the Live Search tab
   lives at `/admin/structure/webform/manage/{webform}/settings/livesearch`. (You
   need permission to update that webform.)
2. **Pick the search field** — the webform element the visitor types into to search
   the directory.
3. **Map result properties onto webform elements** — connect the returned person
   properties to the form fields that should autofill:
   - `fullname` — full name
   - `firstname` / `lastname` — first and last name
   - `final_address` — street address
   - `city` — city
   - `zipcode` — postal code
   - `date_birth` — date of birth
4. Save the webform settings.

## How it behaves at runtime

The module's JavaScript watches the chosen search field. As the user types, it
posts the query to the internal route, which calls the directory API with your key,
decodes and normalizes the returned records, and returns them to the browser, where
the mapped values autofill the corresponding webform fields. A loading indicator
shows while the lookup runs.
