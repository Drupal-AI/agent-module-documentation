# Configuration

Sites overrides has a small settings form where you declare which content is
overrideable; the day‑to‑day overriding then happens from within each site's
context.

## Open the settings form

1. Log in as a user with the **`administer site configuration`** permission.
2. Go to **`/admin/config/sites/content-overrides`**.

## Choose what is overrideable

On the settings form you configure **which entity types and bundles** can carry
per‑site overrides. Only the entity types you enable here become overrideable — so
you opt content in deliberately rather than exposing everything.

## Editing overrides

Once entity types are configured, you create and manage overrides from a site's
context rather than from this form:

- **Edit an override** for the currently active site, and **preview** a site's
  overridden content before it goes live.
- **See the override status** of the current page in the Navigation top bar, and
  **trigger override or revert actions** from there. Those action links are
  CSRF‑tokenised.

When an override exists for the active (or preview) site, entity loads — whether
from a route or from code — return the override transparently; otherwise the shared
original is used.

## A note on paragraph access

While you are on a site‑override edit route, the module grants update/delete access
to that page's paragraphs, intentionally bypassing the Content Moderation gate that
would normally block those edits. This bypass is not unconditional: the real
authorization decision is delegated to the Sites module's per‑site content access
check (`$site->contentAccess('update', …)`), so a user still needs the underlying
per‑site permission to edit. Keep your Sites per‑site content access configured
correctly, since that is what governs who can edit overrides.
