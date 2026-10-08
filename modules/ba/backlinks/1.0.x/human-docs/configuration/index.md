# Configuration

Backlinks needs a little setup before it does anything: you add two fields to
your content types, tell the module which fields to scan for links, and then run
a one-time rebuild so existing content is indexed. After that, the fields are
kept in sync automatically every time a node is saved.

## 1. Add the fields to your content types

On each content type where you want to track incoming links, add:

- **`linked_node`** — an *entity reference* field targeting nodes. This is where
  the module records the node ids that the content links to.
- **`linked_url`** — a field that captures the raw href URLs it found.

Add these under **Structure → Content types → (your type) → Manage fields** the
same way you would add any field.

## 2. Choose which fields are scanned

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → Backlinks**, or navigate directly
   to `/admin/config/content/backlinks`.
3. Pick which fields the module should scan for links (for example the body
   field). When a node is saved, only these fields are rendered and searched for
   `<a href>` links.
4. Save.

The module resolves each link it finds: it keeps only links that point at other
nodes' canonical URLs, and it ignores `mailto:`, `file:`, `javascript:` and
`onenote:` links. Internal hosts are recognised using your site's
`trusted_host_patterns` setting from `settings.php`, so make sure that is
configured correctly if your site is reached on more than one hostname.

## 3. Rebuild backlinks for existing content

New and edited nodes are indexed automatically on save, but content that already
existed when you installed the module has not been scanned yet. Run the bulk
rebuild once:

1. Go to `/admin/config/content/backlinks/update`.
2. Start the rebuild. It walks your existing nodes, extracts their links, and
   populates the `linked_node` / `linked_url` fields.

## Displaying the backlinks

With the fields populated, you can surface the incoming links however you like —
by placing the `linked_node` field in a view mode under **Manage display**, or,
if Views is enabled, by using the provided **Linked Content** view, which uses
the `linked_node` relationship to list the nodes that link to the current one.
