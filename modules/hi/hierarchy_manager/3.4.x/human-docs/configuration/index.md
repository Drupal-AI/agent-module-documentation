# Configuration

Getting Hierarchy Manager working is a two‑step process: first create a **display
profile** (how the tree looks and behaves), then enable a **setup plugin** and
bind it to that profile and to the specific vocabularies or menus you want to
manage.

Both steps require the core **Administer site configuration** permission.

## Step 1 — Create a display profile

1. Go to **Structure → HM Display Profile**
   (`/admin/structure/hm_display_profile`) and click **Add**.
2. Fill in the fields:
   - **Label** and machine name — a friendly name for this preset (e.g. "Default
     tree").
   - **Plugin** — the display plugin that renders the tree. The module ships
     `hm_display_jstree` (jsTree), which is what you'll normally pick.
   - **Config** — a JSON string of options passed to the display plugin. For
     jsTree this is a jsTree configuration object; for example you can set the
     theme via `theme.name` (defaults to `default`). Leave it empty to accept the
     defaults.
   - **Confirm** — when enabled, the user must confirm a drag change before it's
     saved. Turn this on if you want a safety prompt before every reorder or
     re‑parent.
3. Save the profile.

You can create several profiles and reuse the same one across multiple
vocabularies for a consistent experience.

## Step 2 — Enable and bind a setup plugin

1. Go to **Configuration → User interface → Hierarchy Manager**
   (`/admin/config/user-interface/hierarchy_manager/config`).
2. Under **Allowed setup plugins**, enable the ones you want:
   - **Taxonomy** (`hm_setup_taxonomy`) — takes over the taxonomy term overview.
   - **Menu** (`hm_setup_menu`) — takes over the menu edit form.
3. For each enabled plugin, choose:
   - **Display profile** — the profile you created in Step 1.
   - **Bundles** — tick the specific vocabularies (for taxonomy) or menus (for
     menu) that should use the tree. Only the ones you tick are affected;
     everything else keeps core's default UI.
4. Save the form.

Once a setup plugin is enabled and bound, its target form is replaced by the
interactive tree. For taxonomy, that's the term overview at
`/admin/structure/taxonomy/manage/<vid>/overview`; for menus, it's the menu edit
form. The individual term and menu‑link **edit** forms are left unchanged — only
the overview/ordering UI is swapped.

## How access works

The tree loads and saves through JSON endpoints, and access is enforced on every
request — the tree never bypasses Drupal permissions:

- **Taxonomy** endpoints allow a user who has either `administer taxonomy` or
  `edit terms in <vid>` for that vocabulary. Each request also carries a CSRF
  token tied to the vocabulary, and every individual term is additionally checked
  against its own update access before it's returned or saved.
- **Menu** endpoints require the core `administer menu` permission.

## Notes

- **Multiple parents:** a term that has more than one parent is shown under each
  of its parents and is non‑draggable, to avoid ambiguity about which
  relationship you'd be changing.
- **Translations:** term labels are pulled in the current content language, so the
  tree respects your site's language settings.
- **Extending it:** developers can add hierarchy management for other entity types
  or swap in a non‑jsTree rendering library via the two plugin types — see the
  sibling [`agent/`](../../agent/plugins/plugins.md) docs.
