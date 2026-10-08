# Configuration

Automatic Alternative Text needs a vision provider and its credentials before it
can do anything. Configure it at **Configuration → Media → Automatic Alternative
Text** (`/admin/config/media/auto_alter`), behind the
`administer Automatic Alternative Text` permission.

## Choose a provider

The settings form lets you pick which vision service describes your images:

- **Microsoft Cognitive Services Computer Vision** (Azure)
- **Alttext.ai**

Providers are pluggable, so the list may grow, but these two are supported out
of the box. It is worth comparing their output on your own images — the two
services phrase descriptions differently.

## Supply credentials safely

Each provider needs an API key. **Treat the key as a secret:**

- Store it in an **environment variable** (or a **Key** entity that reads from
  one), following this project's convention — never paste it into configuration
  that gets exported and committed to version control.
- With DDEV, set the variable with `ddev dotenv set .ddev/.env
  --your-api-key=<value>` and `ddev restart`, keeping `.ddev/.env` out of version
  control. Reference it from a Key entity where the module supports one.

The module's credentials layer is what reads these values at run time; your job
is to make sure the raw key lives in the environment, not in committed config.

## Control who can generate (and spend)

Generation is **billed per image**, so the `administer Automatic Alternative
Text` permission is effectively a spending control. Grant it only to roles you
are happy to have trigger paid API calls. Set it at **People → Permissions**
(`/admin/people/permissions`).

## Data-flow and quality reminders

- **Each image is sent to a third-party service.** For sensitive, embargoed, or
  unpublished imagery, decide whether that is acceptable before enabling
  generation.
- **Generated alt text is a first draft, not a final answer.** It describes what
  is *in* the image, not *why* it is on the page. Keep editors in the loop, and
  give decorative images empty alt rather than an auto-generated description.
- If you enabled the **`auto_alter_translate`** submodule, generated descriptions
  can be extended into your site's other languages.
