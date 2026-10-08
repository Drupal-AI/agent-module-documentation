# Configuration

Analyze needs a little setup before the tab shows anything: you decide which analyzers
run on which content types. There are two admin screens plus per‑bundle settings.

## Open the settings form

1. Log in as a user with the **Administer analyze** permission.
2. Go to **Configuration → Content authoring → Content Analysis**, or navigate directly
   to `/admin/config/content/analyze-settings`.

## Enable analyzers per content type

The settings form lists **every entity type with a canonical URL**, its bundles, and a
checkbox for each analyzer that applies to it. Tick the analyzers you want on each
content type and save. This master on/off matrix is what the Analyze tab reads: an
editor sees an analyzer's data only where you have enabled it here (and where they hold
the *View analyze reports* permission).

## Per‑bundle analyzer settings

Some analyzers carry their own options. For those, an **"Analyze settings" fieldset** is
also injected into each bundle's own edit form (under *Additional settings*) — for
example on a content type's edit page. Open the bundle you want, expand the fieldset, and
set the analyzer's options there. Bundle‑level settings merge over any type‑level
defaults.

## Batch analysis

Enabling an analyzer does not retroactively analyze existing content; the tab computes on
view, but for bulk work use the **Batch Analysis** screen at
`/admin/config/content/analyze-batch` (route `analyze.batch`, also **Administer
analyze**). Pick the analyzers, the entity type/bundle targets, a limit, and whether to
force a refresh, then run it with a progress bar. Only analyzers that support batching
appear here. The same pipeline is available on the command line:

```bash
drush analyze:batch
```

Use `drush analyze:batch --status` to check coverage per bundle, and `--limit` / `--force`
to re‑analyze the first N entities. The batch runner backs off automatically when an AI
analyzer hits a rate limit.

## Permissions

Analyze defines two permissions, both restricted:

- **Administer analyze** — access the settings and batch forms, and the "Analyze
  settings" fieldset on bundle edit forms.
- **View analyze reports** — required to view any Analyze tab or report. Access is granted
  only when the user has this permission **and** the entity's type/bundle (and, for a
  specific report, that plugin) is enabled in the settings above.

## AI coding‑assistant skills (optional)

If you use an AI coding assistant, `drush analyze:setup-ai` installs Agent Skills files
that teach it to run content analysis through natural language ("run sentiment analysis on
all articles", "check all pages for broken links", and so on).
