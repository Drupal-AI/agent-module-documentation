# Configuration

Content Templates has no settings form. "Configuring" it means setting up
permissions, organizing your template categories, and creating the templates
themselves.

## Grant permissions

Go to **People → Permissions** (`/admin/people/permissions`) and grant the
Content Templates permissions to the appropriate roles. There are two clearly
separate roles: people who *build* templates, and people who *create content
from* them.

| Permission | What it lets a user do |
|---|---|
| **Add content template entities** | Create templates. Also required (together with Quick Node Clone's per-type *Clone {type} content*) to reach `/node/{node}/template`. |
| **Edit content template entities** | Edit existing templates. |
| **Delete content template entities** | Delete templates. |
| **View published content template entities** | See published templates. |
| **View unpublished content template entities** | Preview draft/unpublished templates (useful for reviewers). |
| **Create content from template** | Reach the `/node/template` gallery and create new content from a template. |
| **Access content from template overview** | Reach `/node/{node}/overview`, the list of content created from a template. |
| **Administer content template entities** | Full admin of the entity type. This is the only one flagged *restrict access* — treat it as trusted-admin. |

Two things worth knowing:

- Creating a template from a node needs **both** *Add content template entities*
  **and** Quick Node Clone's core *Clone {type} content* permission for that
  content type.
- The actual clone respects normal node access (core's `node.clone` access
  check), so the module never lets someone clone content they couldn't otherwise
  access.

## Organize template categories (optional)

The module creates a **template_category** taxonomy vocabulary. Add terms to it at
**Structure → Taxonomy → Template category** to group your templates — for example
"Landing pages", "Campaigns", or "News". In the *Create from template* gallery,
templates are grouped and weighted by these categories, so a little curation here
makes the gallery much easier to scan.

## Create a template from a node

1. Build and save a node you want to reuse as a starting point.
2. Visit `/node/{node}/template` (replace `{node}` with the node's id). This opens
   the template add/edit form for that node.
3. Fill in the template:
   - **Source** (`field_source`) — the node this template is built from (already
     linked to the node you came from).
   - **Category** (`field_category`) — optional, pick a template_category term.
   - **Image** (`field_image`) — optional thumbnail shown on the gallery card.
4. Save. The template now appears in the gallery for anyone with *Create content
   from template*.

## Create content from a template

1. Editors open **Create from template** — the gallery at `/node/template`, also
   linked as an action from **Content** (`/admin/content`).
2. They pick a template card. Only templates whose source node they are allowed to
   clone are shown.
3. The module clones the source node (via Quick Node Clone) into a new draft,
   keeping the original title (no "Clone of" prefix), and records the originating
   template on the new node.

## See what came from a template

Visit `/node/{node}/overview` for a source node to list every node created from
its template (with title, author, created date, and edit/view links). The admin
**Content** view also gains a "Content Template" column and exposed filter so you
can audit template usage across the site, and a node's edit form shows a
"Created from" link back to its template in the sidebar.

## Housekeeping

Deleting a source node automatically deletes its template, so you won't be left
with templates pointing at content that no longer exists.
