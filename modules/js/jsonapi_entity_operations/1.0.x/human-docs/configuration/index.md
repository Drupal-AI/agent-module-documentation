# Configuration

There are two things to set up: who may see the link, and which entity types show
it.

## Step 1 — Grant the permissions

Go to **People → Permissions** (`/admin/people/permissions`) and, under this
module's section, grant:

- **View JSON:API entity operation link** (`view jsonapi_entity_operations`) — to
  the roles that should see the "See JSON:API resource" link in operations
  dropbuttons. Without this permission a user sees no link.
- **Administer JSON:API Entity Operations configuration**
  (`administer jsonapi_entity_operations configuration`) — a restricted permission
  for the site administrators who should be able to change the settings below.

Grant the viewing permission to the roles doing decoupled development or QA — for
example a developer or reviewer role — rather than to everyone.

## Step 2 — Choose which entity types show the link

Go to **Configuration → Web services → JSON:API → Entity Operation Settings**
(`/admin/config/services/jsonapi/entity_operations/settings`) and select which
**entity types** should display the link. The default install lists **node**
(content), so the link appears on content listings out of the box; enable others
if you want the link on their admin listings too.

Save the form. On the chosen entity types' admin listings, the operations
dropbutton now includes **See JSON:API resource**, which opens the entity's
JSON:API individual resource in a new browser tab.

## What this does and does not change

This feature is purely a navigation aid. It adds a link to the JSON:API resource
that already exists — it does **not** create any JSON:API write route, and it does
**not** alter who may read or write that resource. All resource access is still
enforced by core JSON:API and Drupal's entity access. If you actually want to allow
JSON:API writes, you configure that in core JSON:API (read-only vs read-write)
together with the relevant entity permissions — separately from this module.
