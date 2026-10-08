# Configuration

Field Redirect is configured entirely from a single **text area** on its settings
page. Each line is one rule that says: for a given entity type and bundle, which
field supplies the redirect destination, and what to do when that field is empty.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Search and metadata → Field Redirect**, or navigate
   directly to `/admin/config/search/field-redirect`.

## Rule syntax

Each line follows this shape:

```
entity_type:bundle|field_name#status,field_name#status
```

- **`entity_type`** — the entity to act on: `node`, `user`, `taxonomy_term`, etc.
- **`bundle`** — the specific bundle (content type, vocabulary, …). Use `*` for
  *all* bundles. For `user`, which has no bundles, omit the `:bundle` part.
- **`field_name`** — the machine name of the **link**, **file**, or **image**
  field whose URI is used as the redirect target.
- **`#status`** *(optional)* — the HTTP status code to send. Supported values:
  - `#301` — Moved Permanently
  - `#302` — Found
  - `#303` — See Other
  - `#307` — Temporary Redirect *(the default when you don't specify one)*
  - `#403` — return **403 Forbidden** instead of redirecting
  - `#404` — return **404 Not Found** instead of redirecting

You can list **several fields separated by commas** as a fallback chain: the
module tries each in order and uses the first one that has a value. A bare
`#403` or `#404` (with no field) is a final fallback that returns that status.

## Worked examples

```
node:article|field_source_url#301,#403
```
For **Article** nodes, redirect to `field_source_url` with a **301 Moved
Permanently** if it has a value; if it's empty, return **403 Forbidden**.

```
node:page|#404
```
For **Basic page** nodes, always return **404 Not Found** — handy when you never
want the details page shown.

```
taxonomy_term:*|field_overview_url,field_wiki_url
```
For **all taxonomy vocabularies**, redirect (default **307**) to
`field_overview_url` if set; otherwise to `field_wiki_url` if set; otherwise
display the term page normally.

```
user|field_sns_url
```
For **user** entities, redirect (default **307**) to `field_sns_url` if set;
otherwise display the user page normally.

Put one rule per line. A full form might read:

```
node:article|field_source_url#301,#403
node:page|#404
taxonomy_term:*|field_overview_url,field_wiki_url
user|field_sns_url
```

## Save

Click **Save configuration**. Rules take effect immediately — open a matching
entity to confirm the redirect (or the 403/404) behaves as you expect.
