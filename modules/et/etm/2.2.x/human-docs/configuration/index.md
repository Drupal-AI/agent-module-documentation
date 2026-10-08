# Configuration

Enhanced Taxonomy Manager works as soon as it is enabled — the settings form is for
tuning, and the more important setup decision for most sites is **who can manage
which vocabularies**, handled through permissions.

## Open the settings form

1. Log in as a user with **Administer site configuration** / **Administer
   taxonomy**.
2. Go to **Configuration → Content authoring → Enhanced Taxonomy Manager**, or
   navigate directly to `/admin/config/content/enhanced-taxonomy-manager`.

Here you can adjust the module's behaviour (for example how the tree loads and
paginates). The defaults are sensible, so you can leave this form alone on most
sites and come back to it only if you want to tune the experience.

## Permissions — delegating taxonomy management

ETM's access model is one of its strengths: you can hand a single vocabulary to an
editor without granting the site‑wide **Administer taxonomy** permission. Under
**People → Permissions**, look for the permissions provided by Enhanced Taxonomy
Manager:

- **Administer taxonomy** (core) — grants full access to every vocabulary's tree and
  all operations. Reserve for administrators.
- **Manage terms in *(vocabulary)*** — per‑vocabulary; lets a role use the tree and
  term operations for that one vocabulary only.
- **Export terms in *(vocabulary)*** — per‑vocabulary; controls CSV export
  separately from editing.
- **Import terms in *(vocabulary)*** — per‑vocabulary; controls bulk import
  separately from editing.

Term deletion additionally defers to core's taxonomy‑term delete access, so a user
still needs the normal permission to delete terms.

Grant the per‑vocabulary permissions to the roles that should manage each
vocabulary, then click **Save permissions**.

## Save

If you changed anything on the settings form, click **Save configuration**. Changes
take effect immediately — reopen a vocabulary's tree to see them.
