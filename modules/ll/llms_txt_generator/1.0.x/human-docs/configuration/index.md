# Configuration

The generated `llms.txt` is controlled from a single settings form. This is where
you decide whether the file is served at all and which of your content it lists.

## Open the settings form

1. Log in as a user who has the **Administer LLMs.txt Generator** permission
   (`administer llms txt generator`). This is a dedicated, access‑restricted
   permission — grant it deliberately rather than assuming an editor already has
   it.
2. Go to **Configuration → Search and metadata → LLMs.txt Generator**, or
   navigate directly to `/admin/config/search/llms-txt-generator`.

## What you can set

The form lets you:

- **Enable or disable the file.** When enabled, the module serves the generated
  content at `/llms.txt`; when disabled, the file is not published. This is the
  master on/off switch.
- **Choose which content is included.** Rather than dumping every page, the
  generator lets you curate what a model sees — typically by selecting the
  content types or sections that best describe your site. Review these choices:
  the whole point of `llms.txt` is guidance, so a tight, meaningful listing is
  more useful than an exhaustive one.

Because the file is generated from live content, the listing updates as your
content changes — you do not need to edit the file by hand after a content
restructure, and you do not need a code deployment to refresh it.

## Save and check

Click **Save configuration**, then open `https://yoursite.com/llms.txt` in a
browser to confirm the output looks the way you intend. Re-visit the form
whenever you add or reorganise content types and want to adjust what the file
advertises.

## A note on what this does and does not do

`llms.txt` is advisory only. It tells cooperating AI crawlers what you would like
them to read first — it does **not** block or restrict anyone. If your goal is to
stop AI systems from accessing content, you need real access control (permissions,
authentication, or blocking), not this file.
