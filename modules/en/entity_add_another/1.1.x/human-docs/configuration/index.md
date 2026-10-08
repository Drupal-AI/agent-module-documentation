# Configuration

Entity Add Another needs one quick setup step before the button appears: you tell
it which entity types and bundles should carry a "Save and Add Another" button on
their creation forms.

## Choose where the button appears

1. Log in as a user with permission to administer the module's settings (an
   administrator by default).
2. Go to **Configuration → Content authoring → Entity Add Another**, or navigate
   directly to `/admin/config/content/entity_add_another`.
3. On the settings form, tick the entity types and bundles you want. Each content
   entity type is listed, along with an entry per bundle (for example *Content of
   type Article*), so you can enable a whole type or just specific bundles.
4. Save the form.

From then on, whenever an editor creates a new entity of an enabled type, the
creation form shows a **Save and Add Another** button next to the standard Save
button. Clicking it saves the entity and reopens a fresh, empty add form for the
same type.

## Permissions

The module defines two permissions, set at **People → Permissions**
(`/admin/people/permissions`):

- **Administer Entity Add Another** — who can reach the configuration form above and
  decide where the button appears.
- **Use Entity Add another** — which roles actually see and can use the "Save and
  Add Another" button on the enabled forms.

Grant the "use" permission to your content editors, and keep the "administer"
permission limited to site administrators. Remember that the button never lets a
user create anything they could not already create — normal *create* access for
each entity type still applies, and the button only appears on add forms the editor
can already reach.
