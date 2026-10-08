# Configuration

Domain Path Redirect has no global settings form. Instead it gives you a dedicated
admin listing where you create, edit, and delete per-domain redirects, one entity
at a time.

## Open the listing

1. Log in as a user with the **Administer redirects** permission (the same one the
   Redirect module uses).
2. Go to **Configuration → Search and metadata → Domain Path Redirect**, or
   navigate directly to `/admin/config/search/domain_path_redirect`.

The listing shows every domain path redirect you have created, with add, edit, and
delete actions.

## Create a domain path redirect

1. Click the **Add** action link on the listing.
2. Fill in the redirect form. It mirrors an ordinary Redirect entry, adapted so
   the source can be entered the same familiar way:
   - **From / source path** — the path you want to redirect *from* on the chosen
     domain (for example `/node/2`).
   - **To / destination** — where it should redirect *to* (an internal path such
     as `/node/25`, or an external URL).
   - **Domain** — the domain this redirect applies to, so the same source path can
     resolve differently on each domain.
   - **Redirect type** (the entity's *bundle*) — if more than one type is
     configured, choose the one you want; this lets you group or categorise
     redirects.
3. **Save**.

Repeat for each domain that needs its own destination for the same source path.

## Managing redirects

- Edit or delete any entry from the listing's row actions.
- Because these redirects are **content**, they are not captured by a
  configuration export. When moving between environments, migrate or export the
  `domain_path_redirect` entities as content rather than relying on `drush
  config:export`.
- Access is controlled entirely by the Redirect module's **Administer redirects**
  permission — there is no per-domain permission, so every editor with that
  permission can manage all domains' redirects.
