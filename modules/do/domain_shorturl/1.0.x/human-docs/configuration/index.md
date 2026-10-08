# Configuration

Domain Short URL has one settings form and one everyday task: choosing how slug
counters are scoped, and assigning a domain each time you create a short URL.

## Settings form — counter scope

1. Log in as a user with the **`administer shorturl`** permission.
2. Go to **Configuration → Domain → Short URL**, or navigate directly to
   `/admin/config/domain/shorturl`.
3. Set **Counter scope**:
   - **Per domain** — each domain keeps its own auto-increment counter, so
     automatically generated slugs number independently on each domain.
   - **Global** — a single counter is shared across all domains.
4. **Save**.

## Assigning a domain to a short URL

When you add or edit a short URL, use the **Domain** selector on the form to choose
which domain the short URL belongs to. This determines:

- **The URL that is built** — the short URL uses the chosen domain's hostname and
  path prefix, so links in emails, exports, and QR/download output point at the
  right domain.
- **Slug uniqueness** — the same slug (for example `/blog`) can exist on more than
  one domain, because uniqueness is checked per `(domain, language)` pair rather
  than globally.
- **Redirects and visit tracking** — the redirect is stamped with the domain, and
  each visit is recorded against it.

By default the selector is **filtered to the domains you are assigned** through
Domain Access. Grant the **`create shorturl on any domain`** permission (a
restricted permission) to users who need to create short URLs on domains they are
not otherwise assigned to; it bypasses that filtering.

## Permissions summary

| Permission | What it allows |
|------------|----------------|
| `administer shorturl` | Access the settings form (counter scope). |
| `create shorturl on any domain` | Pick any domain in the short-URL form's domain selector, regardless of Domain Access assignment. |
