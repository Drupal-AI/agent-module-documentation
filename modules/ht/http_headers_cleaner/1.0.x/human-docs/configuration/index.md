# Configuration

HTTP-Headers cleaner is configured from one settings form with two parts: a list of
**HTTP headers** to remove and a list of **meta tags** to remove. Both are expressed
as YAML.

## Open the settings form

1. Log in as a user with permission to use the administration pages.
2. Go to **Configuration → System → HTTP-Headers cleaner settings**.

Installing the recommended [YAML Editor](https://www.drupal.org/project/yaml_editor)
module makes editing these YAML blocks far easier.

## Removing HTTP headers

Enable the **HTTP-headers** section and define an associative array of
`{header-id: [pattern1, pattern2]}`:

- If you give a header **no pattern** (set it to `null`), the whole header is
  removed.
- If you give **patterns**, only the matching elements within that header are
  removed.

```yaml
x-drupal-dynamic-cache: null
x-drupal-cache-tags: null
x-drupal-cache-contexts: null
x-drupal-cache-max-age: null
x-generator: null
x-drupal-cache: null
link:
  - '/rel="revision"/'
  - '/rel="shortlink"/'
  - '/rel="delete-form"/'
  - '/rel="delete-multiple-form"/'
  - '/rel="edit-form"/'
  - '/rel="version-history"/'
  - '/rel="drupal:content-translation-overview"/'
  - '/rel="drupal:content-translation-add"/'
  - '/rel="drupal:content-translation-edit"/'
  - '/rel="drupal:content-translation-delete"/'
```

Here the various `x-…` headers are removed entirely (`null`), while the `Link`
header keeps its useful values and only its listed relations are stripped.

## Removing meta tags

Enable the **Meta tags** section and define an associative array of
`{tag: [ {attribute: [pattern1, pattern2]} ]}` — a tag name, the attribute to match
on, and the patterns identifying which tags to remove:

```yaml
meta:
  name:
    - /Generator/
link:
  rel:
    - /delete-form/
    - /shortlink/
    - /revision/
    - /delete-multiple-form/
    - /edit-form/
    - /version-history/
    - '/drupal:content-translation-overview/'
    - '/drupal:content-translation-add/'
    - '/drupal:content-translation-edit/'
    - '/drupal:content-translation-delete/'
```

This removes the generator `<meta name="Generator" …>` tag and the listed
`<link rel="…">` tags from the page HTML.

## Only strip informational elements

Target **informational** headers and tags — version/generator signals, cache
diagnostics, admin-only `Link`/`rel` entries. Do **not** remove genuine security
headers (such as CSP or X-Frame-Options): stripping those would weaken your site.
This module reduces disclosure; it does not add protections, so pair it with a
header-adding module if you need those.

## Save

Click **Save** to apply your rules. Load a page afterward and confirm in your
browser's developer tools (Network tab → Response Headers) that the targeted headers
are gone; clear caches if a change does not appear immediately.
