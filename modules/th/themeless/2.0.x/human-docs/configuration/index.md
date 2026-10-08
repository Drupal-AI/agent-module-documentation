# Configuration

Themeless is configured in two places: the standard Drupal admin UI (for
permissions and which fields appear), and a YAML settings file (for CORS, the
domain whitelist, and access tokens). There is no dedicated settings form — the
module deliberately keeps its options in configuration-as-code so they travel with
your version control and stay consistent across environments.

## 1. Grant the access permission

Go to **People → Permissions** (`/admin/people/permissions`) and grant **Access
Themeless API** to the roles that should be allowed to read the endpoints. Think
carefully about anonymous access here: if you grant it to the anonymous role the
endpoints are effectively public, so only do that if the exposed content is meant
to be public.

## 2. Turn on the "Themeless" display for each entity type

For every content type you want to expose:

1. Go to **Structure → Content types → (your type) → Manage display**
   (`/admin/structure/types/manage/[type]/display`).
2. Enable the **Themeless** display (custom view mode).
3. Open that display (`/admin/structure/types/manage/[type]/display/themeless`)
   and choose which fields and formatters to include. Only the fields you enable
   here appear in the API output — this is your main lever for controlling what
   gets published.

Only entity types and bundles you enable a Themeless display for are meaningfully
exposed, so leave off anything that should stay private, and keep unpublished or
access-controlled content out of what you expose.

## 3. Module settings (YAML)

CORS, the referrer/domain whitelist, access tokens, and referrer-checking options
live in the module's YAML configuration (`config/install/themeless.settings.yml`),
edited and deployed like any other Drupal configuration:

- **CORS configuration** — the origins and HTTP methods allowed to call the API
  cross-origin. Set this to the specific sites that will embed your content rather
  than leaving it wide open.
- **Domain whitelist** — restrict API access by referrer domain, so only the
  sites you name can pull content.
- **Access tokens** — token-based access for iframe embedding, so an embed can be
  tied to a secret you control.
- **Security settings** — referrer checking and related validation options.

After editing, deploy the change the usual way (for example
`drush config:export` / `drush config:import` as part of your workflow).

## A note on exposure

These endpoints return entity content directly, so the safest posture is to expose
the minimum: enable the Themeless display only on the types you mean to publish,
include only the fields you want in the output, keep the access permission off the
anonymous role unless the content is genuinely public, and use the CORS/whitelist/
token options to limit which sites can embed. That keeps unpublished or
access-controlled content from leaking.
