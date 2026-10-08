# Configuration

External Link Update does not have persistent "settings" so much as a **run
form**: you choose what to update, and it processes your content in a batch. You
can trigger the same operation either from the admin UI or from the command line
with Drush.

> **Back up first.** This tool rewrites the stored HTML of your node bodies in
> bulk. Take a database backup before running it on a production site.

## Run it from the admin form

1. Log in as a user with the **Access administration pages** permission.
2. Go to **Configuration → External Link Update** (`/admin/config/elink-update`).
3. Choose the options:
   - **Content types** — tick the content types whose body fields you want to
     scan.
   - **Link target** — pick one of `_blank`, `_self`, `_parent`, or `_top` to
     apply to external links.
   - **Link rel attribute** *(optional)* — choose `nofollow`, `noreferrer`, and/or
     `noopener` to add alongside the target.
4. Submit the form. Drupal runs a batch that loads each selected node, rewrites
   the external `<a>` tags in its body, and re‑saves the node, showing progress as
   it goes.

## Run it from Drush

The same batch is available headless, which is convenient when the team has no way
to trigger the form or when you want it in a deployment script:

```bash
drush elink-update:find-external-link
```

This builds and runs the same update batch from the command line.

## What it changes (and what it doesn't)

- It adds the chosen `target` and `rel` attributes to **external** links found in
  node **body** fields, then re‑saves the affected nodes.
- It does **not** change link destinations, and it leaves internal links alone.
- **Caveat:** if a text format has "Limit allowed HTML tags and correct faulty
  HTML" enabled, anchor links in content using that format will not be updated.

## Verify

After the run finishes, open one of the affected nodes and inspect an external
link in its body — it should now carry your chosen `target` and any `rel`
attributes you selected.
