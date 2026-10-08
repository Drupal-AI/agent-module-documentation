# Configuration

Preview does nothing until you tell it which content should get a Preview button. That is
the whole job of the settings form: pick the entity types and bundles you want to enable, and
choose the default view mode used when previewing each.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an administrator
   by default).
2. Go to **Configuration → Content → Entity preview**, or navigate directly to
   `/admin/config/content/preview`.

## Enable preview per entity type and bundle

The form lists your content entity types and their bundles. For each bundle you want to
support:

- **Tick the bundle** to add a **Preview** button to its edit form.
- **Choose the default view mode** — this is the display the preview page opens in first (for
  example *Full content* or *Teaser*). Editors can still switch to any other view mode once
  they are on the preview page.

Save the form. Behind the scenes this stores your choices in the `preview.settings` config
object as `enabled[<entity_type>][<bundle>] = <default_view_mode>`, so the settings travel
with a normal configuration export.

## What editors see once it is enabled

- Editing an enabled entity now shows a **Preview** button next to **Save**.
- Clicking **Preview** stashes the in-progress form in the private per-user tempstore and
  redirects to the preview page (`/preview/{uuid}/{view_mode}`), which renders the *unsaved*
  entity.
- On the preview page a small form lets the editor **switch view modes**, and a **"Back to
  content editing"** link returns them to the edit form with their work intact.
- **Saving** the entity clears its preview from the tempstore automatically.

## Notes

- Preview reuses each entity's existing access rules — a bundle appears in an editor's Preview
  button only if they can create or update that content. You do not grant any extra
  permission to use it.
- Previews are rendered uncached, so what you see always reflects the current draft.
- Other modules can change where the "Back to content editing" link points by subscribing to
  the `preview.back_link` event — see the [`agent/`](../../agent/start.md) docs for the API
  details.
