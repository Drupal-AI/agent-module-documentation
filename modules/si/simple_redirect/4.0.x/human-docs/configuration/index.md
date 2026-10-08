# Configuration

Simple Redirect has no global settings — you configure it purely by creating
individual redirects. Each one is a small piece of configuration with a "from"
path and a "to" path.

## Open the redirect list

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Search and metadata → Simple Redirect**, or navigate
   directly to `/admin/config/search/simple-redirect`.

You'll land on a list of any redirects you've already created, with an **Add
Simple Redirect** button.

## Add a redirect

Click **Add Simple Redirect** and fill in the form:

- **Title** — a label for your own reference so you can recognize the redirect in
  the list later.
- **From** — the internal path that should be redirected, for example `/old-page`.
  It **must start with a slash**. You cannot redirect from the front page
  (`<front>`), and the path may not contain an anchor fragment (a `#…` part). If
  you enter a path that already has a redirect, the form will stop you — duplicate
  "from" paths are not allowed. You may use a URL alias here as well as a raw
  system path.
- **To** — where visitors should be sent instead, for example `/new-page`. This is
  resolved as an internal path, so the redirect always points somewhere within
  your own site.

Click **Save**. To confirm it works, open the "from" path in your browser — you
should be forwarded to the "to" path with a permanent (301) redirect.

## Edit or delete a redirect

Back on the list at `/admin/config/search/simple-redirect`, each row offers links
to **edit** or **delete** that redirect. Editing reopens the same form with the
same validation; deleting removes the redirect so the "from" path stops
forwarding.

## A note on how matching works

The redirect fires on an **exact** match of the incoming request path against your
"from" value — it is not a pattern or wildcard match. Each path you want to
redirect needs its own entry. Because the destination is always an internal path
you configured yourself, visitors can never influence where a redirect goes.
