# Configure the HOME link (`<front>`) redirect

Separate from the per-role override, the module can repoint the site's `<front>` HOME links to another
local path without redirecting front-page requests. Form
`Drupal\front_page\Form\FrontPageHomeLinksForm` (form id `front_page_admin_home_links`) at route
`front_page.home_links` → `/admin/config/system/front/home-links`. Requires permission
`administer front page`.

## Field → config key

| Form field | Config key | Type | Notes |
|---|---|---|---|
| Redirect your site HOME links to | `home_link_path` | path | Local path such as `/node/12`. Leave blank to disable. Validated: must start with `/` and pass `path.validator`->`isValid()`. Stored on the shared `front_page.settings` object. |

### Set it with Drush / PHP

```php
\Drupal::configFactory()->getEditable('front_page.settings')
  ->set('home_link_path', '/node/12')
  ->save();
```

## What happens at runtime

`Drupal\front_page\FrontPagePathProcessor::processOutbound()` (service
`front_page.front_page_path_processor`, tagged `path_processor_outbound`) rewrites outbound URLs when
they are generated:

- `/<front>` or an empty path is replaced with `/` + `home_link_path` (only when `home_link_path` is
  non-empty).
- As a special case, the path `/main` is rewritten to empty (which then also picks up the
  `home_link_path` substitution).

So links that point at the standard front page (`Url::fromRoute('<front>')`, HOME menu links, etc.)
render as `home_link_path` instead. Because this is an outbound path processor it changes only how links
are built; it does not itself redirect the browser. Per the module help text: "If a HOME link is set,
the `<front>` placeholder will be replaced with this value instead of the standard front page."

## Config schema

`home_link_path` (type `path`) is part of the `front_page.settings` config object declared in
`config/schema/front_page.schema.yml`. See [settings.md](settings.md) for the full schema.
