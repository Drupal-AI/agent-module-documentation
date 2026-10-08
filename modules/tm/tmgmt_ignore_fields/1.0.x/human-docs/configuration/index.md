# Configuration

All of this module's behaviour is driven from a single settings form.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to **Configuration → Content authoring → TMGMT Ignore Fields**, or navigate
   directly to `/admin/config/content/tmgmt-ignore-fields`.

## Choose the fields to ignore

The form presents the fields on your site and lets you mark the ones that should
be **skipped during translation**. Tick a field to have TMGMT leave it out of
every job it builds from that point on. You can:

- **Exclude base fields and custom fields** from any content type.
- **Ignore referenced entities** such as paragraphs, so their fields are not
  dragged into the job either.
- Build up a **global list** of fields that will always be ignored — the exclusion
  applies across the site, not per job.

Save the form when you are done. The next job TMGMT assembles will contain only
the fields you left un‑ignored.

## Verify nothing translatable was excluded

Because an ignored field is **silently absent** from jobs, an over‑broad choice
does not raise an error — it just quietly stops that field from ever being
translated, which surfaces later as a missing translation. After changing the
ignore list, create or preview a translation job and confirm that everything you
genuinely want translated is still present. If a translation turns up missing,
revisit this form and check whether the field was excluded here.
