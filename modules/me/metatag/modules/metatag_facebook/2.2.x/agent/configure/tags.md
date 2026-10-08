# Facebook tags

Adds a "Facebook" MetatagTag group. Emitted as `<meta property="fb:…">`:

- `fb:app_id` — associate a Facebook App (Insights, Login).
- `fb:admins` — Facebook admin user IDs for Domain Insights.
- `fb:pages` — associate the content with Facebook Page IDs.

Set in any Metatag defaults entity or the per-entity field; token-enabled. Use together
with `metatag_open_graph`. Schema: `config/schema/metatag_facebook.metatag_tag.schema.yml`.
