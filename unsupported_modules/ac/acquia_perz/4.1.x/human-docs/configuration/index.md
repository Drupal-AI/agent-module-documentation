# Configuration

Acquia Personalization is configured in two places: a **global settings form**
for the connection and mappings, and a **per-bundle opt-in** that lives on each
content type's *Manage display* screen. This page covers both.

## Open the global settings form

1. Log in as a user with the **Administer Acquia Personalization**
   (`administer acquia perz`) permission — an administrator by default.
2. Go to **Configuration → Web services → Acquia Personalization → Settings**, or
   navigate directly to `/admin/config/services/acquia-perz/settings`.

Remember that your Acquia credentials come from the Acquia Connector module, not
from this form — here you tune how the integration behaves.

### API and Site ID

- **API region** — which regional Content Index Engine endpoint to talk to.
  Choose **The Americas**, **Europe**, **Asia-Pacific**, or **Demo**. Pick the
  region closest to where your subscription lives.
- **Site ID** — a unique identifier for this site within the service. It must be
  filled in and may contain only letters, numbers, underscores, and hyphens. If
  you are upgrading a site that previously used the older Acquia Lift module, the
  Site ID is migrated automatically.

### Identity capture

Controls whether the personalization JavaScript identifies a returning visitor
from the URL:

- **Capture identity** — off by default. When enabled, a URL parameter is used
  to identify the visitor to the service.
- **Identity parameter** / **Identity type parameter** — the query-string
  parameter names to read the visitor identity and identity type from.
- **Default identity type** — the identity type assumed when none is supplied;
  the shipped default is `email`.

### Field mappings (segmentation)

Map Drupal fields to the metadata the service uses to segment content:

- **Content section** — the field that provides the content's section.
- **Content keywords** — the field that provides keywords.
- **Persona** — the field that provides persona metadata.

### UDF (User Defined Field) mappings

Map Drupal fields into Acquia's visitor-profile slots. There are three groups —
**person**, **touch**, and **event** — each mapping an id to a value and type.
Person and event allow up to 50 mappings each; touch allows up to 20.

### Visibility (path patterns)

- **Path patterns** — a list of paths, one per line, where the personalization
  JavaScript and context should **not** run. This is an exclusion list: the
  script is attached everywhere except the paths that match. The shipped default
  excludes admin, batch, node-add, node sub-paths, user, and block paths so
  personalization stays off back-end screens.

### Advanced settings

- **Bootstrap mode** — `auto` (default) or `manual`, controlling how the
  personalization library initializes.
- **Content replacement mode** — `trusted` (default) or `customized`.
- **Content origins** — origin site UUIDs, for multi-site content sourcing.
- **Dynamic JavaScript support** — off by default. When on, per-element
  personalization libraries are attached to rendered pages.
- **Override Acquia Lift meta tags** — off by default. Relevant only when
  migrating from the legacy Acquia Lift module.

Click **Save configuration** when done.

## Opt a content type / view mode into personalization

There is no dedicated form for choosing which content is personalized. Instead,
the module adds an **Acquia Personalization** section to every entity's *Manage
display* form.

1. Go to **Structure → Content types → (your type) → Manage display** (or the
   equivalent for taxonomy terms or custom blocks). Pick the view mode tab you
   want, for example *Full content*.
2. Find and expand the **Acquia Personalization** section, then set:

- **Make … available** — the checkbox that opts this bundle and view mode in.
  Ticking it creates the export entry; unticking it removes it.
- **Render role** — the user role the entity is rendered as before export;
  defaults to **anonymous**, which is usually what you want so personalized
  content matches what an anonymous visitor would see.
- **Preview image** — optional. Choose one of the bundle's image fields to use as
  the preview image for this variation. Only shown if the bundle has image
  fields.
- **Personalization Label** — optional. Choose a text field on the bundle to use
  as the label when exporting. Leaving it empty uses `default`.
- **Only export specific entities** — optional. Choose a boolean field that gates
  whether each individual entity is exported. Leaving it disabled always exports.

Only entity types that can be published (nodes, taxonomy terms, custom blocks)
show this section; non-publishable entities show nothing.

Save the *Manage display* form to store your choice. Behind the scenes these
choices live in the `acquia_perz.entity_config` configuration object, but you
never edit that directly.
