# Configuration

SEO Supercharged needs an API key and a field mapping before the platform can
publish into your site. Both are set on one settings form, and the last step is
copying the key and endpoint URL into the platform.

## Open the settings form

1. Log in as a user with the **Administer SEO Supercharged**
   (`administer seo supercharged`) permission.
2. Go to **Configuration → Content authoring → SEO Supercharged**, or navigate
   directly to `/admin/config/content/seo-supercharged`.

## Set or generate the API key

The form lets you **set or generate an API key**. This key is what the SEO
Supercharged platform uses to authenticate its requests — it sends it in the
`X-API-KEY` header (a legacy `Authorization: Bearer` header is also accepted).

Treat this key as highly sensitive. A request authorized by the key alone creates
content as **user 1** and bypasses node access, so the key is effectively an
administrator credential. Until a key is configured, anonymous requests to the
endpoints are rejected. Store the key securely and rotate it if you suspect it has
leaked.

## Map your field names

The form is where you tell the module which fields on your content type hold what:

- The **body / content** field (plain text or a Paragraphs reference).
- The **featured image** field (entity reference to the `seo_supercharged` media
  bundle).
- Optional **gallery image** and **taxonomy** (category and tag) fields.
- A **Metatag** field, if present, so the module can write SEO title, description,
  canonical URL, and Open Graph tags.

You can also configure the **image sideloading limits** — the maximum image size,
the request timeout, and the redirect limit — which back up the module's built-in
SSRF protections (HTTPS-only fetches that block localhost, link-local, and
cloud-metadata hosts and private IP ranges).

## Connect the platform

Once the key is set and fields are mapped:

1. Copy the **endpoint base URL** and the **API key** from this form.
2. Paste them into your SEO Supercharged platform settings.

From then on the platform publishes articles and images straight into your
Drupal site. If you migrated from WordPress, the platform can keep using its
WordPress-style paths — the module also answers on
`/wp-json/wp-seo-supercharged/v1/...` — so no reconfiguration is needed there.

## Save

Save the form. Do a test push from the platform and confirm a node is created and
any image lands in the Media Library.
