# Configuration

Acquia CMS Site Studio installs the glue, but Site Studio itself needs two things
before the page builder works: your **API key** (to activate the product) and an
**import** of its packages (to load the styles, elements, and templates). Both
happen in the **Site Studio** admin section.

## Before you start

- You need a valid **Acquia Site Studio** subscription and its **API key** and
  **organization/agency key** (from your Acquia account).
- Treat those keys as **secrets** — never hard-code or commit them. Store the
  values in environment variables (and reference them through a **Key** entity or
  `getenv()` in settings where supported) rather than pasting them into config
  that gets exported.

## 1. Enter the Site Studio account keys

- Go to the **Site Studio** account settings (under the Site Studio admin
  section).
- Enter the **API key** and **agency/organization key**. Save; Site Studio will
  validate them against the platform.
- If validation fails, the keys are wrong or the subscription is inactive — the
  builder will not function until this succeeds.

## 2. Import the Site Studio packages

Once the keys validate, Site Studio needs its configuration imported so the base
styles, elements, and templates exist.

- Run the Site Studio **rebuild/import** — either from the Site Studio UI or with
  the Cohesion Drush commands (commonly `drush cohesion:import` followed by
  `drush cohesion:rebuild`; check `drush list` for the exact commands on your
  version).
- This step can take a while; let it finish before using the builder.

## 3. Build pages

With the keys in place and packages imported, editors can use the **page builder**
on content, composing pages from Site Studio components and styled elements. Site
builders manage the component library, custom styles, and templates through the
Site Studio admin section.

## Verify it works

Open the Site Studio admin section and confirm the account shows as connected and
the styles/elements are present. Then edit a piece of content and confirm the page
builder canvas loads. If it doesn't, re-check the API keys (step 1) and that the
import/rebuild completed without errors (step 2).
