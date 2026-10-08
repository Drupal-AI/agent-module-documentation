# Configure robots.txt

**UI:** Admin → Configuration → Search and metadata → RobotsTxt
(`/admin/config/search/robotstxt`, route `robotstxt.admin_settings_form`,
permission `administer robots.txt`). One textarea holds the whole file body.

**Config:** stored in `robotstxt.settings`:
```yaml
content: |
  User-agent: *
  Disallow: /admin/
  Sitemap: https://example.com/sitemap.xml
```
Edit with `drush config:set robotstxt.settings content '...'` or via
`config:import`. Saving invalidates the `robotstxt` cache tag.

**Serving route:** `robotstxt.content` maps `/robots.txt` to
`RobotsTxtController::content`, returning a cacheable `text/plain` response
built from `content` plus any `hook_robotstxt()` additions.

## Required gotcha
Drupal ships a static `robots.txt` in the docroot. Web servers serve that file
before Drupal's route ever runs, so **you must delete or rename the physical
`robots.txt`** in the site root for this module to take effect. (Re-check after
core updates, which may restore it.)
