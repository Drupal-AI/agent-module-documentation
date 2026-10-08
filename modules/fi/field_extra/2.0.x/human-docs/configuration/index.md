# Configuration

Turning a field into a private field takes three steps: enable the entity type,
mark the field as private‑capable, and then let the author choose per value.
Below is each step, plus the permissions that govern who can do what.

## Step 1 — Choose which entity types participate

1. Log in as a user with the **Manage private field settings** permission (`field
   extra manage private field settings`).
2. Go to **Configuration → Content authoring → Private settings**
   (`/admin/config/content/private-settings`).
3. The form lists every entity type on your site that is both fieldable and has an
   owner. Tick the ones that should support private fields — for example
   **Content** (nodes) — and **Save**.

Only entity types you enable here will offer the private‑field options in the next
steps.

## Step 2 — Mark a field as private‑capable

1. Go to the field's configuration edit form through Field UI — for a node field,
   **Structure → Content types → *(type)* → Manage fields → *(field)* → Edit**.
2. On enabled entity types you will now see a checkbox: **Allow the author to
   hide this field's value by making it private.** Tick it to make this field
   eligible.
3. Optionally tick **Enable the private field by default** so new content starts
   with the field marked private (the author can still change it).
4. Save the field settings.

These choices are stored as third‑party settings on the field, so they travel
with your configuration.

## Step 3 — Let the author mark a value private

On the entity's add/edit form, any user who is the entity's **owner** — or who has
the **Access private fields** permission (or a per‑entity‑type variant) — sees a
**Private** checkbox next to each private‑capable field. Ticking it marks that
particular value private. The author's own content is always theirs to mark and
to view.

## How the hiding is enforced

When a value is marked private, Field extra forbids the *view* operation for any
viewer who is neither the owner nor holds a bypass permission. The value is
therefore removed from rendered output and from field‑access‑aware API responses —
it is genuinely withheld server‑side, not merely hidden in the form. Field extra
also adds a `private-field` CSS class to private fields so you can style them for
the owner's own view.

## Permissions

Field extra defines its permissions at **People → Permissions**, filtered to this
module at `/admin/people/permissions/module/field_extra`:

- **Manage private field settings** (`field extra manage private field settings`)
  — who can open the *Private settings* form and choose participating entity
  types.
- **Access private fields** (`field extra access private fields`) — who can *view*
  other users' private field values (a bypass of the hiding), and mark fields
  private on the edit form. Per‑entity‑type variants
  (`field extra access <entity_type> private fields`) let you grant this for a
  single entity type rather than globally.

Note that an author always has full access to mark and view their own content's
private fields by default; these permissions are about granting other roles
access. Grant the bypass permission only to trusted roles.

## The private fields listing

A read‑only listing at `/admin/config/content/private-settings/fields` enumerates
every field you have configured as private‑capable across your site, so you can
review at a glance which fields expose the private option.
