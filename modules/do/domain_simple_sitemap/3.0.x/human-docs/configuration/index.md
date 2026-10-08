# Configuration

Domain Access Simple Sitemap's own settings form is deliberately small — the real
work (which content is indexed, when sitemaps are generated) happens in Simple XML
Sitemap. This page covers the two toggles it adds, the bulk‑generate button, and
how the pieces fit together.

## Open the settings form

1. Log in as a user with the **Administer domains** permission (from Domain
   Access).
2. Go to **Configuration → Domain → Domain Access Simple Sitemap**, or navigate
   directly to `/admin/config/domain/domain_simple_sitemap/config`.

## The two toggles

- **Filter by node source instead of node access** — by default, each domain's
  sitemap includes content according to Domain Access's node *access* rules (what
  a visitor on that domain may see). Turn this on to filter by the node's *source*
  domain (the Domain Source field) instead, so a domain's sitemap lists the
  content that originates on it rather than everything it can access.

- **Replace homepage** — when on, any link in the sitemap that matches a domain's
  configured front page is rewritten to that domain's clean base URL (so the
  homepage appears as `https://example.com/` rather than a node path). This option
  needs **Domain Configuration** or **Domain Site Settings** to know each domain's
  front page — if neither is installed, the checkbox is disabled.

Both toggles are off by default.

## The "Generate domain's sitemap variants" button

The form also has a **Generate domain's sitemap variants** button. Pressing it
runs a batch that creates a sitemap variant for every active domain. Use it when
you install the module on a site that already has domains (variants for domains
created *after* installation are made automatically). A link on the form —
"You can check existing sitemap variants of domains" — takes you to the Simple XML
Sitemap list where the variants appear.

## Completing the setup in Simple XML Sitemap

The toggles above only shape how the sitemaps are filtered. To actually populate
and publish them:

1. In **Simple XML Sitemap** settings, for each content type enable *"Index
   entities of type … in variant …"* against the relevant domain variant.
2. Run Simple XML Sitemap's **Rebuild queue & generate**.
3. Each domain then serves its sitemap at `<domain>/sitemap.xml`.

## Save

Click **Save configuration** to store the two toggles. Regenerate your sitemaps
through Simple XML Sitemap afterwards so the change takes effect in the output.
