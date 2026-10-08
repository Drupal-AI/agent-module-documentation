# Configuration

Everything this module does is driven from one settings form, where you type the
content of your `llms.txt` file. Whatever you save there is served, verbatim, at
`/llms.txt`.

## Open the settings form

1. Log in as a user who has the **Administer llms.txt** permission
   (`administer llmstxt`). The module deliberately uses its own permission rather
   than reusing *Administer site configuration*, so editing the file can be
   delegated to a content or SEO role without granting broad admin rights.
2. Go to **Configuration → Search and metadata → llms.txt**, or navigate directly
   to `/admin/config/search/llmstxt`.

## Write the file content

The form provides a text area for the body of your `llms.txt`. Follow the
`llms.txt` convention: write it as Markdown that describes the site, points to
the canonical documentation, and highlights the pages most worth reading. A
typical file names the site, gives a one‑line summary, and then lists the key
pages (optionally linking to Markdown versions of them) so a model retrieving
your site gets a curated map rather than inferring one from navigation. You can
read more about the format at [llmstxt.org](https://llmstxt.org).

The form also lets you control whether the file is **enabled** — the switch that
determines whether `/llms.txt` is published at all.

## Save and check

Click **Save configuration**, then open `https://yoursite.com/llms.txt` in a
browser to confirm it serves what you wrote. Because the content lives in
configuration, you can update it any time from this form without a code release,
and it will be included when you export configuration with `drush cex`.

## A note on what this does and does not do

`llms.txt` is advisory only — it tells cooperating AI crawlers what you would
like them to read first, and enforces nothing. If your goal is to stop AI systems
from accessing content, you need real access control or blocking, not this file.
