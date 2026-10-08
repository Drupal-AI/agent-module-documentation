# Configuration

Admin Theme is configured with two fields on the standard Appearance page. There
is no dedicated settings page — the fields are injected into the core theme
administration form.

## Open the settings

1. Log in as a user who can administer themes/appearance (an administrator by
   default).
2. Go to **Appearance** (`/admin/appearance`). Two extra sections, **Include** and
   **Exclude**, appear on the page.

## Include and Exclude

- **Include** — a list of path patterns where the admin theme **should** be used,
  one per line.
- **Exclude** — a list of path patterns where the admin theme should **not** be
  used, one per line. Exclude wins over Include, so you can include a whole
  section and carve out exceptions.

Both fields use the same path syntax as block "Pages" visibility:

- One path per line, each starting with a leading slash — for example
  `/company-dashboard`.
- `*` acts as a wildcard — `/company-dashboard/*` matches all sub-pages,
  `/team/*/manage` matches any team's manage page.
- `<front>` matches the site's front page.

A page is rendered with the admin theme when its path matches the **Include** list
**and** does not match the **Exclude** list.

### Examples

Apply the admin theme to a dashboard and everything beneath it:

```
/company-dashboard
/company-dashboard/*
```

Include a section but keep one child on the public theme by adding it to Exclude:

```
Include:
/reports
/reports/*

Exclude:
/reports/public-preview
```

## Save and clear caches

Click **Save configuration** at the bottom of the Appearance page. Because the
switch hooks into Drupal's route/theme determination, a change may need a cache or
router rebuild to fully take effect — run `drush cr` (or **Configuration →
Development → Performance → Clear all caches**) if a path doesn't switch
immediately.

## A note on the default value

When first enabled, both lists contain a placeholder path
(`/dummy-path-needed-until-core-issue-2930364-is-fixed`) that intentionally
matches nothing — a workaround for a known core condition-configuration bug.
Replace it with your real paths; leaving a list at that placeholder effectively
means "match nothing" for that list.

## Setting it from Drush

The values are stored in the `admin_theme.settings` config object under the keys
`paths` (Include) and `exclude_paths` (Exclude), each a single string with one
path per line:

```bash
drush config:get admin_theme.settings

drush config:set admin_theme.settings paths "/company-dashboard
/company-dashboard/*" -y

drush config:set admin_theme.settings exclude_paths "/node/add/landing_page" -y
```

Follow a config change with `drush cr` so the router picks it up.
