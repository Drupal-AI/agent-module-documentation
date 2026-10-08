# Configuration

Setting GSearch up has two parts: entering your Dataforsyningen API token once on
the module's settings form, then adding one or more address fields where you need
them.

## 1. Enter your Dataforsyningen token

1. Log in as a user with **Administer site configuration**.
2. Go to **Configuration → GSearch → Configuration**
   (`/admin/config/gsearch/config`).
3. Paste your Dataforsyningen **API token** into the token field. The module
   validates the token automatically when you save, so you get immediate feedback
   if it is wrong.
4. There is also an **API base URL** setting. It defaults to the official
   endpoint (`https://api.dataforsyningen.dk/rest/gsearch/v2.0/`) and you rarely
   need to change it — leave it as is unless you are pointing at a proxy or a
   different Dataforsyningen environment.

### Keep the token out of committed configuration

The token is a shared secret and this project's convention is to store secrets in
an environment variable rather than in exported site configuration. With DDEV:

```bash
ddev dotenv set .ddev/.env --gsearch-token=YOUR_TOKEN_HERE
ddev restart
```

(Never commit `.ddev/.env`.) You can then surface the value through a **Key**
entity and reference it, rather than typing the raw token into a form that gets
exported. Because the autocomplete endpoints are reachable by anonymous visitors
and consume your Dataforsyningen quota, consider putting a rate limit in front of
the site if the API is billed or throttled.

## 2. Add an address field

1. Go to **Structure → Content types** (or any fieldable entity type — user
   profiles, taxonomy terms, and so on) and choose **Manage fields → Add field**.
2. Choose the **"Address Dataforsyningen / GSearch"** field type and give it a
   label.
3. Complete the field settings.

### Per‑field option: allow free‑text addresses

Each field has an **"Allow storing free‑text addresses"** setting. Leave it off to
force editors to pick a validated address from the register — the safest choice
for data quality. Turn it on when you also need to accept addresses the register
does not know, such as international or informal ones; the field will then store
whatever the editor types if no suggestion matches.

## What gets stored

When an editor selects a suggestion, the field stores a **normalised address**
along with the **postal code**, **postal name**, and **latitude/longitude** when
the register provides them. That structured data is what makes the field useful
for mapping, delivery, and deduplication — not just display. Single and multiple
addresses are rendered through the module's bundled Twig templates.
