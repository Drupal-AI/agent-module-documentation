# Configuration

Domain Redirect needs no setup of its own — the moment it is enabled, the Redirect
module becomes domain-aware. All you do is choose a domain when creating or editing
a redirect.

## Scope a redirect to a domain

1. Log in as a user who can administer redirects.
2. Go to **Configuration → Search and metadata → URL redirects**
   (`/admin/config/search/redirect`).
3. Add a new redirect or edit an existing one.
4. Use the **Domain** selector on the form:
   - Pick a specific domain to make the redirect apply **only** on that domain.
   - Leave it set to **All domains** for a global redirect that applies
     everywhere.
5. **Save**.

You can now create the *same* source path more than once — for example one entry
scoped to `example1.com` and another to `example2.com` — each pointing at a
different destination. The module's domain-aware duplicate check allows this,
whereas plain Redirect would reject the second entry as a duplicate.

## Precedence

When a source path matches both a domain-specific redirect and a global (all
domains) redirect, the **domain-specific redirect wins** on that domain. This lets
you set a sensible global default and override it only on the domains that need
something different.

## Finding and filtering redirects

The redirect listing gains a **Domain** column showing each redirect's scope, plus
an exposed **Domain** filter above the list. Use the filter to narrow the listing
to a single domain when managing a large set of redirects across many domains.
