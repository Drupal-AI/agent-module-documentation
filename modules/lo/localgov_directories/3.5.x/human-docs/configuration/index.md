# Configuration

Setting up a directory is a five-step process: create facets, create a channel,
add entries, index them, and place the blocks. This mirrors the flow in the
sibling agent docs but written for someone clicking through the admin UI.

## Step 1 — Create facet types and values

Facets are the filters visitors use down the side of a directory. There are two
layers:

- **Facet types** are configuration — the *kinds* of filter, like "Size" or
  "Service area". Create them at **Configuration → Directory Facets types**
  (`entity.localgov_directories_facets_type.collection`). You need the
  **Administer directory facets types** permission, which is a site-builder
  permission.
- **Facet values** are content — the individual options like "Large" and
  "Small". Editors add these at **Content → Directories → Facets**
  (`/admin/content/directories/facets`, then *Add* for the relevant type). They
  are deliberately **excluded from configuration export**, so editors can manage
  them in production without a deployment.

When you add a facet type, the module automatically makes it available on
channels and adds its values to the facet block — you don't have to wire that up
by hand.

## Step 2 — Create a channel

A channel is a `localgov_directory` node. Create one under **Content → Add
content → Directory** and fill in two directory-specific fields:

- **Directory channel types** (`localgov_directory_channel_types`) — which entry
  bundles are allowed to be posted into this channel.
- **Enabled facets** (`localgov_directory_facets_enable`) — which facet types
  are active on this channel.

Visiting the channel node renders the shipped `localgov_directory_channel` view,
which lists the entries and (when location is enabled) shows the map.

## Step 3 — Create entries

An entry is any node whose bundle carries the `localgov_directory_channels`
reference field. The entry submodules (page, venue, organisation, promo page)
ship ready-made bundles. On each entry you:

- Assign it to one or more **channels** via the *Directory channels* field.
- Pick its **facet values** in the *Facets* field
  (`localgov_directory_facets_select`). The module maintains a hidden indexed
  field (`localgov_directory_facets_filter`) from your selection — that is what
  the facets actually filter on.

To turn an **existing content type** into an entry type, add the
`localgov_directory_channels` field to it and then add that bundle to a channel's
allowed types.

## Step 4 — Build the index

Directory entries only appear once they are indexed in Search API:

```bash
drush search-api:status
drush search-api:index localgov_directories_index_default
drush search-api:list   # confirm which server the index is attached to
```

Then load the channel node — the entries should appear, with facet blocks in the
sidebar. If you set facet values on entries *after* they were first indexed,
reindex so the filters pick them up.

## Step 5 — Place the blocks

On the LocalGov Base theme and the demo theme, the blocks are placed for you. On
a **custom theme** you add them yourself at **Structure → Block layout** and set
their visibility to the `localgov_directory` bundle:

| Block | Purpose |
|-------|---------|
| **Channel search** (`localgov_directories_channel_search_block`) | Keyword search within the current channel. Requires a node context. |
| **Directory facets** (`localgov_directories_facets`) | The facet filter block for the sidebar. |
| **Proximity search** (`localgov_directories_facets_proximity_search`) | The "near me" proximity filters (needs the location submodule). |

## Optional integrations

- **Location / proximity search** — enable `localgov_directories_location` to add
  the map, the `localgov_location` field, and the proximity display.
- **Pathauto** — a URL pattern for channels ships in the module's optional
  config and is applied automatically.
- **Autocomplete** — the channel search box supports Search API Autocomplete out
  of the box.
- **Open Referral** — the experimental `localgov_directories_or` submodules
  publish venue data in Open Referral format.

## Permissions

Under **People → Permissions**:

| Permission | What it allows |
|------------|----------------|
| **Administer directory facets types** | Manage facet *types* (configuration). This is the facets entity's admin permission, so it also implies full control of facet values — keep it to site builders. Marked as a restricted permission. |
| **Access directory facets overview** | See the facet listing at `/admin/content/directories/facets`. |
| **Create / Edit / Delete / View directory facets** | The ordinary editorial permissions for managing facet *values*. |

On a LocalGov Drupal site the editor role is granted the facet-value permissions
and the directory node permissions automatically. On a plain Drupal site nothing
is granted for you — assign the permissions to your content-editor role
yourself, for example:

```bash
drush role:perm:add content_editor 'access directory facets overview'
drush role:perm:add content_editor 'create directory facets'
drush role:perm:add content_editor 'edit directory facets'
drush role:perm:add content_editor 'view directory facets'
```

## Troubleshooting

| Symptom | Likely cause |
|---------|--------------|
| Channel page is empty | The index hasn't been built, or no search-backend submodule is enabled. |
| Facets block shows nothing | The facet type isn't enabled on that channel, or no entries carry values. |
| Facets appear but filter nothing | Entries were indexed before their facet values were set — reindex. |
| Proximity search is missing | `localgov_directories_location` isn't enabled. |
| An entry type isn't selectable on a channel | That bundle lacks the `localgov_directory_channels` field. |
