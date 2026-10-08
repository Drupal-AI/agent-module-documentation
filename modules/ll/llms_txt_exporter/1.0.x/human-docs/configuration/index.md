# Configuration

LLMs txt Exporter has a single settings form that controls what goes into the
generated `/llms.txt` file.

## Open the settings

1. Log in as an administrator.
2. Go to **Configuration → LLMs.txt Exporter Settings**
   (`/admin/config/llms-txt-exporter`).

## Content types to include

Choose which content types the exporter should list. The file automatically
includes your site name, URL, and description (drawn from Metatag or your site
slogan); this setting decides which content types contribute their recent items.

> Only include content types you're happy to have summarized publicly — the
> `/llms.txt` file is served to LLM crawlers.

## Number of recent items per type

For each included content type, set how many recent items to display. Keep this
modest so the file stays a concise summary rather than a full index.

## Custom keywords

Add any keywords you want to surface to LLMs — terms that describe your site's
topics and help models place your content in context.

## Additional information

Add any extra free‑text information for LLMs — notes about your organization,
scope, or anything else you want models to know when they read the file.

## Save

Save the form, then visit `yoursite.com/llms.txt` to see the result. The file is
generated dynamically, so it reflects your current recent content each time it's
requested. Update these settings whenever you want to change which content types
appear, how many items show, or the keywords and extra information you provide.
